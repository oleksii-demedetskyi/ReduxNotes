import UIKit

final class NewNoteViewController: UIViewController, UITextViewDelegate {
    struct Props {
        let title: String
        let text: String
        let updateText: CommandWith<String>
        let cancel: Command
        let save: Command?
    }
    
    var props = Props(
        title: "",
        text: "",
        updateText: .nop,
        cancel: .nop,
        save: nil
    )
    
    func render(props: Props) {
        self.props = props
        view.setNeedsLayout()
    }
    
    @IBOutlet private var textView: UITextView!
    @IBOutlet private var saveItem: UIBarButtonItem!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        textView.text = props.text
        title = props.title
        saveItem.isEnabled = props.save != nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            
        case "cancel"?:
            props.cancel.perform()
            
        case "save note"?:
            props.save?.perform()
            
        default:
            break
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        props.updateText.perform(with: textView.text)
    }
}
