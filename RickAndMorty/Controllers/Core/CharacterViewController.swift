//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 28/01/23.
//

import UIKit

final class CharacterViewController: UIViewController {
    
    private let characterListView = CharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .automatic
        setUpViews()
    }
    
    func setUpViews(){
        characterListView.delegate = self
        view.addSubview(characterListView)
        
        NSLayoutConstraint.activate([
            characterListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            characterListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension CharacterViewController : CharacterListViewDelegate{
    func itemSelected(character: RMCharacter.RMCharacterResult) {
        let vm = CharacterDetailViewModel(character: character)
        let detailVC = CharacterDetailViewController(viewModel: vm)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
