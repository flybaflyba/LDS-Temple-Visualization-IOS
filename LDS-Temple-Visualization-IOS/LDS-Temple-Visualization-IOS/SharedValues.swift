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
    
    //@Published var orientation = UIDevice.current.orientation.isPortrait
    //@Published var orientation = (UIDeviceOrientation.portrait).isPortrait
    @Published var orientation = UIDevice.current.orientation
    //@Published var orientationPortrait: (UIDevice.current.orientation.rawValue == 0 ? true : false)
    
    init() {
        // 检测设备方向
        NotificationCenter.default.addObserver(self, selector: #selector(receivedRotation), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    
    //通知监听触发的方法
    @objc func receivedRotation(){
        // 屏幕方向
        self.orientation = UIDevice.current.orientation

        //print(UIDevice.current.orientation)
        
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
