//
//  HapticManager.swift
//  DubDubGrub
//
//  Created by Farangis Makhmadyorova on 04/08/23.
//

import UIKit

struct HapticManager {
    
    func playSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}
