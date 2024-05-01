//: [Previous](@previous)

//: # Functions, Closures
import Foundation

//: ### Functions
//: ### Void
example(of: "Void functions") {
    // Function that doesn't return anything
    func helloWorld() {
        print("Hello world")
    }
    // Void is equivalent of empty return
    func helloWorld1() -> Void {
        print("Hello world 1")
    }
    // () is equivalent of Void
    func helloWorld2() -> () {
        print("Hello world 2")
    }

    helloWorld()
    helloWorld1()
    helloWorld2()
}

//: ### Return value
example(of: "Function with return value") {
    // Function that returns `String`
    func getHelloWorld() -> String {
        "Hello world"
    }

    print(getHelloWorld())
}

//: ### Default value
example(of: "Function parameter with default value") {
    // Sometimes you want to provide a default value for a parameter
    func add(number a: Int, to b: Int = 48) -> Int {
        a + b
    }

    print(add(number: 2, to: 40))
    // You can skip the parameter in the function call and the default value is used instead
    // readability !
    print(add(number: 2))
}

//: ### Object method
example(of: "Method in a structure") {
    // Function is typically defined in either struct or class
    struct Person {
        let firstName: String
        let lastName: String

        func getFullName() -> String {
            "\(firstName) \(lastName)"
        }

        // If a function has no parameters you can define it as "computed property"
        var fullName: String {
            // If there is just one line of code in a function body you can leave out the `return` keyword
            "\(firstName) \(lastName)"
        }
    }

    let me = Person(firstName: "C.J.", lastName: "Parker")
    print(me.getFullName())
    print(me.fullName)
}

//: ## Closures
//: ### Closure declaration
example(of: "Closure declaration") {
    // You can imagine closer as a function definition that is stored in a variable
    // As usual, the type of the closure is specified between ":" and "="
    // "(Int, Int)" says that the closure has 2 parameter, both are of type Integer
    // "-> Int" says that the closure returns an Integer
    // When we define function, we define parameter names in the function signature (in the brackets). With closures, we define just the data types for the parameters but not parameter names, so we specify the names in the closure body right after "{" bracket and we must add "in" keyword to start the actual closure body definition
    let add: (Int, Int) -> Int = { a, b in
        a + b
    }

    // Eventually, we call the closure exactly the same as a function
    print(add(1, 2))

    // If you ask "Why closures when we have functions" check the next example
}

//: ### Closure as a function parameter
example(of: "Closure as a function parameter") {
    // This function has 3 parameters, the first is Integer, the second is Integer, and the third is a closure that accepts two Integer parameters and returns Integer
    // The idea is to create an universal function that can accept two numbers and do pretty much anything with them
    func combine(a: Int, b: Int, with block: (Int, Int) -> Int) -> Int {
        // Here we call the closure with the specified parameters
        block(a, b)
    }

    // This is a closure that takes two numbers and subtracts the second one from the first one
    let subtract: (Int, Int) -> Int = { a, b in
        a - b
    }

    // Now we can call the `combine` function with two numbers and provided with the closure that subtracts them
    let subtraction = combine(a: 1, b: 2, with: subtract)
    print(subtraction)

    // We can also define the closure right in the function call
    // In this case we add the numbers
    let addition = combine(a: 1, b: 2, with: { a, b in
        a + b
    })
    print(addition)

    // typealias
    typealias IntOperation = (Int, Int) -> Int
    typealias IntCallback = (Int) -> Void

    func combine(a: Int, b: Int, with block: IntOperation, callback: IntCallback) {
        
        // Here we call the closure with the specified parameters
        let heavyOperation = block(a,b)
        callback(heavyOperation)

        //callback(block(a, b)
    }

    combine(a: 10, b: 11, with: { $0 + $1 }, callback: { print($0) })

    // @escaping
    // reference type or value type?
    // retain cycle vs [weak self]
}

//: [Next](@next)
