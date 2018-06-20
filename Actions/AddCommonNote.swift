import Foundation

struct AddCommonNote: Action {
    let id: String = UUID().uuidString
    let text: String
}
