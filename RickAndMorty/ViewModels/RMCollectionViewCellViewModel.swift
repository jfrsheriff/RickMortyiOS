//
//  RMCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 06/02/23.
//

import Foundation


struct RMCollectionViewCellViewModel {
    public let characterName : String
    private let characterStatus : RMCharacter.RMCharacterStatus
    private let characterImgUrl : URL?
    
    init(characterName: String, characterStatus: RMCharacter.RMCharacterStatus, characterImgUrl: URL?) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImgUrl = characterImgUrl
    }
    
    public var characterStatusText : String{
        return "Status : \(characterStatus.text)"
    }
    
    public func fetchImage(completion : @escaping (Result<Data,Error>) -> Void) {
        
        guard let url = characterImgUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let req = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: req) { data, _, error in
            guard let data = data else{
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            if let error = error{
                completion(.failure(error))
            }
            completion(.success(data))
        }
        
        task.resume()
    }
}
