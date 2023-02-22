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
    
    enum SectionType{
        case photo(viewModel : CharacterPhotoCollectionViewCellViewModel)
        case information(viewModels : [CharacterInfoCollectionViewCellViewModel])
        case episodes(viewModels : [CharacterEpisodeCollectionViewCellViewModel])
    }
    
    public var sections : [SectionType] = []
    
    init(character: RMCharacter.RMCharacterResult) {
        self.character = character
        setUpSections()
    }
    
    private func setUpSections(){
        
        sections = [
            .photo(viewModel:  .init(withUrl: URL(string:character.image) ) ) ,
            .information(viewModels: [
                .init(value: character.status.text , title: "Status") ,
                .init(value: character.gender.rawValue , title: "Gender") ,
                .init(value: character.type , title: "Type") ,
                .init(value: character.species , title: "Species") ,
                .init(value: character.origin.name , title: "Orgin") ,
                .init(value: character.location.name , title: "Location") ,
                .init(value: character.created , title: "Created") ,
                .init(value: "\(character.episode.count)" , title: "Total Episodes") ,
            ]),
            .episodes(viewModels: character.episode.compactMap({ episodeUrlStr in
                    .init(withUrl: URL(string: episodeUrlStr))
            }) )
            
        ]
    }
    
}
