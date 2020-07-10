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
    
    @State private var showingAlert = false
    
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
            
            Button(action: {
                self.showingAlert = true
            }) {
                Text("About App")
            }
            .alert(isPresented: $showingAlert) {
                       Alert(title: Text("App Information"), message: Text(
                        "Temple photos are copyrighted by Intellectual Reserve, Inc. Used by permission. This app is a research project funded by Brigham Young University--Hawaii, however the contents are the responsibility of its developers. This app is not an official publication of the Church of Jesus Christ of Latter-day Saints."
                       ), dismissButton: .default(Text("Dismiss")))
            }
            .padding()
            
            //Spacer()
            
        }
        
        
        
    }
}
