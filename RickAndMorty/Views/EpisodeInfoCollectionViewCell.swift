//
//  EpisodeInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 27/02/23.
//

import UIKit

final class EpisodeInfoCollectionViewCell: UICollectionViewCell {
    static let cellId = "EpisodeInfoCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        
        setUpLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not Supported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setUpLayer(){
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    public func configure(with viewModel : EpisodeInfoCollectionViewCellViewModel){
        
    }
}
