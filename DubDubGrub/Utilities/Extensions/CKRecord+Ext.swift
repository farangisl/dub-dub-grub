//
//  CKRecord+Ext.swift
//  DubDubGrub
//
//  Created by IMacIBT1 on 18/07/23.
//

import CloudKit

extension CKRecord {
    
    func convertToDDGLocation() -> DDGLocation {
        return DDGLocation(record: self)
    }
    
    func convertToDDGProfile() -> DDGProfile {
        return DDGProfile(record: self)
    }
}
