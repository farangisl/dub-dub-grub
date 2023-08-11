//
//  AlertItem.swift
//  DubDubGrub
//
//  Created by Farangis Makhmadyorova on 19/07/23.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
    
    var alert: Alert {
        Alert(title: title, message: message, dismissButton: dismissButton)
    }
}

struct AlertContext {
    
//MARK: - MapView Errors
    
    static let unableToGetLocations = AlertItem(title: Text("Locations Error"),
                                                message: Text("Unable to retrieve locations at this time. \nPlease try again."),
                                                dismissButton: .default(Text("OK")))
    
    static let locationRestricted = AlertItem(title: Text("Locations Restricted"),
                                                message: Text("Your location is restricted. This may be due to parental controls."),
                                                dismissButton: .default(Text("OK")))
    
    static let locationDenied = AlertItem(title: Text("Locations Denied"),
                                                message: Text("Dub Dub Grab does not have permission to access your location. To change that go to your phone's Settings > Dub Dub Grub > Location"),
                                                dismissButton: .default(Text("OK")))
    
    static let locationDisabled = AlertItem(title: Text("Locations Service Disabled"),
                                                message: Text("Your phone's location services are disabled. To change that go to your phone's Settings > Privacy > Location Services."),
                                                dismissButton: .default(Text("OK")))
    
    static let checkedInCount = AlertItem(title: Text("Server Error"),
                                                message: Text("Unable to get the number of people checked into each location. Please check your internet connection and try again."),
                                                dismissButton: .default(Text("OK")))
    
//MARK:    - LocationListView Errors
            
    static let unableToGetAlICheckedinProfiles = AlertItem(title: Text("Server Error"),
                                                           message: Text("We are unable to get users checked into all locations at this time.\nPlease try again."),
                                                           dismissButton: .default(Text("OK")))
    
    
//MARK:    - ProfileView Errors
    
    static let invalidProfile = AlertItem(title: Text("Invalid Profile"),
                                                message: Text("All fields are required as well as a profile photo. Your bio must be < 100 characters. Please try again."),
                                                dismissButton: .default(Text("OK")))
    
    static let noUserRecord = AlertItem(title: Text("No User Record"),
                                                message: Text("You must log into iCloud on your phone in order to utilize Dub Dub Grub's Profile. Please log in on your phone's settings screen."),
                                                dismissButton: .default(Text("OK")))
    
    static let createProfileSuccess = AlertItem(title: Text("Profile Created Successfully."),
                                                message: Text("Your profile has successfully been created."),
                                                dismissButton: .default(Text("OK")))
    
    static let createProfileFailure = AlertItem(title: Text("Failed to Create Profile."),
                                                message: Text("We were unable to create your profile at this time.\n Please try again later or contact customer support if this persists."),
                                                dismissButton: .default(Text("OK")))
    
    static let unableToGetProfile = AlertItem(title: Text("Unable to Retrieve Profile"),
                                                message: Text("We were unable to retrieve your profile at this time. Please check your internet connection and try again later or contact customer support if this persists."),
                                                dismissButton: .default(Text("OK")))
    
    static let updateProfileSuccess = AlertItem(title: Text("Profile Update Success!"),
                                                message: Text("Your Dub Dub Grub profile was updated successfully"),
                                                dismissButton: .default(Text("Sweet!")))
    
    static let updateProfileFailure = AlertItem(title: Text("Profile Update Failed"),
                                                message: Text("We were unable to update your profile at this time.\nPlease try again later."),
                                                dismissButton: .default(Text("OK")))
    
//MARK:    - LocationDetailView Errors
        
    static let invalidPhoheNumber = AlertItem(title: Text("Invalid Phone Number"),
                                                    message: Text("The phone number for the location is invalid. Please look up the phone number yourself."),
                                                    dismissButton: .default(Text("OK")))
    
    static let unableToGetCheckInStatus = AlertItem(title: Text("Server Error"),
                                                        message: Text("Unable to retrieve checked in status of the current user.\nPlease try again."),
                                                        dismissButton: .default(Text("OK")))
    
    static let unableToCheckInOrOut = AlertItem(title: Text("Server Error"),
                                                    message: Text("We are unable to check in/out at this time.\nPlease try again."),
                                                    dismissButton: .default(Text("OK")))
    
    static let unableToGetCheckedInProfiles = AlertItem(title: Text("Server Error"),
                                                        message: Text("We are unable to get users checked into this location at this time.\nPlease try again."),
                                                        dismissButton: .default(Text("OK")))
}
