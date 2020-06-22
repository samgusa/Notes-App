//
//  ViewController.swift
//  NotesApp
//
//  Created by Sam Greenhill on 6/15/20.
//  Copyright © 2020 simplyAmazingMachines. All rights reserved.
//

import UIKit

//tableview here
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        tableView.delegate = self
        tableView.dataSource = self
        //Core data Initialization:
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            //create Alert:
            let alert = UIAlertController(title: "Could not get app delegate", message: "Could note get app delegate, unexpected error occurred. Try again later.", preferredStyle: .alert)

            //add ok btn
            alert.addAction(UIAlertAction(title: "OK", style: .default))

            //Show alert
            self.present(alert, animated: true)
            return
        }

        //need to refer the container in the AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        //set context in the storage:
        SimpleNoteStorage.storage.setManagedContext(managedObjectContext: managedContext)
    }
    
    override func loadView() {
        super.loadView()
        
        
        navigationItem.title = "Simple Note Taking App"
        
      
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject))
        navigationItem.rightBarButtonItem = addButton
        safeArea = view.layoutMarginsGuide
        self.setUpTable()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }


    func setUpTable() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    
    @objc func insertNewObject() {
        self.navigationController?.pushViewController(DetailViewController(), animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SimpleNoteStorage.storage.count()
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        if let object = SimpleNoteStorage.storage.readNote(at: indexPath.row) {
            cell.noteTitle.text = object.noteTitle
            cell.noteText.text = object.noteText
            cell.noteDateLbl.text = SimpleNoteDateHelper.convertDate(date: Date.init(seconds: object.noteTimeStamp))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            //remove objects
            SimpleNoteStorage.storage.removeNote(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = SimpleNoteStorage.storage.readNote(at: indexPath.row)
        let vcB = DisplayViewController()
        navigationController?.pushViewController(vcB, animated: true)
        vcB.detailsItem = object
        
    }
    

}



