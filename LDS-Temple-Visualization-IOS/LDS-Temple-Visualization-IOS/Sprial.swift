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
    
    @EnvironmentObject var sharedValues: SharedValues
    
    //var temples: Array<Temple>
       
    //var coordinatesAndSizes: Array<Array<CGFloat>>
    
    var onScreenTemples: Array<Temple>
    
    var mode: String = "default" 
    // var onScreenTemplesPositions: Array<CGFloat>
    
    //var startYear: String
    //var endYear: String
    
    func choose(temple: Temple) {
        //print("temple chosen: \(temple)")
        print("you clicked on \(temple.name)")
        //print("it's year is \(temple.year)")
        print("this temple id is \(temple.id)")
        print("this temple id is \(temple.link)")
    }
    
    var oldX: CGFloat = 0
    var oldY: CGFloat = 0
    var oldSize: CGFloat = 0
    
    mutating func changeATemple(id: Int) {
        
        print("change a temple starts here")
        print("id is \(id)")
        
        if onScreenTemples[id].tapped == false {
            
            
            oldX = onScreenTemples[id].x
            oldY = onScreenTemples[id].y
            oldSize = onScreenTemples[id].size
            
            for index in 0..<onScreenTemples.count {
                onScreenTemples[index].y = -onScreenTemples[index].y
                onScreenTemples[index].size = -onScreenTemples[index].size
            }
            
            onScreenTemples[id].x = centerX
            onScreenTemples[id].y = centerY
            onScreenTemples[id].size = screenWidth * 0.9
            onScreenTemples[id].content = Image(onScreenTemples[id].fileName + "_large") as! TempleContent
            
            onScreenTemples[id].tapped = true
            
        } else {
            
            for index in 0..<onScreenTemples.count {
                onScreenTemples[index].y = -onScreenTemples[index].y
                onScreenTemples[index].size = -onScreenTemples[index].size
                
                //print("hi")
                
            }
            
            onScreenTemples[id].x = oldX
            onScreenTemples[id].y = oldY
            onScreenTemples[id].size = oldSize
            
            //print("hi")
            
            onScreenTemples[id].content = Image(onScreenTemples[id].fileName + "") as! TempleContent
    
            onScreenTemples[id].tapped = false
        }
        
        
        
    }
    
    
    
    mutating func changeMode(newMode: String) {
        mode = newMode
    }
    
     // the last parameter of init is a function that takes in an Int and returns TempleContent
     // we will let view model to decide what the content is
     // view model also decide which temples are on screen and their locations
//     init(numberOfTemples: Int, coordinatesAndSizesP: Array<Array<CGFloat>>, onScreenTemplesPositionsP: Array<CGFloat>, templeContentFactory: (Int) -> TempleContent) {
//         onScreenTemples = Array<Temple>()
        init(onScreenTemplesString: Array<Array<String>>, coordinatesAndSizesP: Array<Array<CGFloat>>, onScreenTemplesPositionsP: Array<CGFloat>) {
            
        onScreenTemples = Array<Temple>()

//            print(onScreenTemplesString.count)
//            print(coordinatesAndSizesP.count)
//            print(onScreenTemplesPositionsP.count)
            
//            for i in coordinatesAndSizesP {
//                print(i)
//            }
            
            for index in 0..<onScreenTemplesString[1].count {
                let content = Image(onScreenTemplesString[0][index])
                let id = index
                
                let x: CGFloat
                let y: CGFloat
                let size: CGFloat
                
                let name: String = onScreenTemplesString[1][index]
                let year: String = onScreenTemplesString[2][index]
                let link: String = onScreenTemplesString[3][index]
                
                let fileName: String = onScreenTemplesString[0][index]
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
                
                
                onScreenTemples.append(Temple(content: content as! TempleContent , id: id, x: x, y: y, size: size, name: name, year: year, fileName: fileName, link: link))

                
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
    mutating func updateOnScreenTemples(onScreenTemplesString: Array<Array<String>>, coordinatesAndSizesP: Array<Array<CGFloat>>, onScreenTemplesPositionsP: Array<CGFloat>) {
        
        //onScreenTemplesPositions = onScreenTemplesPositionsNew
        
        //onScreenTemples.removeAll()
        
//        for index in 0..<onScreenTemplesNew.count{
//            let content = onScreenTemplesNew[index]
//            onScreenTemples.append(Temple(content: content, id: index, x: 20, y: 20, size: 20))
//        }
        
        print("updating ==========================================")
        
        for index in 0..<onScreenTemples.count {
            onScreenTemples[index].content = Image(onScreenTemplesString[0][index]) as! TempleContent
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
            onScreenTemples[index].name = onScreenTemplesString[1][index]
            onScreenTemples[index].year = onScreenTemplesString[2][index]
            onScreenTemples[index].link = onScreenTemplesString[3][index]
            onScreenTemples[index].fileName = onScreenTemplesString[0][index]
            
            
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
        var name: String
        var year: String
        var fileName: String
        var tapped: Bool = false
        var link: String
    }
}
