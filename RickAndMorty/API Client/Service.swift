//
//  Service.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 28/01/23.
//

import Foundation


final class Service{
    static let shared = Service()
    private init(){}
    
    func execute<T:Codable>( _ request : Request, completion: @escaping (T) -> Void){
        
    }
    
}

