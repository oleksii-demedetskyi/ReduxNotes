import Foundation

struct AddPersonalNote: Action {
    let id: String = UUID().uuidString
    let text: String
}
