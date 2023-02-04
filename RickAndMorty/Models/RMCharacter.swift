//
//  RMCharacter.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 03/02/23.
//

import Foundation

struct RMCharacter : Codable{
    let id: Int
    let name: String
    let status: RMCharacterStatus
    let species: String
    let type: String
    let gender: RMGender
    let origin: RMOrgin
    let location: RMSingleLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum RMCharacterStatus : String, Codable{
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
}

enum RMGender : String, Codable{
    case male = "Male"
    case female = "Female"
    case gender = "Genderless"
    case `unknown` = "unknown"
}

struct RMOrgin : Codable{
    let name : String
    let url : String
}

struct RMSingleLocation : Codable{
    let name : String
    let url : String
}

