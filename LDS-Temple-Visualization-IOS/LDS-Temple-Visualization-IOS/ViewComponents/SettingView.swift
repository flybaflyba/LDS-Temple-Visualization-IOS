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
        return HStack {
                VStack {
                    HStack {
                        SpiralEffectSettingButton()
                        AnimationSettingButton()
                    }
                    HStack {
                        LabelSettingButton()
                        VStack {
                            TempleListButton()
                            AboutButton()
                        }
                    }
                }
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
            }
        }
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
                        .foregroundColor(sharedValues.slowAnimationColor)
                    Text("Slow")
                }
                .onTapGesture {
                    SwiftUI.withAnimation(.linear) {
                        sharedValues.animationOption = "slow"
                        sharedValues.slowAnimationColor = sharedValues.selectedColor
                        sharedValues.fastAnimationColor = sharedValues.unSelectedColor
                        sharedValues.offAnimationColor = sharedValues.unSelectedColor
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(sharedValues.fastAnimationColor)
                    Text("Fast")
                        
                }
                .onTapGesture {
                    SwiftUI.withAnimation(.linear) {
                        sharedValues.animationOption = "fast"
                        sharedValues.slowAnimationColor = sharedValues.unSelectedColor
                        sharedValues.fastAnimationColor = sharedValues.selectedColor
                        sharedValues.offAnimationColor = sharedValues.unSelectedColor
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(sharedValues.offAnimationColor)
                    Text("Off")
                }
                .onTapGesture {
                    SwiftUI.withAnimation(.linear) {
                        sharedValues.animationOption = "off"
                        sharedValues.slowAnimationColor = sharedValues.unSelectedColor
                        sharedValues.fastAnimationColor = sharedValues.unSelectedColor
                        sharedValues.offAnimationColor = sharedValues.selectedColor
                    }
                }
                
                Text("Animation")
                    .padding()
                    .font(.headline)
            }
            //.background(Color.gray)
        }
    }
}

struct LabelBackGroundSettingButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var sharedValues: SharedValues
    
    var body: some View {
    
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color.gray)
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(sharedValues.showLabelBackgroundYes)
                    VStack {
                        Text("Yes")
                    }
                    
                }
                .onTapGesture {
                    SwiftUI.withAnimation(.linear) {
                        sharedValues.showLabelBackgroundYes = sharedValues.selectedColor
                        sharedValues.showLabelBackgroundNo = sharedValues.unSelectedColor
                        sharedValues.showLabelBackgroundOption.toggle()
                        sharedValues.showLabelBackground = true
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(sharedValues.showLabelBackgroundNo)
                    Text("No")
                        
                }
                .onTapGesture {
                    SwiftUI.withAnimation(.linear) {
                        sharedValues.showLabelBackgroundYes = sharedValues.unSelectedColor
                        sharedValues.showLabelBackgroundNo = sharedValues.selectedColor
                        sharedValues.showLabelBackgroundOption.toggle()
                        sharedValues.showLabelBackground = false
                    }
                }
                
                Text("Label Background")
                    .padding()
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }
            //.background(Color.gray)
        }
        
    }
    
}

struct LabelSettingOnOffButton: View {
    
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
                    VStack {
                        Text("On")
                        Text(sharedValues.showLabelBackground ? "with background" : "without background")
                            .font(.system(size: 10))
                    }
                    
                }
                .onTapGesture {
                    SwiftUI.withAnimation(.linear) {
                        sharedValues.showLabel = true
                        sharedValues.showLabelOn = sharedValues.selectedColor
                        sharedValues.showLabelOff = sharedValues.unSelectedColor
                        sharedValues.showLabelBackgroundOption.toggle()
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
                
                Text("Label")
                    .padding()
                    .font(.headline)
            }
            //.background(Color.gray)
        }
    }
}


struct LabelSettingButton: View {
        
    
    @EnvironmentObject var sharedValues: SharedValues
    
    var body: some View {
        HStack {
            if sharedValues.showLabelBackgroundOption {
                LabelBackGroundSettingButton()
            } else {
                LabelSettingOnOffButton()
            }
        }
        
        
        
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

