//
//  ProfileViewModel.swift
//  DubDubGrub
//
//  Created by Farangis Makhmadyorova on 24/07/23.
//

import CloudKit
import UIKit

enum ProfileContext { case create, update }

extension ProfileView {
    
    @MainActor final class ProfileViewModel: ObservableObject {
        
        @Published var firstName = ""
        @Published var lastName = ""
        @Published var companyName = ""
        @Published var bioText: String = ""
        @Published var avatar = PlaceholderImage.avatar
        @Published var isShowingPhotoPicker = false
        @Published var isLoading = false
        @Published var isCheckedIn = false
        @Published var alertItem: AlertItem?
        
        private var existingProfileRecord: CKRecord? {
            didSet { profileContext = .update }
        }
        
        var profileContext: ProfileContext = .create
        var buttonTitle: String { profileContext == .create ? "Create Profile" : "Update Profile" }
        
        
        private func isValidProfile() -> Bool {
            guard !firstName.isEmpty,
                  !lastName.isEmpty,
                  !companyName.isEmpty,
                  !bioText.isEmpty,
                  avatar != PlaceholderImage.avatar,
                  bioText.count <= 100 else { return false }
            
            return true
        }
        
        
        func getCheckedInStatus() {
            guard let profileRecordID = CloudKitManager.shared.profileRecordID else { return }
            
            Task {
                do {
                    let record = try await CloudKitManager.shared.fetchRecord(with: profileRecordID)
                    if let _ = record[DDGProfile.kIsCheckedIn] as? CKRecord.Reference {
                        isCheckedIn = true
                    } else {
                        isCheckedIn = false
                    }
                } catch {
                    print("Unable to get checked in status")
                }
            }
        }
        
        
        func checkOut() {
            guard let profileID = CloudKitManager.shared.profileRecordID else {
                alertItem = AlertContext.unableToGetProfile
                return
            }
            
            showLoadingView()
            
            Task {
                do {
                    let record = try await CloudKitManager.shared.fetchRecord(with: profileID)
                    record[DDGProfile.kIsCheckedIn] = nil
                    record[DDGProfile.kIsCheckedInNilCheck] = nil
                    
                    let _ = try await CloudKitManager.shared.save(record: record)
                    let generator = await UINotificationFeedbackGenerator()
                    await generator.notificationOccurred(.success)
                    isCheckedIn = false
                    hideLoadingView()
                } catch {
                    self.hideLoadingView()
                    self.alertItem = AlertContext.unableToCheckInOrOut
                }
            }
        }
        
        
        func determineButtonAction() {
            profileContext == .create ? createProfile() : updateProfile()
        }
        
        
        private func createProfile() {
            guard isValidProfile() else {
                alertItem = AlertContext.invalidProfile
                return
            }
            
            // Create our CKRecord from the profile view
            let profileRecord = createProfileRecord()
            guard let userRecord = CloudKitManager.shared.userRecord else {
                alertItem = AlertContext.noUserRecord
                return
            }
            
            userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
            
            showLoadingView()
            
            Task {
                do {
                    let records = try await CloudKitManager.shared.batchSave(records: [userRecord, profileRecord])
                    for record in records where record.recordType == RecordType.profile {
                        existingProfileRecord = record
                        profileContext = .update
                        CloudKitManager.shared.profileRecordID = record.recordID
                    }
                    hideLoadingView()
                    alertItem = AlertContext.createProfileSuccess
                } catch {
                    hideLoadingView()
                    alertItem = AlertContext.createProfileFailure
                }
            }
        }
        
        
        func getProfile() {
            guard let userRecord = CloudKitManager.shared.userRecord else {
                alertItem = AlertContext.noUserRecord
                return
            }
            
            guard let profileReference = userRecord["userProfile"] as? CKRecord.Reference else { return }
            let profileRecordID = profileReference.recordID
            
            showLoadingView()
            
            Task {
                do {
                    let record = try await CloudKitManager.shared.fetchRecord(with: profileRecordID)
                    existingProfileRecord = record
                    
                    let profile = DDGProfile(record: record)
                    firstName = profile.firstName
                    lastName = profile.lastName
                    companyName = profile.companyName
                    bioText = profile.bio
                    avatar = profile.avatarImage
                    hideLoadingView()
                } catch {
                    alertItem = AlertContext.unableToGetProfile
                    hideLoadingView()
                }
            }
        }
        
        
        private func updateProfile() {
            guard isValidProfile() else {
                alertItem = AlertContext.invalidProfile
                return
            }
            
            guard let existingProfileRecord else {
                alertItem = AlertContext.unableToGetProfile
                return
            }
            
            existingProfileRecord[DDGProfile.kFirstName] = firstName
            existingProfileRecord[DDGProfile.kLastName] = lastName
            existingProfileRecord[DDGProfile.kCompanyName] = companyName
            existingProfileRecord[DDGProfile.kBio] = bioText
            existingProfileRecord[DDGProfile.kAvatar] = avatar.convertToCKAsset()
            
            showLoadingView()
            
            Task {
                do {
                    let _ = try await CloudKitManager.shared.save(record: existingProfileRecord)
                    hideLoadingView()
                    alertItem = AlertContext.updateProfileSuccess
                } catch {
                    hideLoadingView()
                    alertItem = AlertContext.updateProfileFailure
                }
            }
        }
        
        
        private func createProfileRecord() -> CKRecord {
            let profileRecord = CKRecord(recordType: RecordType.profile)
            profileRecord[DDGProfile.kFirstName] = firstName
            profileRecord[DDGProfile.kLastName] = lastName
            profileRecord[DDGProfile.kCompanyName] = companyName
            profileRecord[DDGProfile.kBio] = bioText
            profileRecord[DDGProfile.kAvatar] = avatar.convertToCKAsset()
            return profileRecord
        }
        
        
        private func showLoadingView() { isLoading = true }
        private func hideLoadingView() { isLoading = false }
        
    }
}


