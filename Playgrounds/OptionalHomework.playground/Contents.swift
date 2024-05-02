import UIKit

// MARK: Constants
enum Constants {
    static let pi = 3.141592654
}

enum ShapeType: String {
    case circle = "Circle"
    case square = "Square"
    case rectangle = "Rectangle"
}

protocol Shape {
    var name: String { get }
    var area: Double { get }
}

class Circle: Shape {

    let name: String
    var radius: Double?
    var area: Double {
        guard let radius else { return 0 }
        return Constants.pi * radius * radius
    }
    init(name: String, radius: Double? = nil) {
        self.name = name
        self.radius = radius
    }
}

class Square: Shape {

    let name: String
    var sideLength: Double?
    var area: Double {
        guard let sideLength else { return 0 }
        return sideLength * sideLength
    }
    
    init(name: String, sideLength: Double? = nil) {
        self.name = name
        self.sideLength = sideLength
    }
}

class Rectangle: Shape {

    let name: String
    var sideA: Double?
    var sideB: Double?
    var area: Double {
        guard let sideA, let sideB else { return 0 }
        return sideA * sideB
    }
    
    init(name: String, sideA: Double? = nil, sideB: Double? = nil) {
        self.name = name
        self.sideA = sideA
        self.sideB = sideB
    }
}

struct ShapeFactory {
    static func createShape(type: ShapeType) -> Shape {
        switch type {
        case .circle:
            return Circle(name: type.rawValue)
        case .square:
            return Square(name: type.rawValue, sideLength: 0)
        case .rectangle:
            return Rectangle(name: type.rawValue, sideA: 0, sideB: 0)
        @unknown default: print("Unknown object, please create")
            return Circle(name: type.rawValue)
        }
    }
}

if let circle = ShapeFactory.createShape(type: .circle) as? Circle {
    circle.radius = 5
    print("Area of \(ShapeType.circle.rawValue) is \(String(format: "%.2f", circle.area)).")
}

if let rectangle = ShapeFactory.createShape(type: .rectangle) as? Rectangle {
    rectangle.sideA = 5
    rectangle.sideB = 2.13
    print("Area of \(ShapeType.rectangle.rawValue) is \(String(format: "%.2f", rectangle.area)).")
}


