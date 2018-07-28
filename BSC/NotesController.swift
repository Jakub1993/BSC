//
//  NotesController.swift
//  BSC
//
//  Created by Jakub Louda on 27.07.18.
//  Copyright © 2018 BSC Louda. All rights reserved.
//

import UIKit
import Firebase

struct NotesStruct {
    let note : String
    let time: String
    let ID: String
}

class NotesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var languageSymbols = [String]()
    var languageNames = ["English", "Czech"]
    
    let cellId = "noteCell"
    var notesStruct = [NotesStruct]()
    
    lazy var notesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.init(red: 237/255, green: 242/255, blue: 246/255, alpha: 1)
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NoteCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorColor = .clear
        return tableView
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
        button.setTitleColor(UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2), for: [.disabled, .highlighted])
        button.setTitle(NSLocalizedString("Add", comment: ""), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(add), for: .touchUpInside)
        return button
    }()
    lazy var addBarButtonItem = UIBarButtonItem(customView: addButton)
    
    lazy var languageButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
        button.setTitleColor(UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2), for:  [.disabled, .highlighted])
        button.setTitle(NSLocalizedString("Language", comment: ""), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(changeLanguage), for: .touchUpInside)
        return button
    }()
    lazy var languageBarButtonItem = UIBarButtonItem(customView: languageButton)
    
    lazy var customLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Notes", comment: "")
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor.white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewsSetup()
        setupNavBar()
        getData()
        languageSymbols = getSymbols(languageNames: languageNames)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    func getSymbols(languageNames: [String]) -> [String] {
        var array = [String]()
        for i in 0..<languageNames.count {
            switch languageNames[i] {
            case "English":
                array.append("en")
            case "Czech":
                array.append("cs")
            case "Japan":
                array.append("jp")
            case "Deutch":
                array.append("de")
            default: print("error")
            }
        }
        return array
    }
    
    @objc func changeLanguage() {
        
        let alert = UIAlertController(title: NSLocalizedString("Choose language", comment: ""), message: NSLocalizedString("Changes will be applied after restart", comment: ""), preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("English", comment: ""), style: .default, handler:{ (UIAlertAction)in
            UserDefaults.standard.set([self.languageSymbols[0]], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Czech", comment: ""), style: .default, handler:{ (UIAlertAction)in
            UserDefaults.standard.set([self.languageSymbols[1]], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .destructive, handler:{ (UIAlertAction)in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 51/255, green: 53/255, blue: 66/255, alpha: 1)
        navigationController?.navigationBar.topItem?.titleView = customLabel
        navigationController?.navigationBar.topItem?.setRightBarButton(addBarButtonItem, animated: true)
        navigationController?.navigationBar.topItem?.setLeftBarButton(languageBarButtonItem, animated: true)
    }
    
    @objc func add(_ button: UIButton) {
        let notesCreateVC = NotesCreateController()
        notesCreateVC.delegate = self
        navigationController?.pushViewController(notesCreateVC, animated: true)
    }
    
    func viewsSetup() {
        view.backgroundColor = UIColor.init(red: 237/255, green: 242/255, blue: 246/255, alpha: 1)
        view.addSubview(notesTableView)
        notesTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        notesTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        notesTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        notesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! NoteCell
        
        cell.noteLabel.text = notesStruct[indexPath.row].note
        cell.timeLabel.text = notesStruct[indexPath.row].time
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesStruct.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let notesReadVC = NotesReadController()
        notesReadVC.delegate = self
        notesReadVC.selectedNoteID = notesStruct[indexPath.row].ID
        notesReadVC.noteTextView.text = notesStruct[indexPath.row].note
        notesReadVC.selectedIndexPath = indexPath
        navigationController?.pushViewController(notesReadVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: NSLocalizedString("Delete", comment: "")) { action, index in
            self.delete(indexPath: indexPath)
        }
        delete.backgroundColor = .red
        
        return [delete]
    }
    
    func count(a: Int, b: Int) -> Int {
        return a + b
    }
    
    func delete(indexPath: IndexPath) {
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        
        let nycRef = db.collection("Notes").document(notesStruct[indexPath.row].ID)
        let batch = db.batch()
        batch.deleteDocument(nycRef)
        batch.commit() { err in
            if let err = err {
                print("Error writing batch \(err)")
            } else {
                print("Batch write succeeded.")
                self.notesStruct.remove(at: indexPath.row)
                self.notesTableView.deleteRows(at: [indexPath], with: .top)
            }
        }
    }
    
    func getData() {
        let database = Firestore.firestore()
        let settings = database.settings
        settings.areTimestampsInSnapshotsEnabled = true
        database.settings = settings
        let query = database.collection("Notes").order(by: "time", descending: true)
        query.getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else {
                print("Error retreving cities: \(error.debugDescription)")
                return
            }
            
            self.notesStruct.removeAll()
            
            for document in snapshot.documents {
                let note = document.data()["note"] as? String ?? ""
                let ID = document.documentID
                var time = String()
                
                if let timeStamp = document.data()["time"] as? Timestamp {
                    let date = timeStamp.dateValue()
                    let dateFormatter = DateFormatter()
                    
                    dateFormatter.dateFormat = "dd/MM, HH:mm"
                    time = dateFormatter.string(from: date)
                }
                
                self.notesStruct.insert(NotesStruct(note: note, time:time, ID: ID), at: self.notesStruct.count)
                self.notesTableView.reloadData()
            }
        }
    }
}
