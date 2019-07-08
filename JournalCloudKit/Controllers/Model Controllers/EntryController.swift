//
//  EntryController.swift
//  JournalCloudKit
//
//  Created by Darin Marcus Armstrong on 7/8/19.
//  Copyright © 2019 Darin Marcus Armstrong. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    static let shared = EntryController()
    
    var entries: [Entry] = []
    
    
    func save(entry: Entry, completion: @escaping (Bool) -> (Void)) {
        let record = CKRecord(entry: entry)
        CKContainer.default().privateCloudDatabase.save(record) { (record, error) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
                completion(false)
                return
            }
            
            guard let record = record,
                let entry = Entry(record: record)
                else {
                    completion (false)
                    return
            }
            self.entries.append(entry)
            completion(true)
        }
    }
    
    func addEntryWith(title: String, body: String, completion: @escaping (Bool) -> Void) {
        let entry = Entry(title: title, body: body)
        save(entry: entry, completion: completion)
    }
    
    func fetchEntries(completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: EntryConstants.typeKey, predicate: predicate)
        CKContainer.default().privateCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
                completion(false)
                return
            }
            guard let records = records
                else {
                    completion(false)
                    return
            }
            let entries = records.compactMap{ Entry(record: $0) }
            self.entries = entries
            completion(true)
        }
    }
}
