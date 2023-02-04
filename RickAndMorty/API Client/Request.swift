//
//  Request.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 28/01/23.
//

import Foundation

final class Request{
    private struct Constants{
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    private let endPoint : EndPoint
    private let pathComponents : [String]
    private let queryParams : [URLQueryItem]
    
    public var urlString : String {
        
        var urlStr = Constants.baseUrl
        urlStr += ("/" + endPoint.rawValue)
        
        if !pathComponents.isEmpty{
            pathComponents.forEach {
                urlStr += "/\($0)"
            }
        }
        
        if !queryParams.isEmpty{
            urlStr += "?"
            let queryStr = queryParams.compactMap {
                "\($0.name)=\($0.value ?? "")"
            }.joined(separator: "&")
            urlStr += queryStr
        }
        
        return urlStr
    }
    
    public var url : URL? {
        URL(string: urlString)
    }
    
    public init(
        endPoint : EndPoint,
        pathComponents: [String] = [],
        queryParams: [URLQueryItem] = []
    ) {
        self.endPoint = endPoint
        self.pathComponents = pathComponents
        self.queryParams = queryParams
    }
    
}
