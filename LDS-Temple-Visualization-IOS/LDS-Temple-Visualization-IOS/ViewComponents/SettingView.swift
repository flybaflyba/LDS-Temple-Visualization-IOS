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

                        SpiralEffectSettingButton()

                        AnimationSettingButton()

                    }

                    HStack {
                        LabelSettingButton()
                        VStack {
                            AboutButton()
                            TempleListButton()
                            
                        }
                        
                        
                    }
                }
//            }
        }
        
    }
        }

struct SpiralEffectSettingButton: View {
    @Environment(\.colorScheme) var colorScheme
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
                    
                    Text("Mode")
                        .padding()
                        .font(.headline)
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

struct AnimationSettingButton: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var sharedValues: SharedValues
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color.gray)
            VStack {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(sharedValues.slowAnimationOnColor)
                    Text("Slow")
                }
                .onTapGesture {
                    SwiftUI.withAnimation(.linear) {
                        sharedValues.hasAnimation = true
                        sharedValues.slowAnimationOnColor = sharedValues.selectedColor
                        sharedValues.fastAnimationColor = sharedValues.unSelectedColor
                    }
                    
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(sharedValues.fastAnimationColor)
                    Text("Fast")
                        
                }
                .onTapGesture {
                    SwiftUI.withAnimation(.linear) {
                        sharedValues.hasAnimation = false
                        sharedValues.slowAnimationOnColor = sharedValues.unSelectedColor
                        sharedValues.fastAnimationColor = sharedValues.selectedColor
                    }
                    
                }

//                Picker(selection: $selectedAnimationSpeedIndex, label: Text("")) {
//                    ForEach(0 ..< animationSpeeds.count) {
//                        Text(self.animationSpeeds[$0])
//                    }
//                }
//
//                .frame(maxWidth: screenWidth/2)
                
                Text("Animation")
                    .padding()
                    .font(.headline)
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


struct LabelSettingButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var sharedValues: SharedValues
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color.gray)
            VStack {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(sharedValues.showLabelOn)
                    Text("On")
                }
                .onTapGesture {
                    SwiftUI.withAnimation(.linear) {
                        sharedValues.showLabel = true
                        sharedValues.showLabelOn = sharedValues.selectedColor
                        sharedValues.showLabelOff = sharedValues.unSelectedColor
                    }
                    
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(sharedValues.showLabelOff)
                    Text("Off")
                        
                }
                .onTapGesture {
                    SwiftUI.withAnimation(.linear) {
                        sharedValues.showLabel = false
                        sharedValues.showLabelOn = sharedValues.unSelectedColor
                        sharedValues.showLabelOff = sharedValues.selectedColor
                    }
                    
                }

//                Picker(selection: $selectedAnimationSpeedIndex, label: Text("")) {
//                    ForEach(0 ..< animationSpeeds.count) {
//                        Text(self.animationSpeeds[$0])
//                    }
//                }
//
//                .frame(maxWidth: screenWidth/2)
                
                Text("Label")
                    .padding()
                    .font(.headline)
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


struct AboutButton: View {
    
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

struct TempleListButton: View {
    @EnvironmentObject var sharedValues: SharedValues
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        
            NavigationLink(destination: InAppWebView(url: sharedValues.templesList)) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color.gray)
                    HStack {
                        Text("Temple List")
                        Image(systemName: "link")
                    }
                    
                        .padding()
                        // check system is in dark or light mode then use different color
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                }
            }
            
        
    }
}

