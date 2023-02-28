//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 06/02/23.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    private let viewModel : CharacterDetailViewModel
    
    private let detailView : CharacterDetailsView
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        detailView = CharacterDetailsView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        configure()
        addShareButton()
    }
    
    private func addShareButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareAction))
    }
    
    @objc private func shareAction(){
        
    }
    
    private func configure(){
        
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
        
        view.addSubview(detailView)
        
        NSLayoutConstraint.activate([
            detailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}


extension CharacterDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = viewModel.sections[section]
        
        switch section {
        case .photo:
            return 1
        case .information(let viewModels):
            return viewModels.count
        case .episodes(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel.sections[indexPath.section]
        switch section {
        case .photo(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterPhotoCollectionViewCell.cellId,
                                                                for: indexPath) as? CharacterPhotoCollectionViewCell else{
                fatalError("Cell Not Found")
            }
            cell.configure(viewModel)
            return cell
        case .information(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterInfoCollectionViewCell.cellId,
                                                                for: indexPath) as? CharacterInfoCollectionViewCell else{
                fatalError("Cell Not Found")
            }
            cell.configure(viewModels[indexPath.row])
            return cell
        case .episodes(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterEpisodeCollectionViewCell.cellId,
                                                                for: indexPath) as? CharacterEpisodeCollectionViewCell else{
                fatalError("Cell Not Found")
            }
            cell.configure(viewModels[indexPath.row])
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = viewModel.sections[indexPath.section]
        switch section {
        case .photo,.information:
            break
        case .episodes:
            let episode = viewModel.episodes[indexPath.row]
            let episodeDetailVC = EpisodeDetailsViewController(url: URL(string: episode))
            self.navigationController?.pushViewController(episodeDetailVC, animated: true)
          
        }
    }
    
}
