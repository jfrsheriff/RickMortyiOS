//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 06/02/23.
//

import UIKit

protocol CharacterListViewModelDelegate : AnyObject{
    func initialCharacterLoaded()
    func additionalCharactersLoaded(with newIndexPaths: [IndexPath])
    
    func itemSelected(character : RMCharacter.RMCharacterResult)
}

final class CharacterListViewModel : NSObject {
    
    public weak var delegate:CharacterListViewModelDelegate?
    
    private var isLoadingMoreCharacters = false
    
    public var shouldShowLoadMoreIndicator : Bool {
        return info?.next != nil
    }
    
    private var curNoOfItems = 0
    
    private var characters : [RMCharacter.RMCharacterResult] = [] {
        didSet{
            for index in curNoOfItems..<characters.count{
                let character = characters[index]
                let vm = RMCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImgUrl: URL(string:character.image) )
                viewModel.append(vm)
            }
            curNoOfItems = characters.count
        }
    }
    
    private var info : RMCharacter.RMCharacterInfo?
    
    private var viewModel : [RMCollectionViewCellViewModel] = []
    
    
    func fetchCharacter(){
        let req = Request(endPoint: .character)
        Service.shared.execute(req, expection: RMCharacter.self) {[weak self] result in
            switch result {
            case .success(let model):
                let res = model.results
                self?.characters = res
                self?.info = model.info
                DispatchQueue.main.async {
                    self?.delegate?.initialCharacterLoaded()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    
    func fetchAdditionalCharacters(url : URL){
        guard !isLoadingMoreCharacters else{return}
        isLoadingMoreCharacters = true
        guard let req = Request(with: url) else {
            isLoadingMoreCharacters = false
            return
        }
        
        Service.shared.execute(req, expection: RMCharacter.self) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let model):
                let moreResults = model.results
                self.info = model.info
                
                let total = self.characters.count + moreResults.count
                let indexPaths = Array(self.characters.count ..< total).map {IndexPath(row: $0, section: 0)}
                
                self.characters.append(contentsOf: moreResults)
                DispatchQueue.main.async {
                    self.delegate?.additionalCharactersLoaded(with: indexPaths)
                    self.isLoadingMoreCharacters = false
                }
                
            case .failure(let failure):
                self.isLoadingMoreCharacters = false
            }
        }
    }
}



extension CharacterListViewModel : UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCollectionViewCell.cellID, for: indexPath) as? RMCollectionViewCell else{fatalError("Cell Not Supported")}
        cell.configureWithViewModel(viewModel[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bound = UIScreen.main.bounds
        let width = (bound.width - 30) / 2
        return CGSize(width: width, height: width*1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.itemSelected(character: characters[indexPath.row])
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



extension CharacterListViewModel : UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator ,
              !isLoadingMoreCharacters,
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
                self?.fetchAdditionalCharacters( url : url)
            }
            timer.invalidate()
        }
    }
}
