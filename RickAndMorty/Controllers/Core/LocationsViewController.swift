//
//  LocationsViewController.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 28/01/23.
//

import UIKit

final class LocationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Locations"
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .automatic
        addSearchButton()
    }
    
    private func addSearchButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchAction))
    }
    
    @objc private func searchAction(){
        
    }
}
