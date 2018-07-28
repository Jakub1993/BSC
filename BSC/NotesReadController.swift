//
//  NotesReadController.swift
//  BSC
//
//  Created by Jakub Louda on 27.07.18.
//  Copyright © 2018 BSC Louda. All rights reserved.
//

import UIKit
import Firebase

class NotesReadController: NotesReusableController {
    var delegate: NotesController?
    var selectedNoteID = String()
    var selectedIndexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotificationCenter()
        setupNavBar()
        setupViews()
        setupItems()
    }
    
    func setupItems() {
        customButton.setTitle(NSLocalizedString("Edit", comment: ""), for: .normal)
        customButton.addTarget(self, action: #selector(edit), for: .touchUpInside)
        customLabel.text = NSLocalizedString("Note", comment: "")
    }
    
    @objc func edit(_ button: UIButton) {
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
        
        let nycRef = db.collection("Notes").document(selectedNoteID)
        let batch = db.batch()
        batch.updateData(["note": contentText], forDocument: nycRef)
        batch.commit() { err in
            if let err = err {
                print("Error writing batch \(err)")
                button.isEnabled = true
            } else {
                print("Batch write succeeded.")
                self.delegate?.notesStruct.remove(at: self.selectedIndexPath.row)
                self.delegate?.notesStruct.insert(NotesStruct(note: contentText, time: "Právě teď", ID: self.selectedNoteID), at: self.selectedIndexPath.row)
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

