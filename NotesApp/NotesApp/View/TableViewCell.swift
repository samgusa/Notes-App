//
//  TableViewCell.swift
//  NotesApp
//
//  Created by Sam Greenhill on 6/18/20.
//  Copyright © 2020 simplyAmazingMachines. All rights reserved.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    

    let noteTitle: UILabel = {
       let str = UILabel()
        str.translatesAutoresizingMaskIntoConstraints = false
        str.textColor = .label
        str.numberOfLines = 1
        str.textAlignment = .left
        str.font = UIFont.systemFont(ofSize: 17)
        
        return str
    }()
    
    let noteText: UILabel = {
        let str = UILabel()
        str.translatesAutoresizingMaskIntoConstraints = false
        str.textColor = .label
        str.numberOfLines = 4
        str.font = UIFont.systemFont(ofSize: 14)
        
        
        return str
    }()
    
    let noteDateLbl: UILabel = {
        let str = UILabel()
        str.translatesAutoresizingMaskIntoConstraints = false
        str.textColor = .label
        str.font = UIFont.systemFont(ofSize: 13)
        str.numberOfLines = 0
        
        return str
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.backgroundColor = .systemBackground
        addViews()
    }
    
    
    func addViews() {
        
        self.addSubview(noteTitle)
        self.addSubview(noteDateLbl)
        self.addSubview(noteText)
        
        
        noteTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        noteTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        //noteTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        noteDateLbl.topAnchor.constraint(equalTo: noteTitle.bottomAnchor, constant: 7.5).isActive = true
        noteDateLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        //noteDateLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        
        noteText.topAnchor.constraint(equalTo: noteDateLbl.bottomAnchor).isActive = true
        noteText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        //noteText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        noteText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
    }
    
}
