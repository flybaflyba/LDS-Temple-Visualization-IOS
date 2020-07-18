//
//  SettingView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by tiantian on 2020/7/10.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    
    var body: some View {
        
        SettingViewMain()
            .navigationBarTitle("Settings")
        
    }
    

}

struct SettingViewMain: View {
    @EnvironmentObject var sharedValues: SharedValues
    
    
    
    var body: some View {
        
//        NavigationView {
//
//
//            .background(Color.gray)
//            .navigationBarTitle("Settings", displayMode: .inline)
//
//        }
        return HStack {
//            
//            if settings.showAbout == true {
//                AboutView()
//            } else {
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
//            }
        }
        
    }
        }

struct SpiralEffectSettingView: View {
    
    @EnvironmentObject var sharedValues: SharedValues
    

    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color.gray)
            VStack {
                
                VStack {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(sharedValues.defaultColor)
                        Text("Default")
                    }
                    .onTapGesture {
                        SwiftUI.withAnimation(.linear) {
                            sharedValues.mode = "default"
                            sharedValues.defaultColor = sharedValues.selectedColor
                            sharedValues.spinColor = sharedValues.unSelectedColor
                            sharedValues.threeDColor = sharedValues.unSelectedColor
                        }
                        
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(sharedValues.spinColor)
                        Text("Spin")
                        
                    }
                    .onTapGesture {
                        SwiftUI.withAnimation(.linear) {
                            sharedValues.mode = "spin"
                            sharedValues.defaultColor = sharedValues.unSelectedColor
                            sharedValues.spinColor = sharedValues.selectedColor
                            sharedValues.threeDColor = sharedValues.unSelectedColor
                        }
                        
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(sharedValues.threeDColor)
                        Text("3D")
                    
                    }
                    .onTapGesture {
                        SwiftUI.withAnimation(.linear) {
                            sharedValues.mode = "3D"
                            sharedValues.defaultColor = sharedValues.unSelectedColor
                            sharedValues.spinColor = sharedValues.unSelectedColor
                            sharedValues.threeDColor = sharedValues.selectedColor
                        }
                        
                    }
                    
                    Text("Mode: \(sharedValues.mode)")
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
    
    @EnvironmentObject var sharedValues: SharedValues
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color.gray)
            VStack {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(sharedValues.hasAnimationOnColor)
                    Text("Slow")
                }
                .onTapGesture {
                    SwiftUI.withAnimation(.linear) {
                        sharedValues.hasAnimation = true
                        sharedValues.hasAnimationOnColor = sharedValues.selectedColor
                        sharedValues.hasAnimationOffColor = sharedValues.unSelectedColor
                    }
                    
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(sharedValues.hasAnimationOffColor)
                    Text("Fast")
                        
                }
                .onTapGesture {
                    SwiftUI.withAnimation(.linear) {
                        sharedValues.hasAnimation = false
                        sharedValues.hasAnimationOnColor = sharedValues.unSelectedColor
                        sharedValues.hasAnimationOffColor = sharedValues.selectedColor
                    }
                    
                }

//                Picker(selection: $selectedAnimationSpeedIndex, label: Text("")) {
//                    ForEach(0 ..< animationSpeeds.count) {
//                        Text(self.animationSpeeds[$0])
//                    }
//                }
//
//                .frame(maxWidth: screenWidth/2)
                
                Text("Animation: \(sharedValues.hasAnimation == true ? "On" : "Off")")
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
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        
        NavigationLink(destination: AboutView()) {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(Color.gray)
                
                Text("About App")
                    .padding()
                    
                    // check system is in dark or light mode then use different color 
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            }
        }
        
        
        
//        .onTapGesture {
//            SwiftUI.withAnimation(.easeIn) {
//                settings.showAbout = true
//            }
//        }
        

        
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
    @EnvironmentObject var sharedValues: SharedValues
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        
            NavigationLink(destination: InAppWebView(url: sharedValues.templesList)) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color.gray)
                    Text("Temple List")
                        .padding()
                        // check system is in dark or light mode then use different color
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                }
            }
            
        
    }
}

