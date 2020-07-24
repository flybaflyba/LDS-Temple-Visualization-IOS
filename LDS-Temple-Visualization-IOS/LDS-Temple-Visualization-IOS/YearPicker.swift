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
    
    @State var selectedDate = Date()
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .background(Color.red)
                .onTapGesture {
                    sharedValues.showYearPicker.toggle()
                    print("sheet gone clicking")
                    sharedValues.selectedYear = "2020"
                }
            
            
            
            DatePicker("Please enter a date", selection: $selectedDate, in: Date()...)
            Text("Your selected date: \(selectedDate)")
            
        }
        
        
    }
}

struct YearPicker_Previews: PreviewProvider {
    static var previews: some View {
        YearPicker()
    }
}
