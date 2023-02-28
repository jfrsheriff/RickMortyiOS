//
//  EpisodeDetailsView.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 25/02/23.
//

import UIKit


final class EpisodeDetailsView : UIView{
    
    private var viewModel : EpisodeDetailViewModel? {
        didSet{
            dataLoaded()
        }
    }
    
    
    private let spinner : UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    private var collectionView : UICollectionView?
    
    required init?(coder: NSCoder) {
        fatalError("Not Supported")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        
        let collectionView = getCollectionView()
        addSubviews(collectionView,spinner)
        self.collectionView = collectionView
        addConstraint()
        spinner.startAnimating()
    }
    
    
    private func addConstraint(){
        
        guard let collectionView = collectionView else {return}
        
        NSLayoutConstraint.activate([
            spinner.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            spinner.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            spinner.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            spinner.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    public func configure(with viewModel : EpisodeDetailViewModel) {
        DispatchQueue.main.async {
            self.viewModel = viewModel
        }
    }
    
    private func getCollectionView() -> UICollectionView{
        let layout = UICollectionViewCompositionalLayout { section, _ in
            return self.getLayoutFor(section)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHidden = true
        collectionView.alpha = 0
        
        collectionView.register(EpisodeInfoCollectionViewCell.self, forCellWithReuseIdentifier: EpisodeInfoCollectionViewCell.cellId)
        collectionView.register(RMCollectionViewCell.self, forCellWithReuseIdentifier: RMCollectionViewCell.cellID)
        
        return collectionView
    }
    
    private func dataLoaded(){
        spinner.stopAnimating()
        collectionView?.isHidden = false
        collectionView?.reloadData()
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.collectionView?.alpha = 1
        }
    }
}


extension EpisodeDetailsView : UICollectionViewDelegate , UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.cellViewModel.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = viewModel?.cellViewModel else {return 0}
        let sectionType = sections[section]
        switch sectionType {
        case .information(let infoViewModels):
            return infoViewModels.count
        case .characters(let characterViewModels):
            return characterViewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let sections = viewModel?.cellViewModel else {
            fatalError()
        }
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .information(let infoViewModels):
            let cellViewModel = infoViewModels[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeInfoCollectionViewCell.cellId, for: indexPath) as?  EpisodeInfoCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: cellViewModel)
            return cell
        case .characters(let characterViewModels):
            
            let cellViewModel = characterViewModels[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCollectionViewCell.cellID, for: indexPath) as?  RMCollectionViewCell else {
                fatalError()
            }
            cell.configureWithViewModel(cellViewModel)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}



extension EpisodeDetailsView {
    
    private func getLayoutFor(_ section : Int) -> NSCollectionLayoutSection {
        guard let viewModelSections = viewModel?.cellViewModel else {return createInfoLayout()}
        let sectionType = viewModelSections[section]
        switch sectionType {
        case .information:
            return createInfoLayout()
        case .characters:
            return createCharacterLayout()
        }
    }
    
    private func createInfoLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                             heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                        heightDimension: .absolute(100)),
                                                     subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createCharacterLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                                             heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                        heightDimension: .absolute(250)),
                                                     subitems: [item,item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
}
