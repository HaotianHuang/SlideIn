//
//  AdviceView.swift
//  SlideIn
//
//  Created by Haotian Huang on 14/7/21.
//

import SwiftUI

struct AdviceView: View {
    
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
            10: "Have you made your request specific?🤔",
            11: "Is this something you need their help with? Or can you figure it out on Google.",
            12: "🧠...CEOs and senior executives hate this question. They say it’s self-serving, wastes time, and isn’t reciprocal 😡",
            13: "Be cautious of offloading research you should be doing onto others.",
            14: "Knowledge is indeed everything, but with a little digging do you reckon you could find these elsewhere?⛏️👷",
            15: "Time is money, is it not? What do they really have to gain from providing you with guidance, what can you do to earn their time?? ⏰💰💸💰",
            16: "No doubt you need it, but is there a better way of saying that ... I’m sure you’d be grateful for their help.",
            17: "Is this something they are uniquely positioned to help you with or answer?"
        ]
    
    @State private var num = 0
    
    @State var inputArray = ["..."]
    
    var text: String
    
    var body: some View {
        VStack{
            Text("🔮: " + array[num]!)
                .padding(.horizontal, 10)
                .onShake {
                        inputArray = text.components(separatedBy: " ")
                        for index in 0..<inputArray.count {
                            if  Functions.Check(inputArray[index], "hey", "hello", "hi", "hii") {
                                num = 2
                            }
                            if Functions.Check(inputArray[index], "can"){
                                num = 3
                            }
                            if Functions.Check(inputArray[index], "give") {
                                num = 4
                            }
                            if Functions.Check(inputArray[index], "me", "I", "my"){
                                num = 5
                            }
                            if Functions.Check(inputArray[index], "chance", "possible", "possibly"){
                                num = 6
                            }
                            if Functions.Check(inputArray[index], "want", "would like") {
                                num = 7
                            }
                            if Functions.Check(inputArray[index], "also") {
                                num = 8
                            }
                            if Functions.Check(inputArray[index], "help") {
                                num = 9
                            }
                            if Functions.Check(inputArray[index], "know"){
                                num = 10
                            }
                            if Functions.Check(inputArray[index], "could") {
                                num = 11
                            }
                            if Functions.Check(inputArray[index], "brains", "brain") {
                                num = 12
                            }
                            if Functions.Check(inputArray[index], "information") {
                                num = 13
                            }
                            if Functions.Check(inputArray[index], "knowledge"){
                                num = 14
                            }
                            if Functions.Check(inputArray[index], "time") {
                                num = 15
                            }
                            if Functions.Check(inputArray[index], "need"){
                                num = 16
                            }
                            if Functions.Check(inputArray[index], "advice", "tips"){
                                num = 17
                            }
                        }
                    }
                
        }
    }
}



struct AdviceView_Previews: PreviewProvider {
    static var previews: some View {
        AdviceView(text: "yeet yeet yeet")
    }
}
