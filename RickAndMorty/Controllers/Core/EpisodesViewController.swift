//
//  EpisodesViewController.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 28/01/23.
//

import UIKit

final class EpisodesViewController: UIViewController {
    
    private let episodeListView = EpisodeListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episodes"
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .automatic
        setUpViews()
        addSearchButton()
    }
    
    private func setUpViews(){
        episodeListView.delegate = self
        view.addSubview(episodeListView)
        
        NSLayoutConstraint.activate([
            episodeListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            episodeListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    private func addSearchButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchAction))
    }
    
    @objc private func searchAction(){
        
    }
}

extension EpisodesViewController : EpisodeListViewDelegate{
    func itemSelected(episode: RMEpisode) {
        let detailVC = EpisodeDetailsViewController(url: URL(string:episode.url) )
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
