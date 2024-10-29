//
//  World.swift
//  SimpleQuick
//
//  Created by Phil Chang on 2023/7/25.
//  Copyright © 2023 Yahoo. All rights reserved.
//        

import Foundation

var specs: Dictionary<String, ExampleGroup> = [:]
var _beforeSuite: [(() -> ())] = []
var _beforeSuiteNotRunYet = true
var _afterSuite: [(() -> ())] = []
var _afterSuiteNotRunYet = true

func runBeforeSpec() {
    assert(_beforeSuiteNotRunYet, "runBeforeSuite was called twice")
    for closure in _beforeSuite {
        closure()
    }
    _beforeSuiteNotRunYet = false
}

func runAfterSpec() {
    assert(_afterSuiteNotRunYet, "runAfterSuite was called twice")
    for closure in _afterSuite {
        closure()
    }
    _afterSuiteNotRunYet = false
}

var exampleCount: Int {
    get {
        var count = 0
        for (_, group) in specs {
            group.walkDownExamples { (example: Example) -> () in
                count += 1
            }
        }
        return count
    }
}
