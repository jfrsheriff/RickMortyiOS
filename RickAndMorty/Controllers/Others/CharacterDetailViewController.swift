//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 06/02/23.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    private let viewModel : CharacterDetailViewModel
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
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
    }

}
