import UIKit

struct ViewControllers {
    let window: UIWindow
    
    var tabbarController: UITabBarController {
        guard let tabbar = window.rootViewController as? UITabBarController else {
            fatalError("Root wiew controller is not a tabbar")
        }
        
        return tabbar
    }
    
    var tabbarViewControllers: [UIViewController] {
        guard let viewControllers = tabbarController.viewControllers else {
            fatalError("tabbar controllers does not have view controllers")
        }
        
        return viewControllers
    }
    
    var personalNotesNavigationController: UINavigationController {
        guard let navigation = tabbarViewControllers[0] as? UINavigationController else {
            fatalError("first controller in a tabbar is not a navigation one")
        }
        
        return navigation
    }
    
    var commonNotesNavigationController: UINavigationController {
        guard let navigation = tabbarViewControllers[1] as? UINavigationController else {
            fatalError("second controller in a tabbar is not a navigation one")
        }
        
        return navigation
    }
    
    var personalNotesTableViewConotoller: NotesTableViewController {
        guard let tableVC = personalNotesNavigationController.viewControllers.first as? NotesTableViewController else {
            fatalError("root controller in a personal notes navigation is not a table")
        }
        
        return tableVC
    }
    
    var commonNotesTableViewConotoller: NotesTableViewController {
        guard let tableVC = commonNotesNavigationController.viewControllers.first as? NotesTableViewController else {
            fatalError("root controller in a common notes navigation is not a table")
        }
        
        return tableVC
    }
}
