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
    
  
    func allYears() -> Array<String> {
        var allYearArray: Array<String> = Array<String>()
        
        for i in 1836..<2021 {
            allYearArray.append(String(i))
        }
        
        return allYearArray
    }
    
    var allYearsArray: Array<String> {
        return allYears()
    }
    
    //@State var selectedYearIndex = 0
    
    var body: some View {
        
        return GeometryReader { geometry in
            
            
            VStack {
                
                Spacer()
                
                Text("show temples dedicated in this year")
                    //.background(Color.red)
                //Text("\(allYearsArray[sharedValues.selectedYearIndex])")
                Text("\(sharedValues.selectedYearIndex + 1836)")
                Spacer()
                
                Picker(selection: $sharedValues.selectedYearIndex, label: Text("")) {
                            ForEach(0 ..< allYearsArray.count) {
                               Text(self.allYearsArray[$0])
                            }
                         }
                .labelsHidden()
                //.frame(width: geometry.size.width * 1, height: geometry.size.height * 0.5, alignment: Alignment.center)
                //.background(Color.red)
                
                Spacer()
                
                Text("swip down to view")
                Image(systemName: "arrow.down")
                    .font(.system(size: geometry.size.width * 0.1))
                    .onTapGesture {
                        sharedValues.showYearPicker.toggle()
                        print("sheet gone clicking")
                    }
                
            }
            //.background(Color.gray)
        
            
        }
        
        
    }
}

struct YearPicker_Previews: PreviewProvider {
    static var previews: some View {
        YearPicker()
    }
}
