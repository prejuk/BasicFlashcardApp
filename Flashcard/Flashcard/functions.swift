//
//  functions.swift
//  Flashcard
//
//  Created by Preju Kanuparthy on 2/5/24.
//

import Foundation


public func nextCard() -> Int {
    let randomNumber = Int.random(in: 0...2)
    return randomNumber
}
