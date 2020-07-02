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
            
            //print(temples)
            
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
        
        var oneSpiralCoordinate: Array<CGFloat> = Array<CGFloat>()
        
        while t < 17.5
        {
            // spiral function：
            // x = p * cosA, y = p * sinA, where p = N * e^(B * cotC)
            // When C = PI/2, graph is a circle, when C = 0, graph is a straight line

            x = centerX + initialR * exp(t * CGFloat(1) / tan(CGFloat(47) * CGFloat.pi / CGFloat(100))) * cos(t)
            y = centerY + initialR * exp(t * CGFloat(1) / tan(CGFloat(47) * CGFloat.pi / CGFloat(100))) * sin(t)
        
            oneSpiralCoordinate.append(x)
            oneSpiralCoordinate.append(y)
            buildingCoordinates.append(oneSpiralCoordinate)
            
            //print("oneSpiralCoordinate is \(oneSpiralCoordinate)")
            
            oneSpiralCoordinate.removeAll()
            
            t += 0.02
            
            //print("X is \(x)")
            //print("Y is \(y)")
            
        }
        
        let topCoordinateInSpiralX = buildingCoordinates[(buildingCoordinates.count-1)][0];
        let topCoordinateInSpiralY = buildingCoordinates[(buildingCoordinates.count-1)][1];

        var q = topCoordinateInSpiralX
        while q < screenWidth*1.25 {

            oneSpiralCoordinate.append(q)
            oneSpiralCoordinate.append(topCoordinateInSpiralY)
            buildingCoordinates.append(oneSpiralCoordinate)
            
            oneSpiralCoordinate.removeAll()
            
             q += 10
        }

        
        //print("centerX is \(centerX)")
        //print("centerY is \(centerY)")
        //print("screenWidth is \(screenWidth)")
        //print("screenHeight is \(screenHeight)")
        
        //print("buildingCoordinates is \(buildingCoordinates)")
        print("buildingCoordinates length is \(buildingCoordinates.count)")
        
        return buildingCoordinates
            //.reversed()
        
    }
    
    
    func getOnScreenTemples(theta: CGFloat) -> Array<Temple> {
        var onScreenTemples = Array<Temple>()
        
//        java code
//        for (Bitmap t : temples)
//        float ts = theta - 30 * temples.indexOf(t);
//        if (ts > 0 && ts < spiralCoordinates.size() - 150)
    
        var templePosition: CGFloat
        
        for templeIndex in 0..<temples.count {
            
            templePosition = theta - 30 * CGFloat(templeIndex)
            
            if templePosition > 0 && templePosition < CGFloat(temples.count - 150) {
                onScreenTemples.append(temples[templeIndex])
                
            }
        }
                
        
        return onScreenTemples
    }
     
    
}
