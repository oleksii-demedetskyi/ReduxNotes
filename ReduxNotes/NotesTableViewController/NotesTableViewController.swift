import UIKit

final class NotesTableViewController: UITableViewController {
    struct Props {
        let addNewNote: CommandWith<UIViewController>
        let notes: [Note]
        
        struct Note {
            let title: String
            let select: CommandWith<UIViewController>
        }
    }
    
    
    private var props = Props(addNewNote: .nop, notes: [])
    
    func render(props: Props) {
        self.props = props
        self.tableView.reloadData()
    }
    
    @IBAction func unwindToNotesList(segue: UIStoryboardSegue) {}
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return props.notes.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "note cell") else {
            fatalError("cannot deque cell for note")
        }
        
        cell.textLabel?.text = props.notes[indexPath.row].title
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            
        case "show note details"?:
            guard let cell = sender as? UITableViewCell else {
                fatalError("note details triggered not from cell")
            }
            
            guard let indexPath = tableView.indexPath(for: cell) else {
                fatalError("cannot extract index path for note cell")
            }
            
            props.notes[indexPath.row].select.perform(with: segue.destination)
            
        case "show new note"?:
            props.addNewNote.perform(with: segue.destination)
            
        default:
            break
        }
    }
}
