//
//  Poet.swift
//  SimpleQuickTests
//
//  Created by Phil Chang on 2023/7/19.
//

class Poet: Person {
    override var greeting: String {
        get {
            if isHappy {
                return "Oh, joyous day!"
            } else {
                return "Woe is me!"
            }
        }
    }
}
