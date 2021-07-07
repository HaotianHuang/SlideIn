
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
        [
            0: "Looking good!✨",
            1: "Less shaking, more writing!",
            // Above is general, below is specific
            2: "Remember they're receiving 10 messages like this every day.",
            3: "Always offer value upfront, and value that they would likely appreciate.",
            4: "Are you reaching out with intent to give or to receive?",
            5: "“Reaching out” to a stranger should be a last resort not the first step.",
            6: "Remember there is a growing divide between people who TALK and people who DO. Understand what your intention is.",
            7: "Be wary of pushing responsibilities over to strangers.",
            8: "If you want to ask for something, make your intentions clear from the start.",
            9: "Remember to respect them and to respect yourself.",
            10: "Can you be more specific?🤔❗",
            11: "Is this something you need their help with? Or can you figure it out on Google.",
            12: "🧠...CEOs and senior executives hate this question. They say it’s self-serving, wastes time, and isn’t reciprocal 😡",
            13: "They are almost everywhere! Now aren’t they?? Seek and thou shall find 🧐",
            14: "Knowledge is indeed everything, but with a little digging do you reckon you could find these elsewhere?⛏️👷",
            15: "Time is money, is it not? What do they really have to gain from providing you with guidance, what can you do to earn their time?? ⏰💰💸💰",
            16: "No doubt you need it, but is there a better way of saying that ... I’m sure you’d be grateful for their help."
        ]
    
    @State private var num = 0
    
    @State var coolArray = ["..."]
    
    @State private var shakeCounter = 0
    
    
    // MARK: CONTENT VIEW
    var body: some View {
        NavigationView{
            VStack(spacing: 5) {
                Text("Shake for wisdom 🥺")
                    .foregroundColor(.blue)
                    .bold()
                    .onShake {
                        shakeCounter += 1
                        let luckyChoice = 1
                        if luckyChoice == 0 {
                            //                            let newNum = Int.random(in: 0...6)
                            //                            if newNum != num {
                            //                                num = newNum
                            //                            }
                            //                            if newNum == num {
                            //                                num = Int.random(in: 0...6)
                            //                            }
                        }
                        if luckyChoice == 1{
                            coolArray = text.components(separatedBy: " ")
                            for index in 0..<coolArray.count {
                                if coolArray[index].lowercased() == "hey" {
                                    num = 2
                                }
                                if coolArray[index].lowercased() == "benefit" {
                                    num = 3
                                }
                                if coolArray[index].lowercased() == "give" {
                                    num = 4
                                }
                                if coolArray[index].lowercased() == "me" {
                                    num = 5
                                }
                                if coolArray[index].lowercased() == "chance" {
                                    num = 6
                                }
                                if coolArray[index].lowercased() == "want" {
                                    num = 7
                                }
                                if coolArray[index].lowercased() == "also" {
                                    num = 8
                                }
                                if coolArray[index].lowercased() == "help" {
                                    num = 9
                                }
                                if coolArray[index].lowercased() == "tips"{
                                    num = 10
                                }
                                if coolArray[index].lowercased() == "could" {
                                    num = 11
                                }
                                if coolArray[index].lowercased() == "brains" {
                                    num = 12
                                }
                                if coolArray[index].lowercased() == "information" {
                                    num = 13
                                }
                                if coolArray[index].lowercased() == "knowledge" {
                                    num = 14
                                }
                                if coolArray[index].lowercased() == "time" {
                                    num = 15
                                }
                                if coolArray[index].lowercased() == "need" {
                                    num = 16
                                }
                                
                            }
                        }
                        if shakeCounter >= Int.random(in: 3...6) {
                            num = Int.random(in: 0...1)
                            shakeCounter = 0
                        }
                    }
                
                Text(array[num]! + " (\(String(shakeCounter)))")
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

