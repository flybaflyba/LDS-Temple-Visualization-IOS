//
//  SliderView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by tiantian on 2020/7/13.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI

struct SliderView: View {
    
//    @State var sliderProgress: CGFloat = 3000
    
    @EnvironmentObject var sharedValues: SharedValues
    
    @ObservedObject var imageSpiralViewModel: ImageSpiral
    
    var body: some View {
        
        VStack {
            
        
        VStack {
            
            // we use Binding, so that when ever slider progress changes, we can do something
            Slider(value: Binding(
                    get: {
                        sharedValues.sliderProgress
                    },
                    set: {(newValue) in
    //                     while newValue != self.sliderProgress {
    //                        if newValue > self.sliderProgress {
    //                            self.sliderProgress += 1
    //                        } else {
    //                            self.sliderProgress -= 1
    //                        }
    //                    }

                        sharedValues.sliderProgress = newValue
                        imageSpiralViewModel.getNewTheta(newTheta: sharedValues.sliderProgress)
                        imageSpiralViewModel.updateOnScreenTemples(newTheta: sharedValues.sliderProgress)
                
                        if imageSpiralViewModel.mode != sharedValues.mode {
                            imageSpiralViewModel.changeMode(newMode: sharedValues.mode)
                        }
                        
                        
                        print("sliderProgress is \(sharedValues.sliderProgress)")
                        
                        sharedValues.oneTempleInfo.removeAll()
                        
                        sharedValues.tappedATemple = false
                
                    }),
               
               // when animation, less coordinates
               //in: 0...226, step: 1)
               // when no animation, more coordinates
                   in: 11...7000, step: 1)
            
        //Text("Slider progress is \(sliderProgress)")
        
            }.frame(width: screenWidth, height: screenHeight * 0.1, alignment: Alignment.center)
        //.background(Color.green)
        // we need this background color for testing purposes
        
        
        
     //            Button(action: {
     //                // your action here
     //            }) {
     //                Text("Button title")
     //            }.frame(width: screenWidth / 4 * 2, height: screenHeight * 0.1, alignment: Alignment.center)
                 
             //Spacer(minLength: 0)
             // this is slider lable ==================================
            HStack {
                Text("1836").frame(width: screenWidth / 4, height: screenHeight * 0.05, alignment: Alignment.top)
                
                Text("").frame(width: screenWidth / 4 * 2, height: screenHeight * 0.05, alignment: Alignment.center)
                 
                Text("2020").frame(width: screenWidth / 4, height: screenHeight * 0.05, alignment: Alignment.top)
            }
             //.frame(width: screenWidth, height: screenHeight * 0.1, alignment: Alignment.center).background(Color.blue)
        }
        }
        
    }


//struct SliderView_Previews: PreviewProvider {
//    static var previews: some View {
//        SliderView()
//    }
//}
