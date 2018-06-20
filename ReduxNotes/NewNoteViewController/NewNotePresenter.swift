
struct NewNotePresenter {
    typealias Props = NewNoteViewController.Props
    
    let render: CommandWith<Props>
    let dispatch: CommandWith<Action>
    
    let context: Context; enum Context {
        case personal, common
    }
    
    func present(state: State) {
        
        func saveAction() -> Action? {
            guard state.newNote.text.count > 0 else { return nil }
            
            switch context {
            case .common: return AddCommonNote(text: state.newNote.text)
            case .personal: return AddPersonalNote(text: state.newNote.text)
            }
        }
        
        let props = Props(
            title: state.newNote.text,
            text: state.newNote.text,
            updateText: dispatch.map(transform: UpdateNewNoteText.init),
            cancel: dispatch.bind(to: ClearNewNote()),
            save: saveAction().map(dispatch.bind)
        )
        
        render.perform(with: props)
    }
}
