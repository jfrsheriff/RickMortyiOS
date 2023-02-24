//
//  CharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 21/02/23.
//

import UIKit

final class CharacterInfoCollectionViewCell: UICollectionViewCell {
    static let cellId = "CharacterInfoCollectionViewCell"
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    
    private let valueLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 22, weight: .light)
        return label
    }()
    
    private let iconImgView : UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(systemName: "globe.americas")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    
    private let containerView : UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .secondarySystemBackground
        return container
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not Supported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImgView.image = nil
        titleLabel.text = nil
        valueLabel.text = nil
        iconImgView.tintColor = .label
        titleLabel.textColor = .label
    }
    
    private func setUpConstraints(){
        contentView.addSubviews(containerView,iconImgView,valueLabel)
        containerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            
            iconImgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            iconImgView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 35),
            iconImgView.heightAnchor.constraint(equalToConstant: 30),
            iconImgView.widthAnchor.constraint(equalToConstant: 30),
             
            
            valueLabel.leadingAnchor.constraint(equalTo: iconImgView.trailingAnchor,constant: 10),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: containerView.topAnchor)

        ])
        
        
    }
    
    public func configure(_ viewModel : CharacterInfoCollectionViewCellViewModel){
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.displayValue
        iconImgView.image = viewModel.iconImage
        iconImgView.tintColor = viewModel.tintColor
        titleLabel.textColor = viewModel.tintColor
    }
}
