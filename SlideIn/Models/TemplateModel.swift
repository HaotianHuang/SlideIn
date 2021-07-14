//
//  TemplateModel.swift
//  SlideIn
//
//  Created by Haotian Huang on 14/7/21.
//

import Foundation

class TemplateModel: ObservableObject {
    
    @Published var templates = [Template]()
    
    var styleData: Data?
    
    init(){
        self.templates = getLocalJson()
    }
    
    func getLocalJson(_ filename: String = "data", fileExtension: String = "json") -> [Template] {
            var templates = [Template]()
        
        // Get link to data file
        let url = Bundle.main.url(forResource: filename, withExtension: fileExtension)
        
        guard url != nil else {
            print("Could not retrieve category data: \(filename).\(fileExtension) not found.")
            return templates
        }
        do {
            // Decode the data and return it
            let data = try Data(contentsOf: url!)
            templates = try JSONDecoder().decode([Template].self, from: data)
            return templates
        } catch {
            print("Error retrieving category data \(error.localizedDescription)")
        }
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        do {
            // read the file into a data object
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData
        }
        catch {
            print("Couldn't parse style data")
        }
        return templates
    }
}
