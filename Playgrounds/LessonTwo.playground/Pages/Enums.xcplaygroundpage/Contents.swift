//: [Previous](@previous)

import Foundation

//: # Enumerations
//: ### Declaration
example(of: "Enum declaration") {
    enum Languages {
        case swift
        case objectiveC
    }

    let language: Languages = .swift
    print(language)
}

//: ### Enum with raw value
example(of: "Enum with raw value") {
    enum Languages: String {
        case swift = "swift"
        case objectiveC = "objective-C"
    }

    let language: Languages = .objectiveC
    print(language.rawValue)

    let rawString = "objective-C"
    // what will return lang when rawString with CC suffix?
    //let rawString = "objective-CC"
    let lang = Languages(rawValue: rawString)
    print(lang.debugDescription)


    // can be enum inherited?
}

//: ### Enum with associated value
example(of: "Enum with associated value") {
    enum Platform {
        case iOS(language: iOSLanguages)
        case android(language: AndroidLanguages)
    }

    enum iOSLanguages: String {
        case swift, objectiveC
    }

    enum AndroidLanguages: String {
        case java, kotlin
    }

    var platform: Platform = .iOS(language: .swift)

    // switch
    switch platform {
    case .iOS(let language):
        print("We use iOS written in \(language)")
    case .android(let language):
        print("We use Android written in \(language)")
    }

    // if let
    if case let .iOS(language) = platform {
        print("We use iOS written in \(language)")
    }
}

//: ### Enum with associated value
example(of: "Recursive enums") {
    enum ArithmeticExpression {
        case number(Int)
        indirect case addition(ArithmeticExpression, ArithmeticExpression)
        indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
    }

    indirect enum IndirectArithmeticExpression {
        case number(Int)
        case addition(ArithmeticExpression, ArithmeticExpression)
        case multiplication(ArithmeticExpression, ArithmeticExpression)
    }

    let arithmeticExpression: ArithmeticExpression = .addition(.addition(.number(5), .number(2)), .number(3))

    let indirectArithmeticExpression: IndirectArithmeticExpression = .addition(.addition(.number(5), .number(2)), .number(3))
    
}

//: [Next](@next)
