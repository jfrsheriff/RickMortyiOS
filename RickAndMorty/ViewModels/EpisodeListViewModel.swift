//
//  EpisodeListViewModel.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 25/02/23.
//

import UIKit

protocol EpisodeListViewModelDelegate : AnyObject{
    func initialEpisodeLoaded()
    func additionalEpisodesLoaded(with newIndexPaths: [IndexPath])
    func itemSelected(episode : RMEpisode)
}

final class EpisodeListViewModel : NSObject {
    
    public weak var delegate: EpisodeListViewModelDelegate?
    
    private var isLoadingMoreEpisodes = false
    
    public var shouldShowLoadMoreIndicator : Bool {
        return info?.next != nil
    }
    
    private var curNoOfItems = 0
    
    private let borderColors : [UIColor] = [
        UIColor.systemRed,
        UIColor.systemMint,
        UIColor.systemOrange,
        UIColor.systemBlue,
        UIColor.systemCyan,
        UIColor.systemPink,
        UIColor.systemTeal,
        UIColor.systemGreen,
        UIColor.systemBrown,
        UIColor.systemIndigo
    ]
    
    private var episodes : [RMEpisode] = [] {
        didSet{
            for index in curNoOfItems..<episodes.count{
                let episode = episodes[index]
                let vm = CharacterEpisodeCollectionViewCellViewModel(withUrl: URL(string:episode.url),
                                                                     borderColor: borderColors.randomElement() ?? .systemRed )
                viewModel.append(vm)
            }
            curNoOfItems = episodes.count
        }
    }
    
    private var info :  RMGetAllEpisodesResponse.Info?
    
    private var viewModel : [CharacterEpisodeCollectionViewCellViewModel] = []
    
    func fetchEpisodes(){
        let req = Request(endPoint: .episode)
        Service.shared.execute(req, expection: RMGetAllEpisodesResponse.self) {[weak self] result in
            switch result {
            case .success(let model):
                self?.episodes = model.results
                self?.info = model.info
                DispatchQueue.main.async {
                    self?.delegate?.initialEpisodeLoaded()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    
    func fetchAdditionalEpisodes(url : URL){
        guard !isLoadingMoreEpisodes else{return}
        isLoadingMoreEpisodes = true
        guard let req = Request(with: url) else {
            isLoadingMoreEpisodes = false
            return
        }
        
        Service.shared.execute(req, expection: RMGetAllEpisodesResponse.self) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let model):
                let moreResults = model.results
                self.info = model.info
                
                let total = self.episodes.count + moreResults.count
                let indexPaths = Array(self.episodes.count ..< total).map {IndexPath(row: $0, section: 0)}
                
                self.episodes.append(contentsOf: moreResults)
                DispatchQueue.main.async {
                    self.delegate?.additionalEpisodesLoaded(with: indexPaths)
                    self.isLoadingMoreEpisodes = false
                }
                
            case .failure(let failure):
                self.isLoadingMoreEpisodes = false
            }
        }
    }
}



extension EpisodeListViewModel : UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterEpisodeCollectionViewCell.cellId, for: indexPath) as? CharacterEpisodeCollectionViewCell else{fatalError("Cell Not Supported")}
        cell.configure(viewModel[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bound = UIScreen.main.bounds
        let width = (bound.width - 20)
        return CGSize(width: width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.itemSelected( episode: episodes[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter , shouldShowLoadMoreIndicator else{
            fatalError("UnSupported")
        }
        
        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                           withReuseIdentifier: FooterLoadingReusableView.reusabelID,
                                                                           for: indexPath) as? FooterLoadingReusableView else {
            fatalError("UnSupported")
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return CGSize.zero
        }
        
        return CGSize(width: collectionView.frame.size.width, height: 100)
    }
}



extension EpisodeListViewModel : UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator ,
              !isLoadingMoreEpisodes,
              let urlStr = info?.next,
              let url = URL(string:urlStr),
              !viewModel.isEmpty else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [weak self] timer in
            let yOffset = scrollView.contentOffset.y
            let height = scrollView.frame.size.height
            let contentHeight = scrollView.contentSize.height
            
            if yOffset >= (contentHeight -  height - 120) {
                self?.fetchAdditionalEpisodes( url : url)
            }
            timer.invalidate()
        }
    }
}
