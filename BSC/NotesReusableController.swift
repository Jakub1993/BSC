//
//  NotesDetailController.swift
//  BSC
//
//  Created by Jakub Louda on 27.07.18.
//  Copyright © 2018 BSC Louda. All rights reserved.
//

import UIKit

class NotesReusableController: UIViewController {
    var bottomTextViewConstraint = NSLayoutConstraint()
    
    var customButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
        button.setTitleColor(UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2), for: [.disabled, .highlighted])
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return button
    }()
    lazy var customBarButtonItem = UIBarButtonItem(customView: customButton)
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    lazy var backBarButtonItem = UIBarButtonItem(customView: backButton)
    
    lazy var customLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor.white
        return label
    }()
    
    var noteTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = UIColor.init(red: 136/255, green: 141/255, blue: 168/255, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.backgroundColor = UIColor.white
        textView.contentInset = UIEdgeInsetsMake(8, 0, 8, 0)
        return textView
    }()
   
    func setupViews() {
        view.backgroundColor = UIColor.white
        view.addSubview(noteTextView)
        noteTextView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        noteTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        noteTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        bottomTextViewConstraint = noteTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomTextViewConstraint.isActive = true
    }
    
    @objc func back(_ button: UIButton) {
        view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
    
    func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            if endFrameY >= UIScreen.main.bounds.size.height {
                bottomTextViewConstraint.constant = 0
            } else {
                bottomTextViewConstraint.constant = -(endFrame?.size.height ?? 0.0)
            }
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

