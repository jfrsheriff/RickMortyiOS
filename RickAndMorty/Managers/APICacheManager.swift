//
//  APICacheManager.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 25/02/23.
//

import Foundation

final class APICacheManager {
    
    private var cache : [ EndPoint : NSCache<NSString,NSData>] = [:]
    
    init() {
        setUpCache()
    }
    
    private func setUpCache(){
        EndPoint.allCases.forEach{
            cache[$0] = NSCache<NSString,NSData>()
        }
    }
    
    func getCachedData(for endPoint : EndPoint, url : URL?) -> Data?{
        guard let cachedResult = cache[endPoint], let url = url else {return nil}
        let key = url.absoluteString as NSString
        let val = cachedResult.object(forKey: key)
        return  val as? Data
     }
    
    func setCache(for endPoint : EndPoint, url : URL?, data : Data){
        guard let cachedResult = cache[endPoint], let url = url else {return}
        let key = url.absoluteString as NSString
        let val = data as NSData
        cachedResult.setObject(val, forKey: key)
     }
    
}
