//
//  TemplateFeatures.swift
//  Recipe List App
//
//  Created by Haotian Huang on 28/6/21.
//

import SwiftUI

struct TemplateFeatures: View {
    
    var allFeatures = ""
    
    init(features: [String]) {
        
        // Loop through the highlights and build the string
        for index in 0..<features.count {
            
            
            // If this is last item don't add a comma
            if index == features.count - 1 {
                allFeatures += features[index]
            } else {
                allFeatures += features[index] + ", "
            }
            
        }
        
    }
    
    var body: some View {
        Text(allFeatures)
    }
}

struct RecipeHighlights_Previews: PreviewProvider {
    static var previews: some View {
        TemplateFeatures(features: ["test", "test2", "test3"])
    }
}
