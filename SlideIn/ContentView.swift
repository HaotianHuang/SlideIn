
//
//  ContentView.swift
//  expandable text input
//
//  Created by Haotian Huang on 15/6/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: .onShake Creation

// The notification we'll send when a shake gesture happens.
extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

//  Override the default behavior of shake gestures to send our notification instead.
extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
    }
}

// A view modifier that detects shaking and calls a function of our choosing.
struct DeviceShakeViewModifier: ViewModifier {
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                action()
            }
    }
}

// A View extension to make the modifier easier to use.
extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceShakeViewModifier(action: action))
    }
}

// An example view that responds to being shaken


// MARK: Create resizeable text box

struct Home: View {
    
    @State var text = ""
    
    
    // Auto updating TextBox Height...
    @State var containerHeight: CGFloat = 0
    
    @State private var array =
        ["Remember they're receiving 10 messages like this every day.",
         "Always offer value upfront, and value that they would likely appreciate.",
         "Are you reaching out with intent to give or to receive?", "Why are you being so needy. Figure it out yourself.", "Can you be more specific?🤔❗",
         "Will you actually use their help? Or, do you need to work on your portfolio?",
         "🧠...CEOs and senior executives hate this question. They say it’s self-serving, wastes time, and isn’t reciprocal 😡",
         "They are almost everywhere! Now aren’t they?? Seek and thou shall find 🧐",
         "Knowledge is indeed everything, but with a little digging do you reckon you could find these elsewhere?⛏️👷",
         "Time is money, is it not? What do they really have to gain from providing you with guidance, what can you do to earn their time?? ⏰💰💸💰",
         "No doubt you need it, but is there a better way of saying that ... I’m sure you’d be grateful for their help."]
    
    @State private var num = 0
    
    @State var coolArray = ["..."]
    
    
    // MARK: CONTENT VIEW
    var body: some View {
        NavigationView{
            VStack(spacing: 5) {
                Text("Shake for wisdom 🥺")
                    .foregroundColor(.blue)
                    .bold()
                    .onShake {
                        let luckyChoice = Int.random(in: 0...1)
                        if luckyChoice == 0 {
                            let newNum = Int.random(in: 0..<array.count)
                            if newNum != num {
                                num = newNum
                            }
                            if newNum == num {
                                num = Int.random(in: 0..<array.count)
                            }
                        }
                        if luckyChoice == 1{
                            coolArray = text.components(separatedBy: " ")
                            for index in 0..<coolArray.count {
                                if coolArray[index].lowercased() == "please" {
                                    num = 3
                                }
                                if coolArray[index].lowercased() == "tips" {
                                    num = 4
                                }
                                if coolArray[index].lowercased() == "help" {
                                    num = 5
                                }
                                if coolArray[index].lowercased() == "brains" || coolArray[index].lowercased() == "brain"{
                                    num = 6
                                }
                                if coolArray[index].lowercased() == "opportunity" {
                                    num = 7
                                }
                                if coolArray[index].lowercased() == "ask you" {
                                    num = 8
                                }
                                if coolArray[index].lowercased() == "time" {
                                    num = 9
                                }
                                if coolArray[index].lowercased() == "need" {
                                    num = 10
                                }
                                
                            }
                        }
                    }
                
                Text(array[num])
                    .padding(.horizontal)
                //.fixedSize(horizontal: false, vertical: true)
                
                //Text(array[num])
                //.padding(.horizontal)
                
                AutoSizingTF(hint: "Enter Message", text: $text, containerHeight: $containerHeight, onEnd: {
                    
                    // Do when keyboard closes...
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                })
                //.padding(.horizontal)
                
                // Your Max height here ...
                
                .frame(height: containerHeight <= 200 ? containerHeight : 200)
                //.background(Color.white)
                .cornerRadius(10)
                .padding()
                
                
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.primary.opacity(0.04).ignoresSafeArea())
        }
        
    }
}

// Building AutoSizing Text Field ...
struct AutoSizingTF: UIViewRepresentable {
    
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
        
        // since we need dnoe at right...
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
            textView.text = ""
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

