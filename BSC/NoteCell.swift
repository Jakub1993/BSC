//
//  NotesCell.swift
//  BSC
//
//  Created by Jakub Louda on 27.07.18.
//  Copyright © 2018 BSC Louda. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    let cellBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        return view
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "note")
        return imageView
    }()
    
    let infoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let noteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = UIColor.init(red: 81/255, green: 83/255, blue: 102/255, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = UIColor.init(red: 136/255, green: 141/255, blue: 168/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let separatorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(red: 231/255, green: 236/255, blue: 244/255, alpha: 1)
        return view
    }()
    
    func setupViews() {
        addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(iconImageView)
        cellBackgroundView.addSubview(infoView)
        infoView.addSubview(noteLabel)
        infoView.addSubview(timeLabel)
        addSubview(separatorLine)
        
        cellBackgroundView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        cellBackgroundView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        cellBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        
        iconImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        iconImageView.leftAnchor.constraint(equalTo: cellBackgroundView.leftAnchor, constant: 16).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: cellBackgroundView.centerYAnchor).isActive = true
        
        infoView.centerYAnchor.constraint(equalTo: cellBackgroundView.centerYAnchor).isActive = true
        infoView.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 8).isActive = true
        infoView.rightAnchor.constraint(equalTo: cellBackgroundView.rightAnchor, constant: -16).isActive = true
        
        noteLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 0).isActive = true
        noteLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 0).isActive = true
        noteLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: 0).isActive = true
        
        timeLabel.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 0).isActive = true
        timeLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 0).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: 0).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 0).isActive = true
        
        separatorLine.topAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor).isActive = true
        separatorLine.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        separatorLine.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        separatorLine.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        separatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
