//
//  CharacterPhotoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 21/02/23.
//

import Foundation


final class CharacterPhotoCollectionViewCellViewModel{
    
    private var photoUrl : URL?
    
    init(withUrl url : URL? ){
        self.photoUrl = url
    }
    
    public func fetchImage(completion: @escaping (Result<Data,Error>) -> Void ){
        guard let photoUrl = photoUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageManager.shared.fetchImage(url: photoUrl, completion: completion)
    }
}
