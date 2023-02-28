//
//  EpisodeDetailsViewController.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 24/02/23.
//

import UIKit

final class EpisodeDetailsViewController : UIViewController {
    
    private let viewModel : EpisodeDetailViewModel
    private let detailView = EpisodeDetailsView()
    
    init(url: URL?) {
        self.viewModel = .init(episodeURL: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        title = "Episodes"
        viewModel.delegate = self
        viewModel.fetchEpisodeData()
        setUpConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareAction))
    }
    
    private func setUpConstraints(){
        view.addSubview(detailView)
        
        NSLayoutConstraint.activate([
            detailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func shareAction(){
        
    }
}


extension EpisodeDetailsViewController : EpisodeDetailViewModelDelegate{
    func didFetchEpisodeDetails() {
        detailView.configure(with: viewModel)
    }
}
