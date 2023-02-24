//
//  CharacterDetailsView.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 18/02/23.
//

import UIKit

final class CharacterDetailsView: UIView {
    
    private let viewModel : CharacterDetailViewModel
    
    let loader : UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    
    public var collectionView : UICollectionView?
    
    init(frame: CGRect, viewModel : CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        configure()
    }

    
    required init?(coder: NSCoder) {
        fatalError("UnSupported")
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        collectionView = getCollectionView()
        
        guard let collectionView = collectionView else {return}
        
        addSubviews(collectionView,loader)
        
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: centerYAnchor),
            loader.widthAnchor.constraint(equalToConstant: 100),
            loader.heightAnchor.constraint(equalToConstant: 100),
            
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func getCollectionView() -> UICollectionView{
        let layout = UICollectionViewCompositionalLayout { sectionIndex , _ in
            return self.createSectionFor(index: sectionIndex)
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.bounces = true
        collectionView.register(CharacterPhotoCollectionViewCell.self,
                                forCellWithReuseIdentifier:CharacterPhotoCollectionViewCell.cellId)
        collectionView.register(CharacterInfoCollectionViewCell.self,
                                forCellWithReuseIdentifier:CharacterInfoCollectionViewCell.cellId)
        collectionView.register(CharacterEpisodeCollectionViewCell.self,
                                forCellWithReuseIdentifier:CharacterEpisodeCollectionViewCell.cellId)
        
        return collectionView
    }
    
    private func createSectionFor(index : Int) -> NSCollectionLayoutSection{
        
        let sections = viewModel.sections
        switch sections[index]{
        case .photo:
            return createPhotoSecion()
        case .information:
            return  createInfoSecion()
        case .episodes:
            return  createEpisodesSecion()
        }
    }
    
    private func createPhotoSecion() -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(layoutSize:
                                            NSCollectionLayoutSize(
                                                widthDimension: .fractionalWidth(1),
                                                heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
    
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:
                                                        NSCollectionLayoutSize(
                                                            widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(0.5) ),
                                                     subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createInfoSecion() -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(layoutSize:
                                            NSCollectionLayoutSize(
                                                widthDimension: .fractionalWidth(0.5),
                                                heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:
                                                        NSCollectionLayoutSize(
                                                            widthDimension: .fractionalWidth(1),
                                                            heightDimension: .absolute(150) ),
                                                     subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    
    private func createEpisodesSecion() -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(layoutSize:
                                            NSCollectionLayoutSize(
                                                widthDimension: .fractionalWidth(1),
                                                heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5)
        
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize:
                                                        NSCollectionLayoutSize(
                                                            widthDimension: .fractionalWidth(0.8),
                                                            heightDimension: .absolute(150) ),
                                                     subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
}
