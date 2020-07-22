//
//  YearDisplayView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by tiantian on 2020/7/13.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI

struct YearDisplayView: View {
    
    var startYear: String
    var endYear: String
    
    @EnvironmentObject var sharedValues: SharedValues
    
    var body: some View {
        
        // here is the logic to display on screen temples years
        // if the year is ere, that means we are reaching to end of the spiral, the temples are not dedicated yet
        // so we keep 2020 in the end, and later just announced temples
        
        VStack {
            Text(startYear == "ere" ? "Future Temples" :
                    endYear == "1836" ? "Welcome" :
                    endYear != "ere" ? "\(startYear) --- \(endYear)" :
                    "\(startYear) --- 2020")
        }
    }
}

//struct YearDisplayView_Previews: PreviewProvider {
//    static var previews: some View {
//        YearDisplayView()
//    }
//}
