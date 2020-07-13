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
}
