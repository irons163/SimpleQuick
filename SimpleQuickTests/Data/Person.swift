//
//  Person.swift
//  SimpleQuickTests
//
//  Created by Phil Chang on 2023/7/17.
//

import Foundation

class Person {
    var isHappy = true
    var isHungry = false
    var isSatisfied = false
    var hopes = ["winning the lottery", "going on a blimp ride"]
    var greeting: String {
        get {
            if isHappy {
                return "Hello!"
            } else {
                return "Oh, hi."
            }
        }
    }

    func eatChineseFood() {
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.milliseconds(500)) {
            self.isHungry = true
        }
    }
}
