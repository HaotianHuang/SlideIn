//
//  MainView.swift
//  SlideIn
//
//  Created by Haotian Huang on 14/7/21.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var model: TemplateModel
    
    var body: some View {
        
        NavigationView{
            ScrollView{
                LazyVStack(alignment: .leading, spacing: 30){
                    ForEach(model.templates) { template in
                        NavigationLink(destination: Drafting(template: template)) {
                            TemplatePreview(template: template)
                                .padding(.horizontal, 20)
                        }
                        
                    }
                }.padding(.top)
            }.navigationTitle("Templates")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
