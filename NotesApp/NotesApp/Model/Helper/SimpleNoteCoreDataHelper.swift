//
//  SimpleNoteCoreDataHelper.swift
//  NotesApp
//
//  Created by Sam Greenhill on 6/16/20.
//  Copyright © 2020 simplyAmazingMachines. All rights reserved.
//

import Foundation
import CoreData

/*
 has static methods and handles the reading, changing and saving of notes to coreData.
 
 needs instance of NSManagedObjectContext object, which is provided to it by using a parameter in each method
 */


class SimpleNoteCoreDataHelper {
    
    private(set) static var count: Int = 0
    
    static func createNoteInCoreData(noteToBeCreated: SimpleNote, intoManagedObjectContext: NSManagedObjectContext) {
        //lets create an entity and new note record
        let noteEntity = NSEntityDescription.entity(forEntityName: "Note", in: intoManagedObjectContext)!
        let newNoteToBeCreated = NSManagedObject(entity: noteEntity, insertInto: intoManagedObjectContext)
        
        newNoteToBeCreated.setValue(noteToBeCreated.noteId, forKey: "noteId")
        
        newNoteToBeCreated.setValue(noteToBeCreated.noteTitle, forKey: "noteTitle")
        
        newNoteToBeCreated.setValue(noteToBeCreated.noteText, forKey: "noteText")
        
        newNoteToBeCreated.setValue(noteToBeCreated.noteTimeStamp, forKey: "noteTimeStamp")
        
        do {
            try intoManagedObjectContext.save()
            count += 1
        } catch let error as NSError {
            //TODO error Handling
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func changeNoteInCoreData(noteToBeChanged: SimpleNote, inManagedObjectContext: NSManagedObjectContext) {
        //read managed object
        
        let fetchedRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        let noteIdPredicate = NSPredicate(format: "noteId = %@", noteToBeChanged.noteId as CVarArg)
        
        fetchedRequest.predicate = noteIdPredicate
        
        do {
            let fetchedNotesFromCoreData = try inManagedObjectContext.fetch(fetchedRequest)
            let noteManagedObjectToBeChanged = fetchedNotesFromCoreData[0] as! NSManagedObject
            
            //make the changed
            noteManagedObjectToBeChanged.setValue(noteToBeChanged.noteTitle, forKey: "noteTitle")
            noteManagedObjectToBeChanged.setValue(noteToBeChanged.noteText, forKey: "noteText")
            noteManagedObjectToBeChanged.setValue(noteToBeChanged.noteTimeStamp, forKey: "noteTimeStamp")
            
            //save
            try inManagedObjectContext.save()
            
        } catch let error as NSError {
            //TODO Error handling
            print("Could not change. \(error), \(error.userInfo)")
        }
    }
    
    static func readNotesFromCoreData(fromManagedObjectContext: NSManagedObjectContext) -> [SimpleNote] {
        var returnedNotes = [SimpleNote]()
        
        let fetchedRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchedRequest.predicate = nil
        
        do {
            let fetchedNotesFromCoreData = try fromManagedObjectContext.fetch(fetchedRequest)
            fetchedNotesFromCoreData.forEach { (fetchedRequestResult) in
                let noteManagedObjectRead = fetchedRequestResult as! NSManagedObject
                returnedNotes.append(SimpleNote.init(noteId: noteManagedObjectRead.value(forKey: "noteId") as! UUID, noteTitle: noteManagedObjectRead.value(forKey: "noteTitle") as! String, noteText: noteManagedObjectRead.value(forKey: "noteText") as! String, noteTimeStamp: noteManagedObjectRead.value(forKey: "noteTimeStamp") as! Int64))
            }
        } catch let error as NSError {
            //TODO Error handling
            print("could not read. \(error), \(error.userInfo)")
        }
        
        //set note Count
        self.count = returnedNotes.count
        
        return returnedNotes
    }
    
    
    static func readNoteFromCoreData(noteIdToBeRead: UUID, fromManagedObjectContext: NSManagedObjectContext) -> SimpleNote? {
        let fetchedRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        let noteIdPredicate = NSPredicate(format: "noteId = %@", noteIdToBeRead as CVarArg)
        
        fetchedRequest.predicate = noteIdPredicate
        
        
        do {
            let fetchedNotesFromCoreData = try fromManagedObjectContext.fetch(fetchedRequest)
            let noteManagedObjectToBeRead = fetchedNotesFromCoreData[0] as! NSManagedObject
            return SimpleNote.init(noteId: noteManagedObjectToBeRead.value(forKey: "noteId") as! UUID, noteTitle: noteManagedObjectToBeRead.value(forKey: "noteTitle") as! String, noteText: noteManagedObjectToBeRead.value(forKey: "noteText") as! String, noteTimeStamp: noteManagedObjectToBeRead.value(forKey: "noteTimeStamp") as! Int64)
        } catch let error as NSError {
            //TODO error handling
            print("Could not read: \(error), \(error.userInfo)")
            return nil
        }
    }
    
    
    static func deleteNoteFromCoreData(noteIdToBeDeleted: UUID, fromManagedObjectContext: NSManagedObjectContext) {
        
        let fetchedRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        let noteIdAsCVarArg: CVarArg = noteIdToBeDeleted as CVarArg
        let noteIdPredicate = NSPredicate(format: "noteId == %@", noteIdAsCVarArg)
        
        fetchedRequest.predicate = noteIdPredicate
        
        do {
            let fetchedNotesFromCoreData = try fromManagedObjectContext.fetch(fetchedRequest)
            let noteManagedObjectToBeDeleted = fetchedNotesFromCoreData[0] as! NSManagedObject
            fromManagedObjectContext.delete(noteManagedObjectToBeDeleted)
            
            do {
                try fromManagedObjectContext.save()
                self.count -= 1
            } catch let error as NSError {
                //TODO error handling
                print("Could not save. \(error), \(error.userInfo)")
            }
        } catch let error as NSError {
            //TODO error handling
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
}
