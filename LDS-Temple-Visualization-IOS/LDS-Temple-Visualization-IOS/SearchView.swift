//
//  SearchView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by tiantian on 2020/9/5.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var sharedValues: SharedValues
    
    var templeNames: Array<String> = ImageSpiral.templeNamesAndYears[0]
    
    @ObservedObject var imageSpiralViewModel: ImageSpiral
    
    @State private var searchText : String = ""
    
    var body: some View {
        
        VStack {
            Spacer()
            TextField("Type in here to search a Temple", text: $searchText)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal, 10)
            
            List {
                ForEach(self.templeNames.filter {
                    self.searchText.isEmpty ? true : $0.contains(self.searchText)
                }, id: \.self) { name in
                    
                    Button(action: {
                        self.searchText = name
                    }) {
                        Text(name)
                    }

                }
            }
            
            HStack {
                Spacer()
                Button(action: {
                    self.self.sharedValues.showSelector.toggle()
                }) {
                    Text("dismiss")
                }
                
                Spacer()
                
                Button(action: {
                    self.self.sharedValues.showSelector.toggle()
                    self.sharedValues.selectorSet = true
                    self.sharedValues.selectedTemple = self.searchText
                    //let newThetaFromYearPicker: CGFloat = self.templeNames.firstIndex(of: self.searchText)
                    let test: Int = self.templeNames.firstIndex(of: self.searchText) ?? 0
                    let newThetaFromYearPicker: CGFloat = (CGFloat)(test * 30 + 300)
                    self.self.sharedValues.sliderProgress = newThetaFromYearPicker
                    self.self.imageSpiralViewModel.getNewTheta(newTheta: newThetaFromYearPicker)
                    self.self.imageSpiralViewModel.updateOnScreenTemples(newTheta: newThetaFromYearPicker)
                }) {
                    Text("view")
                }
                Spacer()
            }
            .padding()
            
            Spacer()
        
        
        }
        
        
    }
}

