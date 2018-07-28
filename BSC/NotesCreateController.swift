//
//  NotesCreateController.swift
//  BSC
//
//  Created by Jakub Louda on 27.07.18.
//  Copyright © 2018 BSC Louda. All rights reserved.
//

import UIKit
import Firebase

class NotesCreateController: NotesReusableController {
    var delegate: NotesController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotificationCenter()
        setupNavBar()
        setupViews()
        setupItems()
    }
    
    func setupItems() {
        customButton.addTarget(self, action: #selector(create), for: .touchUpInside)
        customButton.setTitle(NSLocalizedString("Create", comment: ""), for: .normal)
        customLabel.text = NSLocalizedString("New note", comment: "")
    }
    
    @objc func create(_ button: UIButton) {
        button.isEnabled = false
        let contentText = noteTextView.text!
        
        guard !contentText.isEmpty else {
            button.isEnabled = true
            return
        }
        
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        
        let nycRef = db.collection("Notes").document()
        let batch = db.batch()
        batch.setData(["note": contentText, "time": FieldValue.serverTimestamp()], forDocument: nycRef)
        batch.commit() { err in
            if let err = err {
                print("Error writing batch \(err)")
                button.isEnabled = true
            } else {
                print("Batch write succeeded.")
                self.delegate?.notesStruct.insert(NotesStruct(note: contentText, time: "Právě teď", ID: nycRef.documentID), at: 0)
                self.delegate?.notesTableView.reloadData()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func setupNavBar() {
        navigationItem.hidesBackButton = true
        navigationItem.titleView = customLabel
        navigationItem.setLeftBarButton(backBarButtonItem, animated: true)
        navigationItem.setRightBarButton(customBarButtonItem, animated: true)
    }
    
}
