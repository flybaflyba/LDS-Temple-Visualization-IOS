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

//func spiralDrawing() -> Path {
//    var spiraldrawing: Path = Path()
//    spiraldrawing.move(to: CGPoint(x:centerX,y:centerY))
//
//    for coordinate in coordinates
//    {
//        spiraldrawing.addLine(to: CGPoint(x:coordinate[0],y:coordinate[1]))
//
//    }
//
//
////    let names = ImageSpiral.linesFromResourceForced(fileName: "templeNames")
////
////    for name in names {
////        print(name)
////    }
//
//
//    return spiraldrawing
//
//}


struct SpiralView: View {

    var imageSpiralViewModel: ImageSpiral = ImageSpiral()
    
    var body: some View {
        
        ZStack {
            
            //ForEach(imageSpiralViewModel.temples) { temple in
            ForEach(0 ..< imageSpiralViewModel.onScreenTemples.count) { templeIndex in
               //Text(temple.content)
            
               Image(self.imageSpiralViewModel.onScreenTemples[templeIndex].content).resizable()
                   .frame(width: 20.0, height: 20.0)
                    //.position(x: CGFloat(temple.id)*100, y: CGFloat(temple.id)*100)
                    .position(x: self.imageSpiralViewModel.coordinates[Int(self.imageSpiralViewModel.onScreenTemplesPositions[templeIndex])][0], y: self.imageSpiralViewModel.coordinates[Int(self.imageSpiralViewModel.onScreenTemplesPositions[templeIndex])][1])

//                    .onTapGesture {
//                        self.imageSpiralViewModel.choose(temple: self.imageSpiralViewModel.onScreenTemples[templeIndex])
//                        print(templeIndex)
//                        print(Int(self.imageSpiralViewModel.onScreenTemplesPositions[templeIndex]))
//                        print(self.imageSpiralViewModel.coordinates[Int(self.imageSpiralViewModel.onScreenTemplesPositions[templeIndex])][0])
//                        print(self.imageSpiralViewModel.coordinates[Int(self.imageSpiralViewModel.onScreenTemplesPositions[templeIndex])][1])
//
//
//                }
                
                // this line shows us how the spiral looks like on screen
                //spiralDrawing().stroke()
                
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
    
    @State var sliderProgress: CGFloat = 0
    var body: some View {
        VStack {
            Slider(value: $sliderProgress, in: 0...7000).onTapGesture {
                self.passingSliderProgress()
            }
            Text("Slider progress is \(sliderProgress)")

        }
       
    }
    
    func passingSliderProgress() {
        print(sliderProgress)
        
//        onScreenTemples = imageSpiralViewModel.getOnScreenTemples(theta: 7000, coordinatesLength: CGFloat(coordinates.count))
//
//        onScreenTemplesPositions = imageSpiralViewModel.getOnScreenTemplesPositions(theta: 7000, coordinatesLength: CGFloat(coordinates.count))
//
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
