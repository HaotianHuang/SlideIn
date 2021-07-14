    //
//  TemplatePreview.swift
//  SlideIn
//
//  Created by Haotian Huang on 14/7/21.
//

import SwiftUI

struct TemplatePreview: View {
    
    var template: Template
    
    var body: some View {
        ZStack(alignment: .leading){
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: .gray, radius: 5, x: -5, y: 5)
            VStack(alignment: .leading, spacing: 10) {
                Text(template.title)
                    .font(.headline)
                    .bold()
                TemplateFeatures(features: template.features)
            }.foregroundColor(.black)
            .padding()
        }
    }
}

struct TemplatePreview_Previews: PreviewProvider {
    static var previews: some View {
        TemplatePreview(template: Template())
    }
}
