//
//  ExampleGroup.swift
//  SimpleQuickTests
//
//  Created by Phil Chang on 2023/7/17.
//

public class ExampleGroup {
    var description: String
    var parent: ExampleGroup?
    public var localBefores: [(() -> ())] = []
    var localAfters: [(() -> ())] = []
    var groups: [ExampleGroup] = []
    var localExamples: [Example] = []

    public init(_ description: String) {
        self.description = description
    }

    var befores: [(() -> ())] {
    get {
        var closures = localBefores
        walkUp() { (group: ExampleGroup) -> () in
            closures.append(contentsOf: group.localBefores)
        }
        return closures.reversed()
    }
    }

    var afters: [(() -> ())] {
    get {
        var closures = localAfters
        walkUp() { (group: ExampleGroup) -> () in
            closures.append(contentsOf: group.localAfters)
        }
        return closures
    }
    }

    public var examples: [Example] {
    get {
        var examples = localExamples
        for group in groups {
            examples.append(contentsOf: group.examples)
        }
        return examples
    }
    }

    public func run() {
        for example in localExamples {
            example.run()
        }

        for group in groups {
            group.run()
        }
    }

    func walkUp(callback: (_ group: ExampleGroup) -> ()) {
        var group = self
        while let parent = group.parent {
            callback(parent)
            group = parent
        }
    }

    func walkDownExamples(_ callback: (_ example: Example) -> ()) {
        for example in localExamples {
            callback(example)
        }
        for group in groups {
            group.walkDownExamples(callback)
        }
    }

    public func appendExampleGroup(group: ExampleGroup) {
        group.parent = self
        groups.append(group)
    }

    public func appendExample(example: Example) {
        example.group = self
        localExamples.append(example)
    }
}
