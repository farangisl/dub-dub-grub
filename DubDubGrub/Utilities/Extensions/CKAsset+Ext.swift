//
//  CKAsset+Ext.swift
//  DubDubGrub
//
//  Created by Farangis Makhmadyorova on 19/07/23.
//

import CloudKit
import UIKit


extension CKAsset {
    
    func convertToUIImage(in dimension: ImageDimension) -> UIImage {
        guard let fileURL = self.fileURL else { return dimension.placeholder }
        
        do {
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data) ?? dimension.placeholder
        } catch {
            return dimension.placeholder
        }
    }
}
