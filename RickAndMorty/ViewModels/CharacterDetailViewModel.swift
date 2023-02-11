//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 06/02/23.
//

import Foundation


final class CharacterDetailViewModel{
    
    private let character : RMCharacter.RMCharacterResult
    
    public var title : String{
        character.name
    }
    
    init(character: RMCharacter.RMCharacterResult) {
        self.character = character
    }
}
