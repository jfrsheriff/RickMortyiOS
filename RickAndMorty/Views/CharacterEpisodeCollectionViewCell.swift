//
//  CharacterEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 21/02/23.
//

import UIKit

final class CharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let cellId = "CharacterEpisodeCollectionViewCell"
    
    private let seasonLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
         label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let airDateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        setUpLayer()
        contentView.addSubviews(seasonLabel,nameLabel,airDateLabel)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not Supported")
    }
    
    private func setUpLayer(){
        contentView.layer.cornerRadius = 8
        contentView.layer.borderColor = UIColor.systemMint.cgColor
        contentView.layer.borderWidth = 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        seasonLabel.text = nil
        nameLabel.text = nil
        airDateLabel.text = nil     }
    
    private func setUpConstraints(){
        NSLayoutConstraint.activate([
        
            seasonLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            seasonLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            seasonLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            seasonLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
         
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            nameLabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor, constant: 5),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
             
            airDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            airDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
//            airDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            airDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
         
        ])
    }
    
    public func configure(_ viewModel : CharacterEpisodeCollectionViewCellViewModel){
        viewModel.register { [weak self] episode in
            
            self?.nameLabel.text = episode.name
            self?.seasonLabel.text = "Episode : " + episode.episode
            self?.airDateLabel.text = "Aired On : " + episode.air_date
        }
        viewModel.fetch()
        contentView.layer.borderColor = viewModel.borderColor.cgColor
    }
    
}
