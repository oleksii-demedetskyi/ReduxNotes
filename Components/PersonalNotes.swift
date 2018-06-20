import Foundation

struct PersonalNotes {
    let ids: [AllNotes.Id]
}

func reduce(state: PersonalNotes, _ action: Action) -> PersonalNotes {
    switch action {
    case let action as AddPersonalNote:
        return PersonalNotes(ids: state.ids + [AllNotes.Id(value: action.id)])
        
    default:
        return state
    }
}
