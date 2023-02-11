//
//  RMCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 06/02/23.
//

import UIKit

final class RMCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "RMCollectionViewCell"
    
    private let imgView : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel : UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imgView,nameLabel,statusLabel)
        addConstraints()
        setupLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayer(){
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.secondaryLabel.cgColor
        contentView.layer.shadowOffset = CGSize(width: -2, height: 2)
        contentView.layer.shadowOpacity = 0.4
    }
    
    private func addConstraints(){
        
        NSLayoutConstraint.activate([
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 7),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -7),
            statusLabel.heightAnchor.constraint(equalToConstant: 25),
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -3),
            
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 7),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -7),
            nameLabel.heightAnchor.constraint(equalToConstant: 25),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor),
            
            imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imgView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imgView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3)
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        statusLabel.text = nil
        imgView.image = nil
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupLayer()
    }
    
    public func configureWithViewModel(_ viewModel : RMCollectionViewCellViewModel){
        nameLabel.text = viewModel.characterName
        statusLabel.text = viewModel.characterStatusText
        viewModel.fetchImage(completion: { [weak self] result in
            guard let self = self else{return}
            switch result {
            case .success(let data):
                if let img = UIImage(data: data){
                    DispatchQueue.main.async {
                        self.imgView.image = img
                    }
                }else{
                    
                }
                
            case .failure(let error):
                print(error)
            }
        })
        
    }
}
