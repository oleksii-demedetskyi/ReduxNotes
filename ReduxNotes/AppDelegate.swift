//
//  AppDelegate.swift
//  ReduxNotes
//
//  Created by Alexey Demedetskii on 6/17/18.
//  Copyright © 2018 Alexey Demedeckiy. All rights reserved.
//

import UIKit

import FirebaseDatabase
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let initialState = State(
            allNotes: AllNotes(byId: [:]),
            personalNotes: PersonalNotes(ids: []),
            commonNotes: CommonNotes(ids: []),
            newNote: NewNote(text: "")
        )
        
        let store = Store(state: initialState, reduce: reduce)
        
        func connectDetails(noteID: AllNotes.Id, viewController: UIViewController) {
            guard let detailsVC = viewController as? NoteDetailsViewController else {
                fatalError("cannot present note details to viewController: \(viewController)")
            }
            
            let presenter = NoteDetailsPresenter(
                noteID: noteID,
                render: CommandWith(action: detailsVC.render).dispatched(on: .main),
                dispatch: CommandWith(action: store.dispatch)
            )
            
            store.observe(with: presenter.present)
        }
        
        func connectNewNote(viewController: UIViewController, context: NewNotePresenter.Context) {
            guard let navigationVC = viewController as? UINavigationController else {
                fatalError("cannot present not to navigation")
            }
            
            guard let newNoteVC = navigationVC.topViewController as? NewNoteViewController else {
                fatalError("cannot present new note to view controller: \(viewController)")
            }
            
            let presenter = NewNotePresenter(
                render: CommandWith(action: newNoteVC.render).dispatched(on: .main),
                dispatch: CommandWith(action: store.dispatch),
                context: context
            )
            
            store.observe(with: presenter.present)
        }
        
        func connectPersonalNotes(viewController: NotesTableViewController) {
            let presenter = PersonalNotesTablePresenter(
                render: CommandWith(action: viewController.render).dispatched(on: .main),
                dispatch: CommandWith(action: store.dispatch),
                connectDetails: CommandWith(action: connectDetails),
                connectNewNote: CommandWith { viewController in
                    connectNewNote(viewController: viewController, context: .personal)
                }
            )
            
            store.observe(with: presenter.present)
        }
        
        func connectCommonNotes(viewController: NotesTableViewController) {
            let presenter = CommonNotesTablePresenter(
                render: CommandWith(action: viewController.render).dispatched(on: .main),
                dispatch: CommandWith(action: store.dispatch),
                connectDetails: CommandWith(action: connectDetails),
                connectNewNote: CommandWith { viewController in
                    connectNewNote(viewController: viewController, context: .common)
                }
            )
            
            store.observe(with: presenter.present)
        }
        
        let viewControllers = ViewControllers(window: window!)
        
        connectPersonalNotes(viewController: viewControllers.personalNotesTableViewConotoller)
        connectCommonNotes(viewController: viewControllers.commonNotesTableViewConotoller)
        
        return true
    }
}
