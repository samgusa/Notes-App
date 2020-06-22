//
//  SimpleNoteDateHelper.swift
//  NotesApp
//
//  Created by Sam Greenhill on 6/16/20.
//  Copyright © 2020 simplyAmazingMachines. All rights reserved.
//

import Foundation
import UIKit

class SimpleNoteDateHelper {
    
    static func convertDate(date: Date) -> String {
        let formatter = DateFormatter()
        //initially set the format based on your datepicker date / server string
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: date)
        //convert your string to date
        let yourDate = formatter.date(from: myString)
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        return myStringafd
        
    }
    
}


extension Date {
    func toSeconds() -> Int64! {
        return Int64((self.timeIntervalSince1970).rounded())
    }
    
    init(seconds: Int64!) {
        self = Date(timeIntervalSince1970: TimeInterval(Double.init(seconds)))
    }
}
