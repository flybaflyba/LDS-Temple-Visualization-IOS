//
//  ContentView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by Litian Zhang on 6/29/20.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI


// use screen Height to set how much space each view should take on the screen
let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height
let centerX = screenWidth / 2
let centerY = screenHeight  * 0.7 / 2

var spiral: Path = Path()




struct ContentView: View {
    
    
    var body: some View {
        VStack {
            
            TitleView().frame(width: screenWidth, height: screenHeight * 0.1, alignment: Alignment.center).background(Color.blue)
            
            SpiralView(imageSpiralViewModel: ImageSpiral()).frame(width: screenWidth, height: screenHeight * 0.7, alignment: Alignment.center).background(Color.green)
            
            YearDisplayView().frame(width: screenWidth, height: screenHeight * 0.05, alignment: Alignment.center).background(Color.blue)
            SliderView().frame(width: screenWidth, height: screenHeight * 0.1, alignment: Alignment.center).background(Color.green)
            SliderLabelView().frame(width: screenWidth, height: screenHeight * 0.05, alignment: Alignment.center).background(Color.blue)
            
            
        }
        
    }
}

// the folowing are different views on the initial screen
struct TitleView: View {
    var body: some View {
        Text("LDS Temples")
    }
}

struct Temple {
    var temple: Spiral<String>.Temple
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
            Text(temple.content)
        }
        
    }
}


func getCoordinates() -> Array<Array<CGFloat>>{
    var t: CGFloat = 17.5
    var buildingCoordinates: Array<Array<CGFloat>> = Array<Array<CGFloat>>()
    var x: CGFloat
    var y: CGFloat
    let initialR: CGFloat = screenWidth / 10
    
    
    spiral.move(to: CGPoint(x:centerX,y:centerY))
    
    //spiral.addLine(to: CGPoint(x:100,y:100))
    
    // spiral function：
    // x = p * cosA, y = p * sinA, where p = N * e^(B * cotC)
    // When C = PI/2, graph is a circle, when C = 0, graph is a straight line
    
    
    while t > -18
    {
        
        x = centerX + initialR * exp(t * CGFloat(1) / tan(CGFloat(47)) * CGFloat.pi / CGFloat(100)) * cos(t)
        y = centerY + initialR * exp(t * CGFloat(1) / tan(CGFloat(47)) * CGFloat.pi / CGFloat(100)) * sin(t)
        
    
        var oneSpiralCoordinate: Array<CGFloat> = Array<CGFloat>()
        oneSpiralCoordinate.append(x)
        oneSpiralCoordinate.append(y)
        buildingCoordinates.append(oneSpiralCoordinate)
        
        //print("oneSpiralCoordinate is \(oneSpiralCoordinate)")
        
        oneSpiralCoordinate.removeAll()
        
        t -= 0.02
        
        spiral.addLine(to: CGPoint(x:x,y:y))
        
        print("X is \(x)")
        print("Y is \(y)")
        
    }
    
    print("centerX is \(centerX)")
    print("centerY is \(centerY)")
    print("screenWidth is \(screenWidth)")
    print("screenHeight is \(screenHeight)")
    
    //print("buildingCoordinates is \(buildingCoordinates)")
    print("buildingCoordinates length is \(buildingCoordinates.count)")
    
    return buildingCoordinates.reversed()
    
}

struct SpiralView: View {
    var imageSpiralViewModel: ImageSpiral
    
    
   
    var coordinates: Array<Array<CGFloat>> = getCoordinates()
    
    var body: some View {
        
        ZStack {
            ForEach(imageSpiralViewModel.temples) { temple in
                //Text(temple.content)
                Image(temple.content).resizable()
                    .frame(width: 100.0, height: 100.0).position(x: CGFloat(temple.id)*100, y: CGFloat(temple.id)*100)

                    .onTapGesture {
                    self.imageSpiralViewModel.choose(temple: temple)
                        
                }
                spiral.stroke()
            }
            
        }
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
