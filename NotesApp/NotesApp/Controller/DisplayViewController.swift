//
//  DisplayViewController.swift
//  NotesApp
//
//  Created by Sam Greenhill on 6/18/20.
//  Copyright © 2020 simplyAmazingMachines. All rights reserved.
//

import Foundation
import UIKit

class DisplayViewController: UIViewController {
    
    
    let noteTitleLbl: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Notes Title"
        lbl.font = UIFont.systemFont(ofSize: 30)
        lbl.textColor = .label
        lbl.textAlignment = .center
        return lbl
    }()
    
    let noteDate: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .label
        lbl.textAlignment = .center
        lbl.text = "Note Date"
        lbl.font = UIFont.systemFont(ofSize: 13)
        return lbl
    }()
    
    let noteTextView: UITextView = {
       let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isEditable = false
        view.textAlignment = .left
        view.textColor = .label
        return view
    }()
    
    let editBtn: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("✎ Edit", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 30)
        return btn
    }()
    
    func configureView() {
        //update UI with detail item
        if let detail = detailsItem {
            noteTitleLbl.text = detail.noteTitle
            noteDate.text = SimpleNoteDateHelper.convertDate(date: Date.init(seconds: detail.noteTimeStamp))
            noteTextView.text = detail.noteText
        }
    }
    
    //so with this, when then data changes
    var detailsItem: SimpleNote? {
        didSet {
            //update the View
            configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureView()
        setConstraints()
    }
    
    
    func setConstraints() {
        self.view.addSubview(noteTitleLbl)
        self.view.addSubview(noteDate)
        self.view.addSubview(noteTextView)
        self.view.addSubview(editBtn)
        
        let safeArea = view.safeAreaLayoutGuide
        
        noteTitleLbl.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20).isActive = true
        
        noteTitleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        noteTitleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        noteDate.topAnchor.constraint(equalTo: noteTitleLbl.bottomAnchor, constant: 8).isActive = true
        noteDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        noteDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        noteTextView.topAnchor.constraint(equalTo: noteDate.bottomAnchor, constant: 8).isActive = true
        noteTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        noteTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        editBtn.topAnchor.constraint(equalTo: noteTextView.bottomAnchor, constant: 8).isActive = true
        editBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        editBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        editBtn.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -15).isActive = true
        
        editBtn.addTarget(self, action: #selector(editBtnPressed), for: .touchUpInside)
        
    }
    
    
    @objc func editBtnPressed() {
        let vcC = DetailViewController()
        if let detail = detailsItem {
            vcC.setChangingSimpleNote(changingSimpleNote: detail)
        }
        navigationController?.pushViewController(vcC, animated: true)
        
    }
    
}
