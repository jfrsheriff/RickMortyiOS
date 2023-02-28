//
//  Service.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 28/01/23.
//

import Foundation


final class Service{

    enum ServiceError : Error{
        case failedToCreateRequest
        case failedToGetData
    }
    
    static let shared = Service()
    private let cacheManager = APICacheManager()
    
    private init(){}
    
    func execute<T:Codable>( _ request : Request, expection type : T.Type, completion: @escaping (Result<T,Error>) -> Void){
        
        if let cachedData = cacheManager.getCachedData(for: request.endPoint, url: request.url){
            do{
                let model = try JSONDecoder().decode(type, from: cachedData)
                print("Fetched From Cache")
                completion(.success(model))
                
            }catch{
                completion(.failure(error))
            }
            return
        }
        
        guard let urlRequest = request.urlRequest else {
             return
        }
        let task = URLSession.shared.dataTask(with: urlRequest) {[weak self] data, _ , error in
            guard let data = data else{
                completion(.failure(ServiceError.failedToGetData))
                return
            }
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do{
                let model = try JSONDecoder().decode(type, from: data)
                self?.cacheManager.setCache(for: request.endPoint, url: request.url, data: data)
                completion(.success(model))
            }catch{
                print(error )
            }
                
        }
        task.resume()
    }
    
}

 
 
