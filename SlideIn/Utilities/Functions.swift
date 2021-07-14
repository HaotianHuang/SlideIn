//
//  Functions.swift
//  SlideIn
//
//  Created by Haotian Huang on 14/7/21.
//

import Foundation
import UIKit

struct Functions {
    
    static func Check(_ txt: String, _ ref: String...) -> Bool {
        
            for item in ref {
                if txt.lowercased() == item.lowercased() {
                    return true
                }
            }
            return false
    }
    
    static func Copy(_ text: String){
        let string = text
        let pasteboard = UIPasteboard.general
        pasteboard.string = string
    }
    
    // MARK: Vibration

    static func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    static func simpleError() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
}


