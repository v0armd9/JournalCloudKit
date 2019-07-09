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
    var title: String
    var body: String
    var timestamp: Date
    let recordID: CKRecord.ID
    
    init(title: String, body: String, timestamp: Date = Date(), recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.recordID = recordID
    }
    
    convenience init?(record: CKRecord) {
        guard let title = record[EntryConstants.titleKey] as? String,
        let body = record[EntryConstants.bodyKey] as? String,
        let timestamp = record[EntryConstants.timestampKey] as? Date
        else {return nil}
        
        self.init(title: title, body: body, timestamp: timestamp, recordID: record.recordID)
    }
}

struct EntryConstants {
    static let typeKey = "Entry"
    static let titleKey = "Title"
    static let bodyKey = "Body"
    fileprivate static let timestampKey = "Timestamp"
    fileprivate static let recordIDKey = "RecordID"
    
}

extension CKRecord {
    convenience init(entry: Entry) {
        self.init(recordType: EntryConstants.typeKey, recordID: entry.recordID)
        self.setValue(entry.title, forKey: EntryConstants.titleKey)
        self.setValue(entry.body, forKey: EntryConstants.bodyKey)
        self.setValue(entry.timestamp, forKey: EntryConstants.timestampKey)
    }
}

extension Entry: Equatable {
    static func ==(lhs: Entry, rhs: Entry) -> Bool {
        return lhs.title == rhs.title &&
        lhs.body == rhs.body &&
        lhs.timestamp == rhs.timestamp &&
        lhs.recordID == rhs.recordID
    }
}
