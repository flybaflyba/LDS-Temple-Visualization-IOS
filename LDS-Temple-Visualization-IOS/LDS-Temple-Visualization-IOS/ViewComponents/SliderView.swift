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
    
    func updateSpiral() {
        
        imageSpiralViewModel.getNewTheta(newTheta: sharedValues.sliderProgress)
        imageSpiralViewModel.updateOnScreenTemples(newTheta: sharedValues.sliderProgress)

        if imageSpiralViewModel.mode != sharedValues.mode {
            imageSpiralViewModel.changeMode(newMode: sharedValues.mode)
        }
        
        
        print("sliderProgress is \(sharedValues.sliderProgress)")
        
        //print(currentScreenWidth)
        
        sharedValues.oneTempleInfo.removeAll()
        
        //sharedValues.tappedATemple = false
    }
    
//    
//    func landscapeSliderView() -> some View {
//        
//        var body: some View {
//            
//            HStack {
//                Text("1836").frame(width: screenWidth / 4, height: screenHeight * 0.05, alignment: Alignment.top)
//                Image(systemName: "arrow.left.square.fill")
//                    .onTapGesture {
//                        sharedValues.sliderProgress -= 100
//                        updateSpiral()
//                    }
//                MySlider(imageSpiralViewModel: imageSpiralViewModel)
//                    .frame(maxWidth: (min(sharedValues.currentScreenWidth, sharedValues.currentScreenHeight)) * 0.8)
//                    //.background(Color.red)
//                Image(systemName: "arrow.right.square.fill")
//                    .onTapGesture {
//                        sharedValues.sliderProgress += 100
//                        updateSpiral()
//                    }
//                Text("2020").frame(width: screenWidth / 4, height: screenHeight * 0.05, alignment: Alignment.top)
//            }
//         
//                    
//       
//        }
//        
//        return body
//    }
    
    var body: some View {
        
        VStack{
            
        
        //if sharedValues.orientationInText == "portrait" || sharedValues.orientationInText == "unknown" {
            
            VStack {
                
                //ProgressBar(progress: Float(sharedValues.sliderProgress / 7000))
             
                ZStack {
                    
//                    Rectangle()
//                        .foregroundColor(Color.red)
//                        .onTapGesture {
//                            print("taped rectancle")
//                        }
//                        .gesture(
//                            DragGesture(minimumDistance: 0)
//                                .onChanged({ (touch) in
//                                    sharedValues.sliderTouched = true
//                                    print("sliderTouched: \(sharedValues.sliderTouched)")
//                                })
//                                .onEnded({ (touch) in
//                                    sharedValues.sliderTouched = false
//                                    print("sliderTouched: \(sharedValues.sliderTouched)")
//                                })
//    
//                        )
                                        
                    
                    HStack {
                        Image(systemName: "arrow.left.square.fill")
                            .onTapGesture {
                                sharedValues.animationInProgress = true
                                SwiftUI.withAnimation(sharedValues.hasAnimation ? sharedValues.myAnimation : sharedValues.myNoAnimation) {
                                    sharedValues.sliderProgress -= 100
                                }
                                updateSpiral()
                            }
                        MySlider(imageSpiralViewModel: imageSpiralViewModel)
                            .frame(maxWidth: (min(sharedValues.currentScreenWidth, sharedValues.currentScreenHeight)) * 0.8)
                            //.background(Color.red)
                        Image(systemName: "arrow.right.square.fill")
                            .onTapGesture {
                                sharedValues.animationInProgress = true
                                SwiftUI.withAnimation(sharedValues.hasAnimation ? sharedValues.myAnimation : sharedValues.myNoAnimation) {
                                    sharedValues.sliderProgress += 100
                                }
                                updateSpiral()
                                
                            }
                    }
                    
                }
                    

                   
//                    .gesture(
//                        DragGesture(minimumDistance: 0)
//                            .onChanged({ (touch) in
//                                sharedValues.sliderTouched = true
//                                print("sliderTouched: \(sharedValues.sliderTouched)")
//                            })
//                            .onEnded({ (touch) in
//                                sharedValues.sliderTouched = false
//                                print("sliderTouched: \(sharedValues.sliderTouched)")
//                            })
//
//                    )
                
//                    .gesture(
//                         DragGesture(minimumDistance: 0)
//                             .onChanged({ (touch) in
//                                 self.touchState = (self.touchState == .none || self.touchState == .ended) ? .began : .moved
//                                 self.touchPoint = touch.location
//                             })
//                             .onEnded({ (touch) in
//                                 self.touchPoint = touch.location
//                                 self.touchState = .ended
//                             })
//                     )
                                   
                            
                
            
         //            Button(action: {
         //                // your action here
         //            }) {
         //                Text("Button title")
         //            }.frame(width: screenWidth / 4 * 2, height: screenHeight * 0.1, alignment: Alignment.center)
                     
                 //Spacer(minLength: 0)
                 // this is slider lable ==================================
                HStack {
                    
                    if sharedValues.currentDevice == .phone && sharedValues.orientationInText == "landscape" {
                        
                    } else {
                        Text("1836")
                            .padding()
                            //.frame(width: screenWidth / 4, height: screenHeight * 0.05, alignment: Alignment.top)
                        
                    }
                    
                    //Text("").frame(width: screenWidth / 4 * 2, height: screenHeight * 0.05, alignment: Alignment.center)
                    YearDisplayView(startYear: ImageSpiral.startYear, endYear: ImageSpiral.endYear)
                        //.background(Color.red)
                        .padding()
                     
                    if sharedValues.currentDevice == .phone && sharedValues.orientationInText == "landscape" {
                        
                    } else {
                        Text("2020")
                            .padding()
                            //.frame(width: screenWidth / 4, height: screenHeight * 0.05, alignment: Alignment.top)
                    }
                    
                }
                 //.frame(width: screenWidth, height: screenHeight * 0.1, alignment: Alignment.center).background(Color.blue)
            }
            
//        } else if sharedValues.orientationInText == "landscape" || sharedValues.orientationInText == "unknown"  {
//
//            landscapeSliderView()
//        }
            
        }
        
}

//struct SliderView_Previews: PreviewProvider {
//    static var previews: some View {
//        SliderView()
//    }
//}

}


struct MySlider: View {
    
    @EnvironmentObject var sharedValues: SharedValues
    
    @ObservedObject var imageSpiralViewModel: ImageSpiral
    
    var body: some View {
        // we use Binding, so that when ever slider progress changes, we can do something
        Slider(value: Binding(
                get: {
                    //sharedValues.sliderTouched = false
                    
                    return Double(sharedValues.sliderProgress)
                },
                set: {(newValue) in
                    
                    // only run the following code when sliderporgess changed
                    // if not checking newvalue and sliderprogress,
                    // newvalue might be the same as sliderprogress, these lines may excute too
                    // this might cause problems with checking if animation stops
                    
                    if CGFloat(newValue) != sharedValues.sliderProgress {
                        
//                        while newValue != self.sliderProgress {
//                           if newValue > self.sliderProgress {
//                               self.sliderProgress += 1
//                           } else {
//                               self.sliderProgress -= 1
//                           }
//                       }
                                            
                        //sharedValues.sliderTouched = true
                        
                        //sharedValues.sliderProgress = CGFloat(newValue)
                        imageSpiralViewModel.getNewTheta(newTheta: sharedValues.sliderProgress)
                        imageSpiralViewModel.updateOnScreenTemples(newTheta: sharedValues.sliderProgress)
                                    
                      
                        //if sharedValues.hasAnimation {
                            // to check if animation stops, we must use withAnimation
                            if sharedValues.animationInProgress != true {
                                sharedValues.animationInProgress = true
                                SwiftUI.withAnimation(sharedValues.hasAnimation ? sharedValues.myAnimation : sharedValues.myNoAnimation) {
                                    sharedValues.sliderProgress = CGFloat(newValue)
                                }
                            }
                        //}
                        
                        //SwiftUI.withAnimation(sharedValues.hasAnimation ? sharedValues.myAnimation : sharedValues.myNoAnimation) {
                                                
                            sharedValues.sliderProgress = CGFloat(newValue)
                        
                        //imageSpiralViewModel.getNewTheta(newTheta: sharedValues.sliderProgress)
                        //imageSpiralViewModel.updateOnScreenTemples(newTheta: sharedValues.sliderProgress)
                        //}
                                            
                        
                        if imageSpiralViewModel.mode != sharedValues.mode {
                            imageSpiralViewModel.changeMode(newMode: sharedValues.mode)
                        }
                        
                        
                        print("sliderProgress is \(sharedValues.sliderProgress)")
                        print("sharedValues.animationInProgress is \(sharedValues.animationInProgress) ")
                        
                        //print(currentScreenWidth)
                        
                        sharedValues.oneTempleInfo.removeAll()
                        
                        //sharedValues.tappedATemple = false
                        
                        sharedValues.singleTempleShow = false
    
                    }
                }),
           
           // when animation, less coordinates
           //in: 0...226, step: 1)
           // when no animation, more coordinates
               in: 11...7500, step: 1)
            //.background(Color.red)


            
        
    //Text("Slider progress is \(sliderProgress)")
    
        }
    
    
    
    
}
