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
    
    
    
    var body: some View {
        
//        NavigationView {
//
//
//            .background(Color.gray)
//            .navigationBarTitle("Settings", displayMode: .inline)
//
//        }
            
        
            
        
        return HStack {
            
            if settings.showAbout == true {
                AboutView()
            } else {
                VStack {

                    HStack {

                        SpiralEffectSettingView()

                        AnimationSettingView()

                    }

                    HStack {
                        AboutButtonView()
                        MoreButtonView()
                    }

                }
            }
            
        
        }
        
        
        
        
        
        
        
        
    }
}

struct SpiralEffectSettingView: View {
    
    @EnvironmentObject var settings: SettingValues
    
    var effects = ["default", "spin", "3D"]
    @State private var selectedEffectIndex = 0
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color.gray)
            VStack {
                Picker(selection: $selectedEffectIndex, label: Text("")) {
                    ForEach(0 ..< effects.count) {
                        Text(self.effects[$0])
                    }
                }
                .frame(maxWidth: screenWidth/2)
                     Text("Mode: \(effects[selectedEffectIndex])")
            }
            .background(Color.gray)
            
        }
        
        
        
        
        
        
        
        
        
                    
        
//        Button(action: {
//
//            if settings.mode == "default" {
//                settings.mode = "spin"
//            } else if settings.mode == "spin" {
//                settings.mode = "3D"
//            } else if settings.mode == "3D" {
//                settings.mode = "default"
//            }
//
//        }) {
//            Text("Mode: \(settings.mode)")
//        }
//        .padding()
    }
}

struct AnimationSettingView: View {
    
    @EnvironmentObject var settings: SettingValues
    
    var animationSpeeds = ["Yes", "No"]
    @State private var selectedAnimationSpeedIndex = 0
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color.gray)
            VStack {
                Picker(selection: $selectedAnimationSpeedIndex, label: Text("")) {
                    ForEach(0 ..< animationSpeeds.count) {
                        Text(self.animationSpeeds[$0])
                    }
                }
                .frame(maxWidth: screenWidth/2)
                Text("Animation: \(animationSpeeds[selectedAnimationSpeedIndex])")
            }
            .background(Color.gray)
            
        }
        
        
        
        
        
//        Button(action: {
//            settings.hasAnimation = !settings.hasAnimation
//        }) {
//            if settings.hasAnimation {
//                Text("Animation: Yes")
//            } else {
//                Text("Animation: No")
//
//            }
//        }
//        .padding()
    }
}


struct AboutButtonView: View {
    
    @EnvironmentObject var settings: SettingValues
    
    var body: some View {
        
        
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color.gray)
            Button(action: {
                SwiftUI.withAnimation(.easeIn) {
                    settings.showAbout = true
                }
                
            }) {
                Text("About App")
                    .foregroundColor(Color.white)
            }
            .padding()
        }
        

        
//        Button(action: {
//            self.showingAlert = true
//        }) {
//            Text("About App")
//        }
//        .alert(isPresented: $showingAlert) {
//                   Alert(title: Text("App Information"), message: Text(
//                    "cuaisdygfrvehijodchbescdehirwasiugfhrvoushdklashjdciapuwdcilasjdcaoskhvfuoiewadhcasiuhcdv8weoriychdeasidcvgheasoidcsdcuyawdhcliasucdhjopasidchjoapsudhcvaopisidcjasopfhvddiuslrfyugjoadscijaedsiklrguyf;eao"
//                   ), dismissButton: .default(Text("Dismiss")))
//        }
//        .padding()
        
    }
}

struct MoreButtonView: View {
    
    @EnvironmentObject var settings: SettingValues
    
    var body: some View {
        
        
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color.gray)
            Text("More to Come")
        }
    }
}

