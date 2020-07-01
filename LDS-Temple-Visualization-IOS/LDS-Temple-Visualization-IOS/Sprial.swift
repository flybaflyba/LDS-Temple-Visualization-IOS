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
    var temples: Array<Temple>
    
    func choose(temple: Temple) {
        print("temple chosen: \(temple)")
    }
    
    // this second parameter of init is a function that takes in an Int and returns TempleContent
    // we will let view model to decide what the content is 
    init(numberOfTemples: Int, templeContentFactory: (Int) -> TempleContent) {
        temples = Array<Temple>()
        for index in 0..<numberOfTemples {
            let content = templeContentFactory(index)
            temples.append(Temple(content: content, id: index))
            
        }
        
    }
    
    // we make each temple unique, so that we can loop through them with ForEach 
    struct Temple: Identifiable {
        var content: TempleContent
        var id: Int
    }
    
    func getCoordinates(centerX: CGFloat, centerY: CGFloat) -> Array<Array<CGFloat>>{
        var t: CGFloat = -18
        var buildingCoordinates: Array<Array<CGFloat>> = Array<Array<CGFloat>>()
        var x: CGFloat
        var y: CGFloat
        let initialR: CGFloat = screenWidth / 10
        
        while t < 17.5
        {
            // spiral function：
            // x = p * cosA, y = p * sinA, where p = N * e^(B * cotC)
            // When C = PI/2, graph is a circle, when C = 0, graph is a straight line

            x = centerX + initialR * exp(t * CGFloat(1) / tan(CGFloat(47) * CGFloat.pi / CGFloat(100))) * cos(t)
            y = centerY + initialR * exp(t * CGFloat(1) / tan(CGFloat(47) * CGFloat.pi / CGFloat(100))) * sin(t)
        
            var oneSpiralCoordinate: Array<CGFloat> = Array<CGFloat>()
            oneSpiralCoordinate.append(x)
            oneSpiralCoordinate.append(y)
            buildingCoordinates.append(oneSpiralCoordinate)
            
            //print("oneSpiralCoordinate is \(oneSpiralCoordinate)")
            
            oneSpiralCoordinate.removeAll()
            
            t += 0.02
            
            //print("X is \(x)")
            //print("Y is \(y)")
            
        }
        
        //print("centerX is \(centerX)")
        //print("centerY is \(centerY)")
        //print("screenWidth is \(screenWidth)")
        //print("screenHeight is \(screenHeight)")
        
        //print("buildingCoordinates is \(buildingCoordinates)")
        //print("buildingCoordinates length is \(buildingCoordinates.count)")
        //print("buildingCoordinates 1000 is \(buildingCoordinates[1000])")
        
        return buildingCoordinates
            //.reversed()
        
    }
}
