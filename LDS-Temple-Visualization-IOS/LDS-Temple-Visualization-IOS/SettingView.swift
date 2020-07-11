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
    

    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color.gray)
            VStack {
                
                VStack {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(settings.defaultColor)
                        Text("Default")
                    }
                    .onTapGesture {
                        SwiftUI.withAnimation(.linear) {
                            settings.mode = "default"
                            settings.defaultColor = settings.selectedColor
                            settings.spinColor = settings.unSelectedColor
                            settings.threeDColor = settings.unSelectedColor
                        }
                        
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(settings.spinColor)
                        Text("Spin")
                        
                    }
                    .onTapGesture {
                        SwiftUI.withAnimation(.linear) {
                            settings.mode = "spin"
                            settings.defaultColor = settings.unSelectedColor
                            settings.spinColor = settings.selectedColor
                            settings.threeDColor = settings.unSelectedColor
                        }
                        
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(settings.threeDColor)
                        Text("3D")
                    
                    }
                    .onTapGesture {
                        SwiftUI.withAnimation(.linear) {
                            settings.mode = "3D"
                            settings.defaultColor = settings.unSelectedColor
                            settings.spinColor = settings.unSelectedColor
                            settings.threeDColor = settings.selectedColor
                        }
                        
                    }
                    
                    Text("Mode: \(settings.mode)")
                        .foregroundColor(Color.blue)
                        .padding()
                }
                
                
//                Button(action: {
//
//                    if settings.mode == "default" {
//                        settings.mode = "spin"
//                    } else if settings.mode == "spin" {
//                        settings.mode = "3D"
//                    } else if settings.mode == "3D" {
//                        settings.mode = "default"
//                    }
//
//                }) {
//                    Text("Mode: \(settings.mode)")
//                }
                
                .frame(maxWidth: screenWidth/2)
                
                //Text("Mode: \(effects[selectedEffectIndex])")
            }
            //.background(Color.gray)
            
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
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color.gray)
            VStack {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(settings.hasAnimationOnColor)
                    Text("On")
                }
                .onTapGesture {
                    SwiftUI.withAnimation(.linear) {
                        settings.hasAnimation = true
                        settings.hasAnimationOnColor = settings.selectedColor
                        settings.hasAnimationOffColor = settings.unSelectedColor
                    }
                    
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(settings.hasAnimationOffColor)
                    Text("Off")
                        
                }
                .onTapGesture {
                    SwiftUI.withAnimation(.linear) {
                        settings.hasAnimation = false
                        settings.hasAnimationOnColor = settings.unSelectedColor
                        settings.hasAnimationOffColor = settings.selectedColor
                    }
                    
                }

//                Picker(selection: $selectedAnimationSpeedIndex, label: Text("")) {
//                    ForEach(0 ..< animationSpeeds.count) {
//                        Text(self.animationSpeeds[$0])
//                    }
//                }
//
//                .frame(maxWidth: screenWidth/2)
                
                Text("Animation: \(settings.hasAnimation == true ? "On" : "Off")")
                    .foregroundColor(Color.blue)
                    .padding()
            }
            //.background(Color.gray)
            
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

