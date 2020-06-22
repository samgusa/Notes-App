//
//  DetailViewController.swift
//  NotesApp
//
//  Created by Sam Greenhill on 6/18/20.
//  Copyright © 2020 simplyAmazingMachines. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, UITextViewDelegate {
    
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblTopView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lftView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rgtView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let txtTopView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let ntTitle: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textColor = .label
        lbl.text = "Note Title"
        lbl.textAlignment = .left
        return lbl
    }()
    
    let timeStamp: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .label
        lbl.text = "Time Stamp"
        lbl.textAlignment = .right
        return lbl
    }()
    
    let titleText: UITextField = {
       let tField = UITextField()
        tField.translatesAutoresizingMaskIntoConstraints = false
        tField.placeholder = "Placeholder"
        tField.borderStyle = UITextField.BorderStyle.roundedRect
        tField.keyboardType = UIKeyboardType.default
        tField.returnKeyType = UIReturnKeyType.done
        tField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        return tField
    }()
    
    let ntTxtLbl: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.text = "Note Text"
        return lbl
    }()
    
    let noteTxtView: UITextView = {
       let tView = UITextView()
        tView.translatesAutoresizingMaskIntoConstraints = false
        tView.layer.borderWidth = 1
        tView.layer.borderColor = UIColor.lightGray.cgColor
        tView.layer.cornerRadius = 5
        return tView
    }()
    
    let midView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let btmView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let doneBtn: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(.label, for: .normal)
        btn.setTitle("✓OK", for: .normal)
        btn.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 30)
        btn.isEnabled = false
        btn.isHidden = true
        return btn
    }()
    
    
    private let noteCreationTimeStamp: Int64 = Date().toSeconds()
    private(set) var changingSimpleNote: SimpleNote?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        noteTxtView.delegate = self
        
        //check if we are in create or change mode:
        if let changingSimpleNote = self.changingSimpleNote {
            //if in changing mode fill fields with data
            timeStamp.text = SimpleNoteDateHelper.convertDate(date: Date.init(seconds: noteCreationTimeStamp))
            noteTxtView.text = changingSimpleNote.noteText
            titleText.text = changingSimpleNote.noteTitle
            //enable done button
            doneBtn.isEnabled = true
            doneBtn.isHidden = false
        } else {
            //if in create mode set initial time stamp
            timeStamp.text = SimpleNoteDateHelper.convertDate(date: Date.init(seconds: noteCreationTimeStamp))
        }
        
//        noteTxtView.layer.borderColor = UIColor.black.cgColor
//        noteTxtView.layer.borderWidth = 1
//        noteTxtView.layer.cornerRadius = 5
        setContraints()
    }
    
    func setContraints() {
        self.view.addSubview(topView)
        topView.addSubview(lblTopView)
        lblTopView.addSubview(lftView)
        lftView.addSubview(ntTitle)
        lblTopView.addSubview(rgtView)
        rgtView.addSubview(timeStamp)
        topView.addSubview(txtTopView)
        txtTopView.addSubview(titleText)
        self.view.addSubview(midView)
        midView.addSubview(ntTxtLbl)
        midView.addSubview(noteTxtView)
        self.view.addSubview(btmView)
        btmView.addSubview(doneBtn)
        
        let safeArea = view.safeAreaLayoutGuide
        
        topView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
//        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        
        lblTopView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        lblTopView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        lblTopView.trailingAnchor.constraint(equalTo: topView.trailingAnchor).isActive = true
        lblTopView.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.4).isActive = true
        txtTopView.topAnchor.constraint(equalTo: lblTopView.bottomAnchor).isActive = true
        txtTopView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        txtTopView.trailingAnchor.constraint(equalTo: topView.trailingAnchor).isActive = true
        txtTopView.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        lftView.topAnchor.constraint(equalTo: lblTopView.topAnchor).isActive = true
        lftView.leadingAnchor.constraint(equalTo: lblTopView.leadingAnchor).isActive = true
        lftView.bottomAnchor.constraint(equalTo: lblTopView.bottomAnchor).isActive = true
        lftView.widthAnchor.constraint(equalTo: lblTopView.widthAnchor, multiplier: 0.4).isActive = true
        
        rgtView.topAnchor.constraint(equalTo: lblTopView.topAnchor).isActive = true
        rgtView.trailingAnchor.constraint(equalTo: lblTopView.trailingAnchor).isActive = true
        rgtView.bottomAnchor.constraint(equalTo: lblTopView.bottomAnchor).isActive = true
        
        ntTitle.topAnchor.constraint(equalTo: lftView.topAnchor).isActive = true
        ntTitle.bottomAnchor.constraint(equalTo: lftView.bottomAnchor).isActive = true
        ntTitle.leadingAnchor.constraint(equalTo: lftView.leadingAnchor).isActive = true
        ntTitle.trailingAnchor.constraint(equalTo: lftView.trailingAnchor).isActive = true
        timeStamp.topAnchor.constraint(equalTo: rgtView.topAnchor).isActive = true
        timeStamp.leadingAnchor.constraint(equalTo: rgtView.leadingAnchor).isActive = true
        timeStamp.trailingAnchor.constraint(equalTo: rgtView.trailingAnchor).isActive = true
        timeStamp.bottomAnchor.constraint(equalTo: rgtView.bottomAnchor).isActive = true
        titleText.topAnchor.constraint(equalTo: txtTopView.topAnchor).isActive = true
        titleText.leadingAnchor.constraint(equalTo: txtTopView.leadingAnchor).isActive = true
        titleText.trailingAnchor.constraint(equalTo: txtTopView.trailingAnchor).isActive = true
        titleText.bottomAnchor.constraint(equalTo: txtTopView.bottomAnchor).isActive = true
        
        midView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 5).isActive = true
        midView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        midView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        midView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7).isActive = true
        ntTxtLbl.topAnchor.constraint(equalTo: midView.topAnchor).isActive = true
        ntTxtLbl.leadingAnchor.constraint(equalTo: midView.leadingAnchor).isActive = true
        ntTxtLbl.trailingAnchor.constraint(equalTo: midView.trailingAnchor).isActive = true
        noteTxtView.topAnchor.constraint(equalTo: ntTxtLbl.bottomAnchor, constant: 5).isActive = true
        noteTxtView.leadingAnchor.constraint(equalTo: midView.leadingAnchor).isActive = true
        noteTxtView.trailingAnchor.constraint(equalTo: midView.trailingAnchor).isActive = true
        noteTxtView.bottomAnchor.constraint(equalTo: midView.bottomAnchor).isActive = true
        
        btmView.topAnchor.constraint(equalTo: midView.bottomAnchor, constant: 8).isActive = true
        btmView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        btmView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        btmView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -15).isActive = true
        
        doneBtn.topAnchor.constraint(equalTo: btmView.topAnchor).isActive = true
        doneBtn.leadingAnchor.constraint(equalTo: btmView.leadingAnchor).isActive = true
        doneBtn.trailingAnchor.constraint(equalTo: btmView.trailingAnchor).isActive = true
        doneBtn.bottomAnchor.constraint(equalTo: btmView.bottomAnchor).isActive = true
        
        
        titleText.addTarget(self, action: #selector(DetailViewController.textFieldDidChange), for: .editingChanged)
        
        doneBtn.addTarget(self, action: #selector(doneBtnClicked), for: .touchUpInside)
        
    }
    
    
    
    @objc func textFieldDidChange() {
        print("check")

        if self.titleText.text != "" {
            print("working")
            doneBtn.isEnabled = true
            doneBtn.isHidden = false
        }
        else {
            //create mode
            if (titleText.text?.isEmpty ?? true) || (noteTxtView.text?.isEmpty ?? true) {
                doneBtn.isEnabled = false
                doneBtn.isHidden = true
            } else {
                doneBtn.isEnabled = true
                doneBtn.isHidden = false
            }
        }
    }
    
    @objc func doneBtnClicked() {
        if self.changingSimpleNote != nil {
            changeItem()
        } else {
            addItem()
        }
    }
    
    //add new item
    private func addItem() -> Void {
        let note = SimpleNote(noteTitle: titleText.text!, noteText: noteTxtView.text, noteTimeStamp: noteCreationTimeStamp)
        
        SimpleNoteStorage.storage.addNote(noteToBeAdded: note)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //change item that already exists.
    private func changeItem() {
        //get changed note instance
        if let changingSimpleNote = self.changingSimpleNote {
            //change note through note storage
            SimpleNoteStorage.storage.changeNote(noteToBeChanged: SimpleNote(noteId: changingSimpleNote.noteId, noteTitle: titleText.text!, noteText: noteTxtView.text, noteTimeStamp: noteCreationTimeStamp)
            )
            //navigate back to ViewController
            self.navigationController?.pushViewController(ViewController(), animated: true)
        } else {
            //create alert
            let alert = UIAlertController(title: "Unexpected Error", message: "Cannot Change the note, unexpected error occured. Try again later", preferredStyle: .alert)
            //add ok btn
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                self.navigationController?.pushViewController(ViewController(), animated: true)
            }))
            self.present(alert, animated: true)
        }
    }
    
    func setChangingSimpleNote(changingSimpleNote: SimpleNote) {
        self.changingSimpleNote = changingSimpleNote
    }
    
}
