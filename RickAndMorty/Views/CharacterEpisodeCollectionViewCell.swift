//
//  CharacterEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 21/02/23.
//

import UIKit

final class CharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let cellId = "CharacterEpisodeCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not Supported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setUpConstraints(){
        
    }
    
    public func configure(_ viewModel : CharacterEpisodeCollectionViewCellViewModel){
        
    }
    
}
