//: [Previous](@previous)

import Foundation

//: # Optionals
//: ## Introduction
//: ### Why optionals

example(of: "Unknown(not set) value") {
    var email: String?
    email = "example@example.com"
    print(email.debugDescription)
    print(type(of: email))
}

example(of: "Type casting") {
    let stringAge = "30"
    let age: Int? = Int(stringAge)
    
    print(age.debugDescription)
    print(type(of: age))
}

//: ### What is optional
example(of: "Optional syntax") {
    let stringAge: Optional<String> = "30"
    
    print(stringAge == .none) // .some(let string)
    print(type(of: stringAge))
}

//: ### Comparison
example(of: "Comparison switch") {
    let stringAge: String? = "30" // without explicit type it's String
    
    switch stringAge {
    case .none:
        print("stringAge is nil")
    case .some(let age):
        print("current stringAge is \(age)")
        print(type(of: age)) // unwrapped value
    }
    
    /*
     case let .some(age):
         print("current stringAge is \(age)")
         print(type(of: age)) // unwrapped value
     */
}

example(of: "Comparison strongly typed") {
    let stringAgeOptional: String? = "30"
    let stringAge: String = "30"
    
    func printString(_ string: String) {
        
    }
    func printStringOptional(_ string: String?) {
        
    }
    // will the following code work?
    //    printString(stringAge)
    // will the following code work?
    // printStringOptional(stringAge)
    // will the following code work?
    // stringAge == stringAgeOptional
}

//: ## Unwrapping
//: ### Force unwrap
example(of: "Force unwrap") {
    var age: Int? = 30
    
    if age == nil { // !age ?
        print("There is nil")
    } else if age! < 25 {
        print("Less than 25")
    } else {
        print(age!)
    }
    // What will happen?
    //    age = nil
    //    print(age!)
}

//: ### Implicitly unwrapped optional
example(of: "Implicitly unwrapped optional") {
    var age: Int!
    // What will happen?
//    if age < 25 {
//    }
    age = 30
    
    print(age.debugDescription)
    print(type(of: age))
    
    if age < 25 {
        print("Less than 25")
    }
    
    let biggerAge = age.advanced(by: 2)
    print(biggerAge)
    print(type(of: biggerAge))
}

//: ### If let
example(of: "If let") {
    var age: Int? = 30
    print(type(of: age))
    
    if let age {
        print(age)
        print(type(of: age))
    }
    
    if let unwrappedAge = age {
        print(unwrappedAge)
        print(type(of: unwrappedAge))
        print(type(of: age))
    }
}

//: ### Guard let
example(of: "Guard let") {
    var age: Int? = 30
    
    print(type(of: age))
    // local variable - scope
    guard let age else {
        print("There was nil")
        return
    }
    
    print(age)
    print(type(of: age))
}

//: [Next](@next)
