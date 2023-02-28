//
//  SearchViewController.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 26/02/23.
//

import UIKit


final class SearchViewController : UIViewController{
    
    struct Config{
        enum `Type`{
            case character,location,episode
        }
        let type : `Type`
    }
    
    private let config : Config
    
    init(config : Config){
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not Supported")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
    }
}
