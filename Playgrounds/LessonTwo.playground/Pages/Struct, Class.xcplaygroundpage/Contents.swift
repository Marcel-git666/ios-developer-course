//: [Previous](@previous)

//: # Structures, classes
import Foundation
//: ## Structures and classes
//: ### Declaration
example(of: "Struct declaration") {
    struct Person {
        let firstName: String
        let lastName: String
    }
    
    let person = Person(firstName: "C.J.", lastName: "Parker")
    print(person)
}

example(of: "Struct with explicit initialiser") {
    struct Person {
        let firstName: String
        let lastName: String
        
        init() {
            firstName = "Casey Jean"
            lastName = "Parker"
        }
        
        init(firstName: String, lastName: String) {
            self.firstName = firstName
            self.lastName = lastName
        }
    }
    
    struct Person2 {
        // var vs let
        var firstName: String?
        var lastName: String?
    }

    let person = Person()
    // person.firstName = "C.J."
    print(person)
    
    var person2 = Person2()
    print(person2)
    person2.firstName = "C.J."
    print(person2)
}

example(of: "Class declaration") {
    class Person {
        let firstName: String
        let lastName: String

        init(firstName: String, lastName: String) {
            self.firstName = firstName
            self.lastName = lastName
        }
    }

    let person = Person(firstName: "C.J.", lastName: "Parker")
    print(person)
}

example(of: "Value type") {
    struct Person {
        var firstName: String
        var lastName: String
    }

    var person = Person(firstName: "C.J.", lastName: "Parker")
    var person2 = person
    person.firstName = "Casey Jean"

    // What will be the result?
    print(person)
    print(person2)
}

example(of: "Reference type") {
    class Person {
        var firstName: String
        var lastName: String

        init(firstName: String, lastName: String) {
            self.firstName = firstName
            self.lastName = lastName
        }
    }

    let person = Person(firstName: "C.J.", lastName: "Parker")
    var person2 = person
    person.firstName = "Casey Jean"

    // What will be the result?
    print(person.firstName)
    print(person2.firstName)
}

//: ### Inheritance
example(of: "Inheritance") {
    class Person {
        var firstName: String
        var lastName: String

        init() {
            self.firstName = "C.J."
            self.lastName = "Parker"
        }
    }

    class UppercasedPerson: Person {
        override init() {
            super.init()

            self.firstName = "JAN"
            self.lastName = "SCHWARZ"
        }
    }

    let uppercasePerson = UppercasedPerson()
    print(uppercasePerson.firstName)
}

example(of: "Struct inheritance") {
    struct Person {
        var firstName: String
        var lastName: String
    }

    struct UppercasedPerson {
    }

    // Try to inherit
}

//: [Next](@next)
