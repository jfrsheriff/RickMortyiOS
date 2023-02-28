//
//  CharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 21/02/23.
//

import UIKit

protocol EpisodeDataRenderer{
    var episode: String {get}
    var name: String {get}
    var air_date: String {get}
}

final class CharacterEpisodeCollectionViewCellViewModel{
        
    private let episodeURL : URL?
    private var isFetched : Bool = false
    private var dataBlock : ((EpisodeDataRenderer) -> ())? = nil
    
    public let borderColor : UIColor
    
    private var episode : RMEpisode?{
        didSet{
            guard let model = episode else {return}
            dataBlock?(model)
        }
    }
    
    init(withUrl url : URL?, borderColor : UIColor =  UIColor.systemRed){
        self.episodeURL = url
        self.borderColor = borderColor
    }
    
    public func register(_ block : @escaping (EpisodeDataRenderer) -> () ){
        self.dataBlock = block
    }
    
    func fetch(){
        guard !isFetched else{
            guard let model = episode else {return}
            dataBlock?(model)
            return
        }
        guard let url = episodeURL , let request = Request(with: url) else {return}
        isFetched = true
        Service.shared.execute(request, expection: RMEpisode.self) {[weak self] result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self?.episode = result
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
 
