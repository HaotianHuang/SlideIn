//
//  Drafting.swift
//  SlideIn
//
//  Created by Haotian Huang on 14/7/21.
//

import SwiftUI

struct Drafting: View {
    
    @EnvironmentObject var model: TemplateModel
    
    var template: Template
    
    var body: some View {
        NavigationView{
            VStack(spacing: 5){
                Text(template.title)
                    .font(.title)
                Divider()
                    .frame(height: 20)
                    .padding(.horizontal, 20)
                TextBox(templateText: template.content)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.primary.opacity(0.04).ignoresSafeArea())
        }
    
        
    }
}

struct Drafting_Previews: PreviewProvider {
    static var previews: some View {
        Drafting(template: Template())
    }
}
