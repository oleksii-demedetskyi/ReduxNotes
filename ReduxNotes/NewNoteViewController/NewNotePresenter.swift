
struct NewNotePresenter {
    typealias Props = NewNoteViewController.Props
    
    let render: CommandWith<Props>
    let dispatch: CommandWith<Action>
    
    let context: Context; enum Context {
        case personal, common
    }
    
    func present(state: State) {
        // TO DO
    }
}
