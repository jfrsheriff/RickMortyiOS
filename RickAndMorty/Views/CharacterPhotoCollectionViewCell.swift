//
//  CharacterPhotoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 21/02/23.
//

import UIKit

final class CharacterPhotoCollectionViewCell: UICollectionViewCell {
    static let cellId = "CharacterPhotoCollectionViewCell"
    
    private var imageView : UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemMint
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not Supported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    private func setUpConstraints(){
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    public func configure(_ viewModel : CharacterPhotoCollectionViewCellViewModel){
        viewModel.fetchImage {[weak self] result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: success)
                }
            case .failure(let failure):
                print("Image Fetching Error : \(failure.localizedDescription)")
            }
        }
    }
    
}
