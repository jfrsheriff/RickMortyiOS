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
    
    private var url : URL? {
        URL(string:character.url)
    }
    
    public var episodes : [String]{
        character.episode
    }
    
    enum SectionType{
        case photo(viewModel : CharacterPhotoCollectionViewCellViewModel)
        case information(viewModels : [CharacterInfoCollectionViewCellViewModel])
        case episodes(viewModels : [CharacterEpisodeCollectionViewCellViewModel])
    }
    
    public var         sections : [SectionType] = []
    
    init(character: RMCharacter.RMCharacterResult) {
        self.character = character
        setUpSections()
    }
    
    private func setUpSections(){
        
        sections = [
            .photo(viewModel:  .init(withUrl: URL(string:character.image) ) ) ,
            .information(viewModels: [
                .init(type: .status, value: character.status.text),
                .init(type: .gender, value: character.gender.rawValue),
                .init(type: .type, value: character.type),
                .init(type: .species, value: character.species),
                .init(type: .orgin, value: character.origin.name),
                .init(type: .location, value: character.location.name),
                .init(type: .created, value: character.created),
                .init(type: .totalEpisodes, value: String(character.episode.count))
            ]),
            .episodes(viewModels: character.episode.compactMap({ episodeUrlStr in
                    .init(withUrl: URL(string: episodeUrlStr))
            }) )
            
        ]
    }
    
}
