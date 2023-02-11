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
    private init(){}
    
    func execute<T:Codable>( _ request : Request, expection type : T.Type, completion: @escaping (Result<T,Error>) -> Void){
        guard let urlRequest = request.urlRequest else {
            completion(.failure(ServiceError.failedToCreateRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _ , error in
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
                print(model)
                completion(.success(model))
            }catch{
                print(error )
            }
                
        }
        task.resume()
    }
    
}

 
 
