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
        addSearchButton()
    }
    
    private func setUpViews(){
        characterListView.delegate = self
        view.addSubview(characterListView)
        
        NSLayoutConstraint.activate([
            characterListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            characterListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addSearchButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchAction))
    }
    
    @objc private func searchAction(){
        let searchVC = SearchViewController(config: .init(type: .character))
        searchVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(searchVC, animated: true)
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
