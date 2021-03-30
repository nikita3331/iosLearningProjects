//
//  Tip.swift
//  demoApp
//
//  Created by Mykyta Brazhynskyy on 30/03/2021.
//

import Foundation
struct Tip: Decodable{
    let text : String
    let children: [Tip]?
}
