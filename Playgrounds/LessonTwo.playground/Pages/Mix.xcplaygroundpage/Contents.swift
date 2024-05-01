//: [Previous](@previous)

//: # Mix
import Foundation

//: ### Comparison operators
example(of: "Comparison") {
    // All comparison operators return Boolean, i.e. true or false

    // Equal
    print(1 == 1)
    class Person: Equatable {
        static func == (lhs: Person, rhs: Person) -> Bool {
            lhs.name == rhs.name
        }

        let name: String
        init(name: String) {
            self.name = name
        }

    }

    let personCJ = Person(name: "CJ")
    let personSameCJName = Person(name: "CJ")
    let personParker = Person(name: "Parker")
    let personCJReference = personCJ

    // what is the result & why
//    print(personCJ == personSameCJName)
//    print(personCJ == personParker)
//    print(personCJ === personSameCJName)
//    print(personCJ === personCJReference)
}

//: ### Playing with collections
example(of: "Collections") {
    let names = ["0", "1", "two"]

    // We want to create array of Integers from the array of Strings
    // If the string that we want to convert doesn't contain Integer 'nil' is returned
    // As a result we have an array of optional Integers
    // The `$0` is a way to access unnamed parameter because we didn't write anything like "{ number in" as we did in the example above
    let optionalInts = names.map({ Int($0) })
    print(optionalInts)
    print(type(of: optionalInts))

    // When we use `compactMap` instead of `map`, all `nil` values are removed and the resulting array is array of Integers instead of optional Integers
    let ints = names.compactMap({ Int($0) })
    print(ints)
    print(type(of: ints))
}

//: ### Functional programming
example(of: "Functional programming") {
    let array = Array(0...100)

    // You can combine as many functions as you want
    let magic = array
        // Multiply each element by 2
        .map({ $0 * 2 })
        // Choose only those elements that are dividable by 2
        .filter({ ($0 % 2) == 0 })
        // Shuffle the elements
        .shuffled()

    print(magic)
}

//: ### Functional vs. on-place methods
example(of: "Functional vs. on-place methods") {
    let array = Array(0...10).shuffled()

    // Create new array where the elements are sorted but keep the original array untouched
    let sortedArray = array.sorted()
    print(array)
    print(sortedArray)

    var arrayToBeSorted = Array(0...10).shuffled()
    // Sort the existing array
    // `arrayToBeSorted` must be `var` because we modify it
    arrayToBeSorted.sort()
    print(arrayToBeSorted)
}

//: ### Accessory types
struct Assignment {
    // Fileprivate restricts the use of an entity to its own defining source file and to any file in the same module that explicitly imports that file.
    fileprivate var cantBeUsedAnywhere: Bool
    // Private properties (and functions) can be neither accessed nor modified from outside of the object
    private var id: String
    // Internal is the default access control level, you don't need to write it to the definition
    // Internal properties (and functions) can be accessed and modified from outside of the object
    internal var title: String
    // Private(set) means that only the option to set (i.e. modify) the property is private
    // In other words we can access the property from outside but we cannot modify it from outside
    private(set) var completed: Bool
    // Public allows use from any source file in any module that imports the defining module, but subclassing and overriding can only be done within the defining module
    public func evaluate() { }
    // Open is similar to public but also allows subclassing and overriding from outside the defining module.

    // why it doesn't work here?
//    open var formattedTitle: String {
//        title.uppercased()
//    }

}

//: ### Annotations
/// @discardableResult
@discardableResult
func someFunction() -> Int {
    // Function implementation
    42
}

/// @frozen
@frozen public enum Direction {
    case north
    case south
    case east
    case west
}

/// @unknown default


//: [Next](@next)
