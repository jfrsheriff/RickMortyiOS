//
//  RMEpisode.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 03/02/23.
//

import Foundation

struct RMEpisode:Codable, EpisodeDataRenderer{
    
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    
}
