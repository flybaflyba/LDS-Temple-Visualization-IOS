//
//  Sprial.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by Litian Zhang on 6/29/20.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import Foundation
import SwiftUI

//this is a Model file

//TempleContent is a don;t care type, here we will use image for it 
struct Spiral<TempleContent> {
    
    //var temples: Array<Temple>
       
    //var coordinatesAndSizes: Array<Array<CGFloat>>
    
    var onScreenTemples: Array<Temple>
    
    var mode: String = "default" 
   // var onScreenTemplesPositions: Array<CGFloat>
    
    func choose(temple: Temple) {
        print("temple chosen: \(temple)")
    }
    
    mutating func changeMode(newMode: String) {
        mode = newMode
    }
    
     // the last parameter of init is a function that takes in an Int and returns TempleContent
     // we will let view model to decide what the content is
     // view model also decide which temples are on screen and their locations
//     init(numberOfTemples: Int, coordinatesAndSizesP: Array<Array<CGFloat>>, onScreenTemplesPositionsP: Array<CGFloat>, templeContentFactory: (Int) -> TempleContent) {
//         onScreenTemples = Array<Temple>()
        init(onScreenTemplesString: Array<String>, coordinatesAndSizesP: Array<Array<CGFloat>>, onScreenTemplesPositionsP: Array<CGFloat>) {
            
        onScreenTemples = Array<Temple>()

//            print(onScreenTemplesString.count)
//            print(coordinatesAndSizesP.count)
//            print(onScreenTemplesPositionsP.count)
            
//            for i in coordinatesAndSizesP {
//                print(i)
//            }
            
            for index in 0..<onScreenTemplesString.count {
                let content = Image(onScreenTemplesString[index])
                let id = index
                
                let x: CGFloat
                let y: CGFloat
                let size: CGFloat
                
//                // this is with when we temples that is outside of coordinates and sizes list,
//                // their x y and size can noto be found, we willgive the value here
//                if Int(onScreenTemplesPositionsP[index]) > coordinatesAndSizesP.count - 1 {
//                    x = centerX
//                    y = centerY
//                    size = 10
//                } else {
                    x = coordinatesAndSizesP[Int(onScreenTemplesPositionsP[index])][0]
                    y = coordinatesAndSizesP[Int(onScreenTemplesPositionsP[index])][1]
                    size = coordinatesAndSizesP[Int(onScreenTemplesPositionsP[index])][2]
//                }
                
                
                onScreenTemples.append(Temple(content: content as! TempleContent , id: id, x: x, y: y, size: size))

                
            }
            
//            for i in onScreenTemples {
//                print(i)
//            }
            
//         onScreenTemplesPositions = onScreenTemplesPositionsP
//         coordinatesAndSizes = coordinatesAndSizesP.reversed()
         
         //print("on screen temples when app starts length \(onScreenTemples.count)")
         //print("on screen positions when app starts length \(onScreenTemplesPositions.count)")
    }
    
    // this function updateds on screen temples 
    mutating func updateOnScreenTemples(onScreenTemplesString: Array<String>, coordinatesAndSizesP: Array<Array<CGFloat>>, onScreenTemplesPositionsP: Array<CGFloat>) {
        
        //onScreenTemplesPositions = onScreenTemplesPositionsNew
        
        //onScreenTemples.removeAll()
        
//        for index in 0..<onScreenTemplesNew.count{
//            let content = onScreenTemplesNew[index]
//            onScreenTemples.append(Temple(content: content, id: index, x: 20, y: 20, size: 20))
//        }
        
        print("updating ==========================================")
        
        for index in 0..<onScreenTemples.count {
            onScreenTemples[index].content = Image(onScreenTemplesString[index]) as! TempleContent
            onScreenTemples[index].id = index
            
//            if Int(onScreenTemplesPositionsP[index]) > coordinatesAndSizesP.count - 1 {
//                onScreenTemples[index].x = centerX
//                onScreenTemples[index].y = centerY
//                onScreenTemples[index].size = 10
//            } else {
                onScreenTemples[index].x = coordinatesAndSizesP[Int(onScreenTemplesPositionsP[index])][0]
                onScreenTemples[index].y = coordinatesAndSizesP[Int(onScreenTemplesPositionsP[index])][1]
                onScreenTemples[index].size = coordinatesAndSizesP[Int(onScreenTemplesPositionsP[index])][2]
//            }
            
            
            
            //onScreenTemples.append(Temple(content: content as! TempleContent, id: id, x: x, y: y, size: size))
        }
            
        
        
        print("NEW on screen temples length \(onScreenTemples.count)")
        //print("NEW on screen positions length \(onScreenTemplesPositions.count)")
        
        //print("NEW on screen temples \(onScreenTemples)")
        //print("NEW on screen positions \(onScreenTemplesPositions)")
        
    }
    
    // we make each temple unique, so that we can loop through them with ForEach 
    struct Temple: Identifiable {
        var content: TempleContent
        var id: Int
        var x: CGFloat
        var y: CGFloat
        var size: CGFloat
    }
}
