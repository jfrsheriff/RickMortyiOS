//
//  CharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 21/02/23.
//

import Foundation

final class CharacterEpisodeCollectionViewCellViewModel{
    private let episodeURL : URL?
    
    init(withUrl url : URL? ){
        self.episodeURL = url
    }
}
