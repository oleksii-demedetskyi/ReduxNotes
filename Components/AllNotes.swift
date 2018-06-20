import Foundation

struct AllNotes {
    let byId: [Id: Note]
}

func reduce(state: AllNotes, _ action: Action) -> AllNotes {
    switch action {
    case let action as AddPersonalNote:
        var notes = state.byId
        notes[AllNotes.Id(value: action.id)] = Note(text: action.text)
        return AllNotes(byId: notes)
        
    case let action as AddCommonNote:
        var notes = state.byId
        notes[AllNotes.Id(value: action.id)] = Note(text: action.text)
        return AllNotes(byId: notes)
        
    default:
        return state
    }
}

struct Note {
    let text: String
}

extension AllNotes {
    struct Id: Hashable, Equatable {
        let value: String
        
        var hashValue: Int { return value.hashValue }
        static func == (left: Id, right: Id) -> Bool {
            return left.value == right.value
        }
    }
}
