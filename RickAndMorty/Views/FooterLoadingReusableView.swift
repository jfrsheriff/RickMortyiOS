//
//  FooterLoadingReusableView.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 17/02/23.
//

import UIKit

class FooterLoadingReusableView : UICollectionReusableView{
    static let reusabelID = "FooterLoadingReusableView"
    
    private let loader : UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not Supported")
    }
    
    private func configure(){
        addSubview(loader)
        
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: centerYAnchor),
            loader.widthAnchor.constraint(equalToConstant: 100),
            loader.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func startAnimating(){
        loader.startAnimating()
    }
}
