//
//  SettingView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by tiantian on 2020/7/10.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    
    @Environment (\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var mode: String
    @Binding var hasAnimation: Bool
    
    var modes = ["default", "spin", "3D"]
    @State private var modeIndex = 0
    
    var body: some View {
        VStack{
            Button(action: {
                if self.modeIndex == 2 {
                    self.modeIndex = 0
                } else {
                    self.modeIndex += 1
                }
                mode = modes[modeIndex]
            }) {
                Text("Mode: \(mode)")
            }
            .padding()
            Button(action: {
                hasAnimation = !hasAnimation
            }) {
                if hasAnimation {
                    Text("Animation: Yes")
                } else {
                    Text("Animation: No")
                    
                }
            }
            .padding()
        }
        
        
    }
}
