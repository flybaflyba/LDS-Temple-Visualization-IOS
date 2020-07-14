//
//  YearDisplayView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by tiantian on 2020/7/13.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI

struct YearDisplayView: View {
    
    //@ObservedObject var imageSpiralViewModel: ImageSpiral
    
    var startYear: String
    var endYear: String
    
    @EnvironmentObject var sharedValues: SharedValues
    
    var body: some View {
        
        // here is the logic to display on screen temples years
        // if the year is ere, that means we are reaching to end of the spiral, the temples are not dedicated yet
        // so we keep 2020 in the end, and later just announced temples
        
        VStack {
            if sharedValues.orientationInText == "portrait" || sharedValues.orientationInText == "unknown" {
                Text(startYear == "ere" ? "Announced Temples" :
                        endYear == "1836" ? "Move Slider to View Temples" :
                        endYear != "ere" ? "Temple Years: \(startYear) --- \(endYear)" :
                        "Temple Years: \(startYear) --- 2020")
            } else if sharedValues.orientationInText == "landscape" || sharedValues.orientationInText == "unknown"  {
                if startYear == "ere" {
                    Text("Announced Temples")
                } else if endYear == "1836" {
                    Text("Move Slider to")
                    Text("View Temples")
                } else if endYear != "ere" {
                    Text("Temple Years:")
                    Text("\(startYear) --- \(endYear)")
                } else {
                    Text("Temple Years:")
                    Text("\(startYear) --- 2020")
                }
            }
        }
        
        
        
    }
}

//struct YearDisplayView_Previews: PreviewProvider {
//    static var previews: some View {
//        YearDisplayView()
//    }
//}
