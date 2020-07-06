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
       
    var coordinatesAndSizes: Array<Array<CGFloat>>
    var onScreenTemples: Array<Temple>
    var onScreenTemplesPositions: Array<CGFloat>
    
    func choose(temple: Temple) {
        print("temple chosen: \(temple)")
    }
    
     // the last parameter of init is a function that takes in an Int and returns TempleContent
     // we will let view model to decide what the content is
     // view model also decide which temples are on screen and their locations
     init(numberOfTemples: Int, coordinatesAndSizesP: Array<Array<CGFloat>>, onScreenTemplesPositionsP: Array<CGFloat>, templeContentFactory: (Int) -> TempleContent) {
         onScreenTemples = Array<Temple>()
         for index in 0..<numberOfTemples {
             let content = templeContentFactory(index)
             onScreenTemples.append(Temple(content: content, id: index))

             //print(temples)
         }
         onScreenTemplesPositions = onScreenTemplesPositionsP
         coordinatesAndSizes = coordinatesAndSizesP.reversed()
         
         //print("on screen temples when app starts length \(onScreenTemples.count)")
         //print("on screen positions when app starts length \(onScreenTemplesPositions.count)")
    }
    
    // this function updateds on screen temples 
    mutating func updateOnScreenTemples(onScreenTemplesPositionsNew: Array<CGFloat>, onScreenTemplesNew: Array<String>) {
        onScreenTemplesPositions = onScreenTemplesPositionsNew
        
        onScreenTemples.removeAll()
        
        for index in 0..<onScreenTemplesNew.count{
            let content = onScreenTemplesNew[index]
            onScreenTemples.append(Temple(content: content as! TempleContent, id: index))
        }
        
        print("NEW on screen temples length \(onScreenTemples.count)")
        print("NEW on screen positions length \(onScreenTemplesPositions.count)")
        
        //print("NEW on screen temples \(onScreenTemples)")
        //print("NEW on screen positions \(onScreenTemplesPositions)")
        
    }
    
    // we make each temple unique, so that we can loop through them with ForEach 
    struct Temple: Identifiable {
        var content: TempleContent
        var id: Int
    }
}
