//
//  SettingValues.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by tiantian on 2020/7/10.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import Foundation
import SwiftUI

class SharedValues: ObservableObject {
    @Published var hasAnimation = false
    @Published var mode = "default"
    //@Published var showAbout = false
    
    @Published var defaultColor = Color.blue
    @Published var spinColor = Color.gray
    @Published var threeDColor = Color.gray
    
    @Published var hasAnimationOnColor = Color.gray
    @Published var hasAnimationOffColor = Color.blue
    
    @Published var selectedColor = Color.blue
    @Published var unSelectedColor = Color.gray
    
    @Published var tappedATemple = false
    @Published var currentTappedTempleName = " "
    
    //@Published var appTitle = "Latter-day Temples"
    
    //@Published var thisUrl = "https://www.churchofjesuschrist.org/temples/list?lang=eng"
    
    @Published var myAnimation: Animation = Animation.linear(duration: 1)
    @Published var myNoAnimation: Animation = Animation.linear(duration: 0.001)
    
    @Published var oneTempleInfo: Array<ImageSpiral.Info> = Array<ImageSpiral.Info>()
    
    @Published var sliderProgress: CGFloat = 3000
    
    //@Published @ObservedObject var imageSpiralViewModel: ImageSpiral = ImageSpiral()
    
    @Published var startYear: String = ""
    @Published var endYear: String = ""
    
    @Published var modeTest: String = "default"
    
    @Published var currentScreenWidth = UIScreen.main.bounds.size.width
    @Published var currentScreenHeight = UIScreen.main.bounds.size.height
    
    //@Published var orientation = UIDevice.current.orientation.isPortrait
    //@Published var orientation = (UIDeviceOrientation.portrait).isPortrait
    @Published var orientation = UIDevice.current.orientation
    
    @Published var orientationChanged = false
    
    @Published var orientationInText = (UIDevice.current.orientation.rawValue == 0 ? "unknown" :
        UIDevice.current.orientation.rawValue == 1 || UIDevice.current.orientation.rawValue == 2 ? "portrait" :
        UIDevice.current.orientation.rawValue == 3 || UIDevice.current.orientation.rawValue == 4 ? "landscape" : "somethingElse")
  
//    @Published var orientationInText = (UIScreen.main.bounds.size.width < UIScreen.main.bounds.size.height ? "portrait" : "landscape")
    
    init() {
        // 检测设备方向
        NotificationCenter.default.addObserver(self, selector: #selector(receivedRotation), name: UIDevice.orientationDidChangeNotification, object: nil)
        print("device rotation when app launch: \(orientationInText)")
    }
    
    
    //通知监听触发的方法
    @objc func receivedRotation(){
        // 屏幕方向
        self.orientation = UIDevice.current.orientation

//        self.orientationInText = (UIDevice.current.orientation.rawValue == 0 ? "unknown" :
//            UIDevice.current.orientation.rawValue == 1 || UIDevice.current.orientation.rawValue == 2 ? "portrait" :
//            UIDevice.current.orientation.rawValue == 3 || UIDevice.current.orientation.rawValue == 4 ? "landscape" : "somethingElse")
        
        if UIDevice.current.orientation.rawValue == 0 {
            self.orientationInText = "unknown"
        } else if UIDevice.current.orientation.rawValue == 1 || UIDevice.current.orientation.rawValue == 2 {
            self.orientationInText = "portrait"
        } else if UIDevice.current.orientation.rawValue == 3 || UIDevice.current.orientation.rawValue == 4 {
            self.orientationInText = "landscape"
        }
        
//        
//        if UIScreen.main.bounds.size.width < UIScreen.main.bounds.size.height {
//            self.orientationInText = "portrait"
//        } else {
//            self.orientationInText = "landscape"
//        }
        
        
        print(self.orientationInText)
        
        if (self.orientationInText == "portrait") {
            print("device rotates to portrait")
            currentScreenWidth = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
            currentScreenHeight = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
            
            centerX = currentScreenWidth / 2
            centerY = currentScreenHeight * 0.8 / 2
            
        } else if (self.orientationInText == "landscape") {
            print("device rotates to landscape")
            currentScreenWidth = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
            currentScreenHeight = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
            
            screenWidth = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 0.8
            
            centerX = currentScreenWidth / 3
            centerY = currentScreenHeight * 0.6
        }
        
        
        
        
        
        print(currentScreenWidth)
        print(currentScreenHeight)
        
        
        
        orientationChanged = true
        
        print("centerX and centerY once orientation changed: \(centerX), \(centerY)")
        
                switch UIDevice.current.orientation {
                case UIDeviceOrientation.unknown:
                    print("方向未知 \(UIDevice.current.orientation.rawValue)") // 0
                    print((UIDevice.current.orientation.rawValue == 0))
                case .portrait: // Device oriented vertically, home button on the bottom
                    print("屏幕直立 \(UIDevice.current.orientation.rawValue)") // 1
                case .portraitUpsideDown: // Device oriented vertically, home button on the top
                    print("屏幕倒立 \(UIDevice.current.orientation.rawValue)") // 2
                case .landscapeLeft: // Device oriented horizontally, home button on the right
                    print("屏幕左旋 \(UIDevice.current.orientation.rawValue)") // 3
                case .landscapeRight: // Device oriented horizontally, home button on the left
                    print("屏幕右旋 \(UIDevice.current.orientation.rawValue)") // 4
                case .faceUp: // Device oriented flat, face up
                    print("屏幕朝上 \(UIDevice.current.orientation.rawValue)") // 5
                case .faceDown: // Device oriented flat, face down
                    print("屏幕朝下 \(UIDevice.current.orientation.rawValue)") // 6
                }
        
    }
    
}
