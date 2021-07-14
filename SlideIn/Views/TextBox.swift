//
//  TextBox.swift
//  SlideIn
//
//  Created by Haotian Huang on 14/7/21.
//

import SwiftUI
import UIKit


struct TextBox: View {
    
    @State var inputText = ""
    
    @State var containerHeight: CGFloat = 400
    
    var templateText: String
    
    var body: some View {
        
        AdviceView(text: inputText)

        AutoSizingTF(templateText: templateText, hint: "Reveal template", text: $inputText, containerHeight: $containerHeight, onEnd: {
            // Do when keyboard closes...
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        })
        // Max height here...
        .frame(height: containerHeight <= 400 ? containerHeight : 400)
        .cornerRadius(10)
        .padding()
        
        ZStack{
            Rectangle()
                .frame(height: 50)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: .gray, radius: 2, x: -2, y: 2)
                .padding()
            Button("Copy to Clipboard 📋"){
                Functions.Copy(inputText)
            }
            .padding()
        }
   
        
        
    }
}

struct TextBox_Previews: PreviewProvider {
    static var previews: some View {
        TextBox(templateText: "Testing Template Text")
    }
}



// Building AutoSizing Text Field ...
struct AutoSizingTF: UIViewRepresentable {
    
    var templateText: String
    
    var hint: String
    @Binding var text: String
    @Binding var containerHeight: CGFloat
    var onEnd : ()->()
    
    func makeCoordinator() -> Coordinator {
        return AutoSizingTF.Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UITextView{
        
        let textView = UITextView()
        // Displaying text as hint...
        textView.text = hint
        textView.textColor = .gray
        
        textView.font = .systemFont(ofSize: 20)
        
        // setting delegate...
        textView.delegate = context.coordinator
        
        // Input accessory view ...
        // Your own custom size....
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolBar.barStyle = .default
        
        // since we need done at right...
        // so using item as spacer...
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: context.coordinator, action: #selector(context.coordinator.closeKeyBoard))
        
        toolBar.items = [spacer, doneButton]
        toolBar.sizeToFit()
        
        textView.inputAccessoryView = toolBar
        
        return textView
        
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        // Starting Text Field Height...
        DispatchQueue.main.async {
            if containerHeight == 0{
                containerHeight = uiView.contentSize.height
            }
        }
    }
}




class Coordinator: NSObject, UITextViewDelegate{
    
    // To read all parent properties...
    var parent: AutoSizingTF
    
    init(parent: AutoSizingTF) {
        self.parent = parent
    }
    
    // keyBoard Close @objc Function...
    @objc func closeKeyBoard(){
        
        parent.onEnd()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        // checking if text box is empty...
        // if so then clearing the hint...
        if textView.text == parent.hint{
            textView.text = parent.templateText
            textView.textColor = UIColor(Color.primary)
        }
    }
    // updating text in SwiftUI View...
    func textViewDidChange(_ textView: UITextView) {
        parent.text = textView.text
        parent.containerHeight = textView.contentSize.height
        
    }
    
    // On End checking if textbox is empty
    // if so then put hint...
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == ""{
            textView.text = parent.hint
            textView.textColor = .gray
        }
    }
    
}


