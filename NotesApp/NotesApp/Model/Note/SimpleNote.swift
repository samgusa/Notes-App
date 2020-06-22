//
//  SimpleNote.swift
//  NotesApp
//
//  Created by Sam Greenhill on 6/16/20.
//  Copyright © 2020 simplyAmazingMachines. All rights reserved.
//


/*
 contains the implementation for the Note. SimpleNote is the container of the data of a note. it can be ninitialized by using UUID as well as without UUID. in case the instances is created w/out providing a UUID from outside, the UUID is generated using the UUID which is part of the Foundation
 */
import Foundation
import UIKit

class SimpleNote {
    private(set) var noteId : UUID
    private(set) var noteTitle : String
    private(set) var noteText : String
    private(set) var noteTimeStamp : Int64
    
    
    init(noteTitle: String, noteText: String, noteTimeStamp: Int64) {
        self.noteId = UUID()
        self.noteTitle = noteTitle
        self.noteText = noteText
        self.noteTimeStamp = noteTimeStamp
    }
    
    init(noteId: UUID, noteTitle: String, noteText: String, noteTimeStamp: Int64) {
        self.noteId = noteId
        self.noteTitle = noteTitle
        self.noteText = noteText
        self.noteTimeStamp = noteTimeStamp
    }
}


