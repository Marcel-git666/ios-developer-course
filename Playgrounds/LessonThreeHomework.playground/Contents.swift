import UIKit

protocol EventType {
    var name: String { get }
}

protocol AnalyticEvent {
    associatedtype AnalyticType: EventType
    var type: AnalyticType { get set }
    var parameters: [String: Any] { get }
    var identifier: UUID { get }
}

extension AnalyticEvent {
    var name: String {
        return type.name
    }
}

struct ScreenViewType: EventType {
    let name: String = "ScreenView"
    
}

enum ScreenAction: String {
    case login = "Login screen"
    case home = "Home screen"
    case edit = "Edit screen"
}

struct ScreenViewEvent: AnalyticEvent {
    var identifier = UUID()
    
    let screenAction: String
    var type: ScreenViewType
    var parameters: [String : Any] {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        let timestamp = formatter.string(from: Date())
        return [
            "action": type.name,
            "timestamp": timestamp
        ]
    }
}

struct UserActionType: EventType {
    let name: String = "UserAction"
    
}

enum UserAction: String {
    case hasClicked = "User has clicked a button"
    case madeGesture = "User has made a gesture"
    case typed = "User has typed some text"
}

struct UserActionEvent: AnalyticEvent {
    var identifier = UUID()
    var type: UserActionType
    let userAction: String
    var parameters: [String : Any] {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        let timestamp = formatter.string(from: Date())
        return [
            "action": type.name,
            "timestamp": timestamp
        ]
    }
}

protocol AnalyticsService {
    func logEvent<Event: AnalyticEvent>(_ event: Event)
}

class AnalyticsServiceImpl: AnalyticsService {
    var logs: [String: Any] = [:]
    func logEvent<Event: AnalyticEvent>(_ event: Event) {
        
        print(event.name)
        logs[event.identifier.uuidString] = event.parameters
    }
    
}

let analyticsService = AnalyticsServiceImpl()
let userActionType = UserActionType()

var userAction: UserAction = .hasClicked
analyticsService.logEvent(UserActionEvent(type: userActionType, userAction: userAction.rawValue))
userAction = .madeGesture
analyticsService.logEvent(UserActionEvent(type: userActionType, userAction: userAction.rawValue))

let screenViewType = ScreenViewType()
var screenAction: ScreenAction = .edit
analyticsService.logEvent(ScreenViewEvent(screenAction: screenAction.rawValue, type: screenViewType))
screenAction = .home
analyticsService.logEvent(ScreenViewEvent(screenAction: screenAction.rawValue, type: screenViewType))
print(analyticsService.logs)
