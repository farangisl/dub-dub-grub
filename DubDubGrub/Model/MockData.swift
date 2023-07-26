//
//  MockData.swift
//  DubDubGrub
//
//  Created by IMacIBT1 on 18/07/23.
//

import CloudKit


struct MockData {
    
    static var location: CKRecord {
        
        let record = CKRecord(recordType: RecordType.location)
        record[DDGLocation.kName] = "Sean's Bar and Grill"
        record[DDGLocation.kAddress] = "123 Main Street"
        record[DDGLocation.kDescription] = "This is a test description. Isn't it awesome. Not sure how long to make it to test the 3 lines."
        record[DDGLocation.kWebsiteURL] = "https://apple.com"
        record[DDGLocation.kLocation] = CLLocation(latitude: 38.573840, longitude: 68.795335)
        record[DDGLocation.kPhoneBumber] = "+992502140014"
        
        return record
    }
    
    static var profile: CKRecord {
        
        let record = CKRecord(recordType: RecordType.profile)
        record[DDGProfile.kFirstName] = "Test"
        record[DDGProfile.kLastName] = "User"
        record[DDGProfile.kCompanyName] = "Best Company Ever"
        record[DDGProfile.kBio] = "This is my bio, I hope it's not too long. I can't check character count."
        return record
    }
}
