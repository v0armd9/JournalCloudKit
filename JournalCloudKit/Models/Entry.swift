//
//  Entry.swift
//  JournalCloudKit
//
//  Created by Darin Marcus Armstrong on 7/8/19.
//  Copyright © 2019 Darin Marcus Armstrong. All rights reserved.
//

import Foundation
import CloudKit

class Entry {
    let title: String
    let body: String
    let timestamp: Date
    let recordID: CKRecord.ID
    
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: EntryConstants.typeKey)
        
        record.setValue(title, forKey: EntryConstants.titleKey)
        record.setValue(body, forKey: EntryConstants.bodyKey)
        record.setValue(timestamp, forKey: EntryConstants.timestampKey)
        record.setValue(recordID, forKey: EntryConstants.recordIDKey)
        
        return record
    }
    
    init(title: String, body: String, timestamp: Date = Date(), recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.recordID = recordID
    }
    
    init?(record: CKRecord) {
        guard let title = record[EntryConstants.titleKey] as? String,
        let body = record[EntryConstants.bodyKey] as? String,
        let timestamp = record[EntryConstants.timestampKey] as? Date,
        let recordID = record[EntryConstants.recordIDKey] as? CKRecord.ID
            else {return nil}
        
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.recordID = recordID
    }
}

struct EntryConstants {
    static let typeKey = "Entry"
    fileprivate static let titleKey = "Title"
    fileprivate static let bodyKey = "Body"
    fileprivate static let timestampKey = "Timestamp"
    fileprivate static let recordIDKey = "RecordID"
    
}

extension Entry: Equatable {
    static func ==(lhs: Entry, rhs: Entry) -> Bool {
        return lhs.title == rhs.title &&
        lhs.body == rhs.body &&
        lhs.timestamp == rhs.timestamp &&
        lhs.recordID == rhs.recordID
    }
}
