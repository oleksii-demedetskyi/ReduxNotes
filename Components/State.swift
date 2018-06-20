import Foundation

struct State {
    let allNotes: AllNotes
    let personalNotes: PersonalNotes
    let commonNotes: CommonNotes
    let newNote: NewNote
}

func reduce(state: State, _ action: Action) -> State {
    return State(
        allNotes: reduce(state: state.allNotes, action),
        personalNotes: reduce(state: state.personalNotes, action),
        commonNotes: reduce(state: state.commonNotes, action),
        newNote: reduce(state: state.newNote, action)
    )
}
