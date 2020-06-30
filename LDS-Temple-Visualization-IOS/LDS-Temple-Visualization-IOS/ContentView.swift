//
//  ContentView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by Litian Zhang on 6/29/20.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI

//use screen Height to set how much space each view should take on the screen
let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

struct ContentView: View {
    var body: some View {
        VStack {
            TitleView().frame(width: screenWidth, height: screenHeight * 0.1, alignment: Alignment.center).background(Color.blue)
            SpiralView().frame(width: screenWidth, height: screenHeight * 0.7, alignment: Alignment.center).background(Color.green)
            YearDisplayView().frame(width: screenWidth, height: screenHeight * 0.05, alignment: Alignment.center).background(Color.blue)
            SliderView().frame(width: screenWidth, height: screenHeight * 0.1, alignment: Alignment.center).background(Color.green)
            SliderLabelView().frame(width: screenWidth, height: screenHeight * 0.05, alignment: Alignment.center).background(Color.blue)
        }
        
    }
}




struct TitleView: View {
    var body: some View {
        Text("LDS Temples")
    }
}

struct SpiralView: View {
    var body: some View {
        Text("Spiral")
    }
}

struct YearDisplayView: View {
    var body: some View {
        Text("Year display")
    }
}

struct SliderView: View {
    var body: some View {
        Text("Slider")
    }
}

struct SliderLabelView: View {
    var body: some View {
        Text("Slider lablel")
    }
}









struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
