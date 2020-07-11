//
//  SettingView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by tiantian on 2020/7/10.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    
    @EnvironmentObject var settings: SettingValues
    
    
    @State private var showingAlert = false
    
    var frameworks = ["UIKit", "Core Data", "CloudKit", "SwiftUI"]
    @State private var selectedFrameworkIndex = 0
    
    var body: some View {
        VStack{
            

            Button(action: {

                if settings.mode == "default" {
                    settings.mode = "spin"
                } else if settings.mode == "spin" {
                    settings.mode = "3D"
                } else if settings.mode == "3D" {
                    settings.mode = "default"
                }

            }) {
                Text("Mode: \(settings.mode)")
            }
            .padding()
            
//            HStack {
//                    Picker(selection: $selectedFrameworkIndex, label: Text("")) {
//                        ForEach(0 ..< frameworks.count) {
//                           Text(self.frameworks[$0])
//                        }
//                     }
//                     Text("Your favorite framework: \(frameworks[selectedFrameworkIndex])")
//                  }.padding()
            
            
            Button(action: {
                settings.hasAnimation = !settings.hasAnimation
            }) {
                if settings.hasAnimation {
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
                        "cuaisdygfrvehijodchbescdehirwasiugfhrvoushdklashjdciapuwdcilasjdcaoskhvfuoiewadhcasiuhcdv8weoriychdeasidcvgheasoidcsdcuyawdhcliasucdhjopasidchjoapsudhcvaopisidcjasopfhvddiuslrfyugjoadscijaedsiklrguyf;eao"
                       ), dismissButton: .default(Text("Dismiss")))
            }
            .padding()
            
            //Spacer()
            
        }
        
        
        
    }
}
