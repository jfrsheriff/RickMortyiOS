//
//  ImageLoader.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 18/02/23.
//

import Foundation


final class ImageManager{
    
    static let shared = ImageManager()
    private var cache = NSCache<NSString,NSData>()
    
    
    func fetchImage(url: URL, completion : @escaping (Result<Data,Error>) -> Void) {
        let key = url.absoluteString as NSString
        if let eVal = cache.object(forKey: key){
            completion(.success(eVal as Data))
            return
        }
        
        let req = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: req) { [weak self] data, _, error in
            guard let data = data else{
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            if let error = error{
                completion(.failure(error))
            }
            self?.cache.setObject(data as NSData, forKey: key)
            completion(.success(data))
        }
        task.resume()
    }
}
