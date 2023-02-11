//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 06/02/23.
//

import UIKit

extension UIView{
    func addSubviews( _ views : UIView...){
        views.forEach{addSubview($0)}
    }
}
