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
    
    var templeYears: Array<String> = ImageSpiral.templeYears
    
    //@State var selectedYearIndex = 0
    
    var body: some View {
        
        return GeometryReader { geometry in
            
            
            VStack {
                
                Spacer()
                
                Image(systemName: "arrow.down")
                    .font(.system(size: geometry.size.width * 0.1))
                    .onTapGesture {
                        sharedValues.showYearPicker.toggle()
                        print("sheet gone clicking")
                    }
                Text("swip down to view")
                if sharedValues.selectedYearIndex != -1 {
                    Text(sharedValues.selectedYearIndex == templeYears.count - 1 ? "Announced Temples" :
                        sharedValues.selectedYearIndex == templeYears.count - 2 ? "Temples under construction" : "Temples dedicated in \(ImageSpiral.templeYears[sharedValues.selectedYearIndex])")
                } else {
                    Text("Temples dedicated in 1836")
                }
                
                
                    //.background(Color.red)
                //Text("\(allYearsArray[sharedValues.selectedYearIndex])")
                //+ Text("")
                
                //Spacer()
                
                Picker(selection: $sharedValues.selectedYearIndex, label: Text("")) {
                            ForEach(0 ..< templeYears.count) {
                               Text(self.templeYears[$0])
                            }
                         }
                .labelsHidden()
                //.frame(width: geometry.size.width * 1, height: geometry.size.height * 0.5, alignment: Alignment.center)
                //.background(Color.red)
                
                Spacer()
                
               
                
                
            }
            //.background(Color.gray)
        
            
        }
        
        
    }
}

//struct YearPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        YearPicker()
//    }
//}
