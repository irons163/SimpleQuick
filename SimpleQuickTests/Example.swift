//
//  Example.swift
//  SimpleQuickTests
//
//  Created by Phil Chang on 2023/7/17.
//

var _numberOfExamplesRan = 0

class Example {
    var group: ExampleGroup?
    var description: String
    var closure: () -> ()

    init(_ description: String, _ closure: @escaping () -> ()) {
        self.description = description
        self.closure = closure
    }

    func run() {
        if _numberOfExamplesRan == 0 {
            runBeforeSpec()
        }

        if let group = self.group {
            for before in group.befores {
                before()
            }
        }

        closure()

        if let group = self.group {
            for after in group.afters {
                after()
            }
        }

        _numberOfExamplesRan += 1
        if _numberOfExamplesRan >= exampleCount {
            runAfterSpec()
        }
    }
}
