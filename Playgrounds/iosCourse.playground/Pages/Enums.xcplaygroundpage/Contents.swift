
import Foundation

enum Languages: String {
    case objC
    case swift = "Swift"
}

let language = Languages.swift
print(language)
print(language.rawValue)


enum Country: Equatable {
    case czech(currency: String)
    case slovak(curr: String)
}

let czech = Country.czech(currency: "CZK")
let newCzech = Country.czech(currency: "EUR")
print(czech == newCzech)

if case let .czech(currency) = czech {
    print(currency)
}

switch czech {
case let .czech(curr):
    print(curr)
default: print("Nothing is here")
}

enum AuthPermission {
    case notDetermined
    case authorized
    case denied
}

let auth = AuthPermission.denied

switch auth {
case.authorized: print("Authorized")
case .notDetermined, .denied: 
    fallthrough
    print("I don't know")
@unknown default:
    print("Don't know yet")
}
