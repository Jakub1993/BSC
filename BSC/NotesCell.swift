//
//  NotesCell.swift
//  BSC
//
//  Created by Jakub Louda on 27.07.18.
//  Copyright © 2018 BSC Louda. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Náhradní díly"
        label.numberOfLines = 1
        label.textColor = UIColor.init(red: 81/255, green: 83/255, blue: 102/255, alpha: 1)
        label.font = UIFont(name: "Roboto-Bold", size: 15)
        return label
    }()
    
    let separatorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(red: 231/255, green: 236/255, blue: 244/255, alpha: 1)
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            cellBackgroundView.backgroundColor = isSelected ? UIColor.init(red: 248/255, green: 248/255, blue: 248/255, alpha: 1): UIColor.white
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            cellBackgroundView.backgroundColor = isHighlighted ? UIColor.init(red: 248/255, green: 248/255, blue: 248/255, alpha: 1): UIColor.white
        }
    }
    
    func setupViews() {
        addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(iconImageView)
        cellBackgroundView.addSubview(infoView)
        infoView.addSubview(userNameLabel)
        addSubview(separatorLine)
        
        cellBackgroundView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        cellBackgroundView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        cellBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        
        iconImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        iconImageView.leftAnchor.constraint(equalTo: cellBackgroundView.leftAnchor, constant: 16).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: cellBackgroundView.centerYAnchor).isActive = true
        
        infoView.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor).isActive = true
        infoView.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 16).isActive = true
        infoView.rightAnchor.constraint(equalTo: cellBackgroundView.rightAnchor, constant: -16).isActive = true
        
        userNameLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 0).isActive = true
        userNameLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 0).isActive = true
        userNameLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: 0).isActive = true
        userNameLabel.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 0).isActive = true
        
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
