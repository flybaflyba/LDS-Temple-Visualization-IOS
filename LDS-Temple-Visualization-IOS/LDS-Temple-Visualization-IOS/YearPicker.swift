//
//  YearPicker.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by tiantian on 2020/7/24.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI

struct YearPicker: View {
    
    @EnvironmentObject var sharedValues: SharedValues
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onTapGesture {
                sharedValues.showYearPicker.toggle()
            }
    }
}

struct YearPicker_Previews: PreviewProvider {
    static var previews: some View {
        YearPicker()
    }
}
