//
//  Template.swift
//  SlideIn
//
//  Created by Haotian Huang on 14/7/21.
//

import Foundation

struct Template : Decodable, Identifiable {
    
    var id = 0
    var title = "String"
    var features = ["Feature 1", "Feature 2", "Feature 3"]
    var content = "String here pretty long."
    
}
