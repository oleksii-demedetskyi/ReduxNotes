import UIKit

struct CommonNotesTablePresenter {
    typealias Props = NotesTableViewController.Props
    
    let render: CommandWith<Props>
    let dispatch: CommandWith<Action>
    let connectDetails: CommandWith<(AllNotes.Id, UIViewController)>
    let connectNewNote: CommandWith<UIViewController>
    
    func present(state: State) {
        let notes = state.commonNotes.ids.map { noteID -> Props.Note in
            guard let note = state.allNotes.byId[noteID] else {
                fatalError("state inconsistent. missing note for id: \(noteID)")
            }
            
            return Props.Note(
                title: note.text,
                select: CommandWith { viewController in
                    self.connectDetails.perform(with: (noteID, viewController))
                }
            )
        }
        
        let props = Props(
            addNewNote: connectNewNote,
            notes: notes
        )
        
        render.perform(with: props)
    }
}

