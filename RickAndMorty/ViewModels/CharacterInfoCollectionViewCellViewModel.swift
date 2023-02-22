//
//  CharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 21/02/23.
//

import Foundation

final class CharacterInfoCollectionViewCellViewModel{
    
    public let value : String
    public let title : String
    
    init(value : String , title : String){
        self.value = value
        self.title = title
    }
}
