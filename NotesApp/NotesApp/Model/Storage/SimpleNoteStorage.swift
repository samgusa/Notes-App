//
//  SimpleNoteStorage.swift
//  NotesApp
//
//  Created by Sam Greenhill on 6/16/20.
//  Copyright © 2020 simplyAmazingMachines. All rights reserved.
//

import Foundation
import CoreData

class SimpleNoteStorage {
    static let storage: SimpleNoteStorage = SimpleNoteStorage()
    
    
    private var noteIndexToIdDict: [Int: UUID] = [:]
    private var currentIndex : Int = 0
    
    private(set) var managedObjectContext: NSManagedObjectContext
    private var managedContextHasBeenSet: Bool = false
    
    
    private init() {
        //need to init the ManagedObkectContext
        //will be overwritten when setmanagedContext is called from vc
        managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
    }
    
    
    func setManagedContext(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        self.managedContextHasBeenSet = true
        
        let notes = SimpleNoteCoreDataHelper.readNotesFromCoreData(fromManagedObjectContext: self.managedObjectContext)
        currentIndex = SimpleNoteCoreDataHelper.count
        for (index, note) in notes.enumerated() {
            noteIndexToIdDict[index] = note.noteId
        }
    }
    
    func addNote(noteToBeAdded: SimpleNote) {
        if managedContextHasBeenSet {
            //add note UUID to the dictionary
            noteIndexToIdDict[currentIndex] = noteToBeAdded.noteId
            SimpleNoteCoreDataHelper.createNoteInCoreData(noteToBeCreated: noteToBeAdded, intoManagedObjectContext: self.managedObjectContext)
            //increase index
            currentIndex += 1
        }
    }
    
    func removeNote(at: Int) {
        if managedContextHasBeenSet {
            //check input index
            if at < 0 || at > currentIndex-1 {
                //todo error handling
                return
            }
            //get note UUID from the dictionary
            let noteUUID = noteIndexToIdDict[at]
            SimpleNoteCoreDataHelper.deleteNoteFromCoreData(noteIdToBeDeleted: noteUUID!, fromManagedObjectContext: self.managedObjectContext)
            //update note UUID from hte dictionary
            // the element we removed was not the last one: update GUID's
            if (at < currentIndex - 1) {
                //current index - 1 is the index of the last element
                //but we will remove the last element, so the loop goes only until
                //the index of the element begore the last element, which is currentIndex -2
                for i in at ... currentIndex - 2 {
                    noteIndexToIdDict[i] = noteIndexToIdDict[i+1]
                }
            }
            //remove the last element
            noteIndexToIdDict.removeValue(forKey: currentIndex)
            //decrease current index
            currentIndex -= 1
        }
    }
    
    
    func readNote(at: Int) -> SimpleNote? {
        if managedContextHasBeenSet {
            //check input index
            if at < 0 || at > currentIndex-1 {
                //todo error handling
                return nil
            }
            //get note UUID from the dictionary
            let noteUUID = noteIndexToIdDict[at]
            let noteReadFormCoreData: SimpleNote?
            noteReadFormCoreData = SimpleNoteCoreDataHelper.readNoteFromCoreData(noteIdToBeRead: noteUUID!, fromManagedObjectContext: self.managedObjectContext)
            return noteReadFormCoreData
        }
        return nil
    }
    
    
    func changeNote(noteToBeChanged: SimpleNote) {
        if managedContextHasBeenSet {
            //check if UUID is in the dictionary
            var noteToBeChangedIndex: Int?
            noteIndexToIdDict.forEach { (index: Int, noteId: UUID) in
                if noteId == noteToBeChanged.noteId {
                  noteToBeChangedIndex = index
                    return
                }
            }
            if noteToBeChangedIndex != nil {
                SimpleNoteCoreDataHelper.changeNoteInCoreData(noteToBeChanged: noteToBeChanged, inManagedObjectContext: self.managedObjectContext)
            } else {
                //TODO error handling
            }
        }
        
    }
    
    func count() -> Int {
        return SimpleNoteCoreDataHelper.count
    }
    
}
