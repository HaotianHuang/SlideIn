//
//  MainView.swift
//  SlideIn
//
//  Created by Haotian Huang on 14/7/21.
//

import SwiftUI
import UIKit

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
            }.navigationTitle("SlideIn Templates")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
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

