//
//  ContentView.swift
//  SlideIn
//
//  Created by Haotian Huang on 15/6/21.
//

import SwiftUI

struct ContentView: View {
    
    
    @State var array = ["Don't go through the front door", "Make sure you are nice", "Heck Yes"]

    @State var num = 0
    
    var body: some View {
        VStack(spacing: 5) {
            Text(array[num])
            Button(action: {
                let newNum = Int.random(in: 0..<array.count)
                if newNum != num {
                    num = newNum
                }
                if newNum == num {
                    num = Int.random(in: 0..<array.count)
                }
            }, label: {
                Text("Get Inspo 🥺")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}

