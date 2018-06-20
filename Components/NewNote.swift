struct NewNote {
    let text: String
}

func reduce(state: NewNote, _ action: Action) -> NewNote {
    switch action {
        
    case let action as UpdateNewNoteText:
        return NewNote(text: action.newText)
        
    case is ClearNewNote, is AddPersonalNote, is AddCommonNote:
        return NewNote(text: "")
        
    default:
        return state
    }
}
