import UIKit

final class NoteDetailsViewController: UIViewController {
    struct Props {
        let title: String
        let text: String
    }
    
    @IBOutlet private var textView: UITextView!
    
    private var props = Props(title: "", text: "")
    
    func render(props: Props) {
        self.props = props
        view.setNeedsLayout()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        title = props.title
        textView.text = props.text
    }
}
