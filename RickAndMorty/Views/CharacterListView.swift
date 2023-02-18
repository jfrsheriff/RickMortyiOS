//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 06/02/23.
//

import UIKit

protocol CharacterListViewDelegate:AnyObject{
    func itemSelected(character : RMCharacter.RMCharacterResult)
}

final class CharacterListView : UIView {
    
    private let viewModel = CharacterListViewModel()
    
    public weak var delegate : CharacterListViewDelegate? = nil
    
    private let loader : UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 40, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.bounces = true
        collectionView.register(RMCollectionViewCell.self,
                                forCellWithReuseIdentifier:RMCollectionViewCell.cellID)
        collectionView.register(FooterLoadingReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: FooterLoadingReusableView.reusabelID)
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false

        addSubviews(loader,collectionView)
        
        loader.startAnimating()
        addConstraints()
        configureCollectionView()
        
        viewModel.delegate = self
        viewModel.fetchCharacter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints(){
        
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
    
    func configureCollectionView(){
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
    }
}


extension CharacterListView : CharacterListViewModelDelegate{
    
    func initialCharacterLoaded() {
        loader.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()
        
        UIView.animate(withDuration: 0.5) {
            self.collectionView.alpha = 1
        }
    }
    
    func itemSelected(character: RMCharacter.RMCharacterResult) {
        delegate?.itemSelected(character: character)
    }
    
    func additionalCharactersLoaded(with newIndexPaths: [IndexPath]) {
        collectionView.performBatchUpdates {
            collectionView.insertItems(at: newIndexPaths)
        }
    }
    
}
