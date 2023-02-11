//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 06/02/23.
//

import UIKit

protocol CharacterListViewModelDelegate : AnyObject{
    func initialCharacterLoaded()
    func itemSelected(character : RMCharacter.RMCharacterResult)
}

final class CharacterListViewModel : NSObject {
    
    public weak var delegate:CharacterListViewModelDelegate?
    
    private var characters : [RMCharacter.RMCharacterResult] = [] {
        didSet{
            characters.forEach { character in
                let vm = RMCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImgUrl: URL(string:character.image) )
                viewModel.append(vm)
            }
        }
    }
    
    
    private var viewModel : [RMCollectionViewCellViewModel] = []
    
    
    func fetchCharacter(){
        let req = Request(endPoint: .character)
        Service.shared.execute(req, expection: RMCharacter.self) {[weak self] result in
            switch result {
            case .success(let model):
                let res = model.results
                self?.characters = res
                DispatchQueue.main.async {
                    self?.delegate?.initialCharacterLoaded()
                }
                print(model)
            case .failure(let failure):
                print(failure)
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
    
}
