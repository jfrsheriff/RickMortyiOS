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
    
    public let httpMethod = "GET"
    
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
    
    public var urlRequest : URLRequest?{
        guard let url = url else{return nil}
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        return request
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
    
    
    convenience init? (with url : URL){
        let urlStr = url.absoluteString
        guard urlStr.contains(Constants.baseUrl) else{
            return nil
        }
        let path = urlStr.replacingOccurrences(of: Constants.baseUrl + "/" , with: "")
        
        if path.contains("/"){
            let components = path.components(separatedBy: "/")
            if !components.isEmpty, let endPoint = EndPoint(rawValue: components[0]) {
                var pathComponents : [String] = []
                if components.count > 1 {
                    pathComponents = Array(components[1...])
                }
                self.init(endPoint: endPoint,pathComponents: pathComponents)
                return
            }
        }else if path.contains("?"){
            let components = path.components(separatedBy: "?")
            if components.count >= 2 {
                if let endPoint = EndPoint(rawValue: components[0]) {
                    
                    let queryItems : [URLQueryItem] = components[1].components(separatedBy: "&").compactMap{
                        let query = $0.components(separatedBy: "=")
                        if query.count != 2 {return nil}
                        return URLQueryItem(name: query[0], value: query[1])
                    }
                    
                    self.init(endPoint: endPoint, queryParams: queryItems)
                    return
                }
            }
        }
        return nil
    }
}


extension Request{
    static let listCharacterReq = Request(endPoint: .character)
    static let listLocationReq = Request(endPoint: .location)
    static let listEpisodeReq = Request(endPoint: .episode)
}
