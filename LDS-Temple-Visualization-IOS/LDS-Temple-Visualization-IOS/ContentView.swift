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

var imageSpiralViewModel: ImageSpiral = ImageSpiral()

let coordinates: Array<Array<CGFloat>> = imageSpiralViewModel.getCoordinates(centerX: centerX, centerY: centerY)




struct ContentView: View {
    
    
    var body: some View {
        VStack {
            
            
            TitleView().frame(width: screenWidth, height: screenHeight * 0.1, alignment: Alignment.center).background(Color.blue)
            Spacer(minLength: 0)
            SpiralView().frame(width: screenWidth, height: screenHeight * 0.7, alignment: Alignment.center).background(Color.green)
            Spacer(minLength: 0)
            YearDisplayView().frame(width: screenWidth, height: screenHeight * 0.05, alignment: Alignment.center).background(Color.blue)
            Spacer(minLength: 0)
            SliderView().frame(width: screenWidth, height: screenHeight * 0.1, alignment: Alignment.center).background(Color.green)
            Spacer(minLength: 0)
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

// this is a test function, it returns a spiral, so that we can see how it looks
func SpiralDrawing() -> Path {
    var spiraldrawing: Path = Path()
    spiraldrawing.move(to: CGPoint(x:centerX,y:centerY))
    
    for coordinate in coordinates
    {
        spiraldrawing.addLine(to: CGPoint(x:coordinate[0],y:coordinate[1]))
        
    }
    
    return spiraldrawing
    
}


struct SpiralView: View {
    
    var body: some View {
        
        ZStack {
            ForEach(imageSpiralViewModel.temples) { temple in
                //Text(temple.content)
                Image(temple.content).resizable()
                    .frame(width: 100.0, height: 100.0)
                    .position(x: CGFloat(temple.id)*100, y: CGFloat(temple.id)*100)
                    //.position(x: self.coordinates[(temple.id)][0], y: self.coordinates[(temple.id)][1])

                    .onTapGesture {
                    imageSpiralViewModel.choose(temple: temple)
                        
                }
                
                // this line shows us how the spiral looks like on screen 
                SpiralDrawing().stroke()
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
