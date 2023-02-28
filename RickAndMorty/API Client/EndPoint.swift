//
//  EndPoint.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 28/01/23.
//

import Foundation


@frozen enum EndPoint : String, Hashable, CaseIterable{
    case character
    case location
    case episode
}
