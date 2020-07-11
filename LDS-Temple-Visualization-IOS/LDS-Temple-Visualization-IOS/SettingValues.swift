//
//  SettingValues.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by tiantian on 2020/7/10.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import Foundation

class SettingValues: ObservableObject {
    @Published var hasAnimation = false
    @Published var mode = "default"
    @Published var showAbout = false
}
