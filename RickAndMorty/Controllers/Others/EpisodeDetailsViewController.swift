//
//  EpisodeDetailsViewController.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 24/02/23.
//

import UIKit

final class EpisodeDetailsViewController : UIViewController{
    private var url : URL?
    
    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        view.backgroundColor = .systemOrange
    }
}
