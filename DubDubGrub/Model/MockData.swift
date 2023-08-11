//
//  MockData.swift
//  DubDubGrub
//
//  Created by Farangis Makhmadyorova on 18/07/23.
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
    
    static var sultanbey: CKRecord {
        let record = CKRecord(recordType: RecordType.location, recordID: CKRecord.ID(recordName: "CA3402F4-AA30-416B-AD93-7AD8910A1130"))
        record[DDGLocation.kName] = "SULTANBEY"
        record[DDGLocation.kAddress] = "улица Мирзо Турсунзаде 12, Душанбе, Таджикистан"
        record[DDGLocation.kDescription] = "Мы здесь! И у нас грандиозный и шикарный ресторан. Приходите в наш ресторан «SULTANBEY» и убедитесь в этом сами. А если коротко то, у нас уютно, превосходно и вкусно!"
        record[DDGLocation.kWebsiteURL] = "https://sultanbey.tj"
        record[DDGLocation.kLocation] = CLLocation(latitude: 38.571417, longitude: 68.796669)
        record[DDGLocation.kPhoneBumber] = "+992883038888"
        return record
    }
    
    static var profile: CKRecord {
        let record = CKRecord(recordType: RecordType.profile)
        record[DDGProfile.kFirstName] = "SuperLongFirstName"
        record[DDGProfile.kLastName] = "SuperLongLastNameJunior"
        record[DDGProfile.kCompanyName] = "Super Long Company Name Incorporated"
        record[DDGProfile.kBio] = "This is my bio, I hope it's not too long. I can't check character count."
        return record
    }
}
