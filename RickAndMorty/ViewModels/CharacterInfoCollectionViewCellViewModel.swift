//
//  CharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 21/02/23.
//

import UIKit

final class CharacterInfoCollectionViewCellViewModel{
    
    private let type : `Type`
    private let value : String
    
    static let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        return formatter
    }()
    
    static let shortDateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        return formatter
    }()
    
    public var title : String {
        self.type.displayTitle
    }
    
    public var displayValue : String {
        guard !value.isEmpty else{return "None"}
        if type == .created , let date = Self.dateFormatter.date(from:value){
            return Self.shortDateFormatter.string(from: date)
        }
        return value
    }
    
    public var iconImage : UIImage? {
        return type.iconImage
    }
    
    public var tintColor : UIColor {
        return type.tintColor
    }
    
    
    enum `Type` : String{
        case status
        case gender
        case type
        case species
        case orgin
        case location
        case created
        case totalEpisodes
        
        var displayTitle : String {
            switch self{
            case .status,
                    .gender ,
                    .type,
                    .species,
                    .orgin,
                    .location,
                    .created:
                return rawValue.uppercased()
            case .totalEpisodes:
                return "TOTAL EPISODES"
            }
        }
        
        var iconImage : UIImage? {
            switch self{
            case .status:
                return UIImage(systemName: "highlighter")
            case .gender:
                return UIImage(systemName: "highlighter")
            case .type:
                return UIImage(systemName: "highlighter")
            case .species:
                return UIImage(systemName: "highlighter")
            case .orgin:
                return UIImage(systemName: "highlighter")
            case .location:
                return UIImage(systemName: "highlighter")
            case .created:
                return UIImage(systemName: "highlighter")
            case .totalEpisodes:
                return UIImage(systemName: "highlighter")
            }
        }
        
        var tintColor : UIColor {
            switch self{
            case .status:
                return  UIColor(red: CGFloat.random(in: 0.5...1) , green: CGFloat.random(in: 0.5...1), blue: CGFloat.random(in: 0.5...1), alpha: 1)
            case .gender:
                return UIColor(red: CGFloat.random(in: 0.5...1) , green: CGFloat.random(in: 0.5...1), blue: CGFloat.random(in: 0.5...1), alpha: 1)
            case .type:
                return UIColor(red: CGFloat.random(in: 0.5...1) , green: CGFloat.random(in: 0.5...1), blue: CGFloat.random(in: 0.5...1), alpha: 1)
            case .species:
                return UIColor(red: CGFloat.random(in: 0.5...1) , green: CGFloat.random(in: 0.5...1), blue: CGFloat.random(in: 0.5...1), alpha: 1)
            case .orgin:
                return UIColor(red: CGFloat.random(in: 0.5...1) , green: CGFloat.random(in: 0.5...1), blue: CGFloat.random(in: 0.5...1), alpha: 1)
            case .location:
                return UIColor(red: CGFloat.random(in: 0.5...1) , green: CGFloat.random(in: 0.5...1), blue: CGFloat.random(in: 0.5...1), alpha: 1)
            case .created:
                return UIColor(red: CGFloat.random(in: 0.5...1) , green: CGFloat.random(in: 0.5...1), blue: CGFloat.random(in: 0.5...1), alpha: 1)
            case .totalEpisodes:
                return UIColor(red: CGFloat.random(in: 0.5...1) , green: CGFloat.random(in: 0.5...1), blue: CGFloat.random(in: 0.5...1), alpha: 1)
            }
        }
        
    }
    
    
    init(type : `Type`, value : String){
        self.type = type
        self.value = value
    }
}
