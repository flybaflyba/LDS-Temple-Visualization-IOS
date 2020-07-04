//
//  ImageSpiral.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by Litian Zhang on 6/29/20.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI

// this is a ViewModel file

class ImageSpiral: ObservableObject {
    
    // theta is modified acoording to slider progress
    // then it is used to modify spiral model attributes
    static var theta: CGFloat = 4000

    static let templeNames: Array<String> = readTempleNamesFromFile()
    
    // we want to keep this model private, so that only this ViewModel can access to this model. (door closed)
    // we put set here, so that only this ViewModel can modify this model, but others can see it. (glass door)
    // private(set) var spiralModel: Spiral<String>
    
    // we can also close the door and use a function to access the model
    @Published private var spiralModel: Spiral<String> = ImageSpiral.createSpiral()
    
    // we will initialize with a function, createSpiral()
    // static means we can call this function on class, fot instace, we use this to initialze the model
    static func createSpiral() -> Spiral<String> {
        
        // this is all coordinates
        var coordinatesAndSizes: Array<Array<CGFloat>> = getCoordinatesAndSizes(centerX: centerX, centerY: centerY)
        
        // this is what temples are on screen
        var onScreenTemples: Array<String> = getOnScreenTemples(theta: theta, coordinatesLength: CGFloat(coordinatesAndSizes.count))
        
        // this is what location should on screen temples reside
        // each element here is the index of each temple's location in all coordinates
        var onScreenTemplesPositions: Array<CGFloat> = getOnScreenTemplesPositions(theta: theta, coordinatesLength: CGFloat(coordinatesAndSizes.count))
        
        //finally we passing the needed parameters to create out spiral model
        return Spiral<String>(numberOfTemples: onScreenTemples.count, coordinatesAndSizesP: coordinatesAndSizes, onScreenTemplesPositionsP: onScreenTemplesPositions) { index in
        return onScreenTemples[index]
        
        }
    }

    // MARK: - Access to the Model
 
    
    var onScreenTemples: Array<Spiral<String>.Temple> {
        return spiralModel.onScreenTemples
    }
    
    var onScreenTemplesPositions: Array<CGFloat> {
        return spiralModel.onScreenTemplesPositions
    }
    
    var coordinatesAndSizes: Array<Array<CGFloat>> {
        return spiralModel.coordinatesAndSizes
    }
    
    // MARK: - Intent(s)
    // this is where user intents come in
    func choose(temple: Spiral<String>.Temple) {
        spiralModel.choose(temple: temple)
    }
    
    func getNewTheta(newTheta: CGFloat) {
        ImageSpiral.theta = newTheta
        print("new theta is \(ImageSpiral.theta)")
    }
    
    // this function updateds on screen temples
    func updateOnScreenTemples(newTheta: CGFloat) {
        var onScreenTemplesPositionsNew: Array<CGFloat> = ImageSpiral.getOnScreenTemplesPositions(theta: newTheta, coordinatesLength: CGFloat(coordinatesAndSizes.count))
        
        var onScreenTemplesNew: Array<String> = ImageSpiral.getOnScreenTemples(theta: newTheta, coordinatesLength: CGFloat(coordinatesAndSizes.count))
        
        spiralModel.updateOnScreenTemples(onScreenTemplesPositionsNew: onScreenTemplesPositionsNew, onScreenTemplesNew: onScreenTemplesNew)

    }

    // calculation the whole spiral coordinates 
    static func getCoordinatesAndSizes(centerX: CGFloat, centerY: CGFloat) -> Array<Array<CGFloat>>{
        var t: CGFloat = -18
        var buildingCoordinatesAndSize: Array<Array<CGFloat>> = Array<Array<CGFloat>>()
        var x: CGFloat
        var y: CGFloat
        let initialR: CGFloat = screenWidth / 10
        var size: CGFloat
        var t2: CGFloat
        var x2: CGFloat
        var y2: CGFloat
        
        var oneSpiralCoordinateAndSize: Array<CGFloat> = Array<CGFloat>()
        
        while t < 17.5
        {
            // spiral function：
            // x = p * cosA, y = p * sinA, where p = N * e^(B * cotC)
            // When C = PI/2, graph is a circle, when C = 0, graph is a straight line

            x = centerX + initialR * exp(t * CGFloat(1) / tan(CGFloat(47) * CGFloat.pi / CGFloat(100))) * cos(t)
            y = centerY + initialR * exp(t * CGFloat(1) / tan(CGFloat(47) * CGFloat.pi / CGFloat(100))) * sin(t)
            
        
            // this is how we calculate sizes of each temple
            // by finding the distance betten two spiral lines while the angle difference is 2 * pi
            // got to multiply a constant to find the right size for that screen
            t2 = t - 2 * CGFloat.pi
            x2 = centerX + initialR * exp(t2 * CGFloat(1) / tan(CGFloat(47) * CGFloat.pi / CGFloat(100))) * cos(t)
            y2 = centerY + initialR * exp(t2 * CGFloat(1) / tan(CGFloat(47) * CGFloat.pi / CGFloat(100))) * sin(t)
            size = sqrt(pow((x2 - x), 2) + pow((y2 - y), 2)) * 1.3
            
            oneSpiralCoordinateAndSize.append(x)
            oneSpiralCoordinateAndSize.append(y)
            oneSpiralCoordinateAndSize.append(size)
            buildingCoordinatesAndSize.append(oneSpiralCoordinateAndSize)
            
            
            //print("oneSpiralCoordinateAndSize length is \(oneSpiralCoordinateAndSize.count)")
            
            oneSpiralCoordinateAndSize.removeAll()
            
            t += 0.02
            
            //print("X is \(x)")
            //print("Y is \(y)")
            
        }
        
        let topCoordinateInSpiralX = buildingCoordinatesAndSize[(buildingCoordinatesAndSize.count-1)][0];
        let topCoordinateInSpiralY = buildingCoordinatesAndSize[(buildingCoordinatesAndSize.count-1)][1];
        let topSizeInSpiral = buildingCoordinatesAndSize[(buildingCoordinatesAndSize.count-1)][2];

        
        var q = topCoordinateInSpiralX
        while q < screenWidth*1.25 {

            oneSpiralCoordinateAndSize.append(q)
            oneSpiralCoordinateAndSize.append(topCoordinateInSpiralY)
            oneSpiralCoordinateAndSize.append(topSizeInSpiral)
            buildingCoordinatesAndSize.append(oneSpiralCoordinateAndSize)
            
            //print("oneSpiralCoordinateAndSize length is \(oneSpiralCoordinateAndSize.count)")
            
            oneSpiralCoordinateAndSize.removeAll()
            
             q += 10
        }

        //print("centerX is \(centerX)")
        //print("centerY is \(centerY)")
        //print("screenWidth is \(screenWidth)")
        //print("screenHeight is \(screenHeight)")
        
        //print("buildingCoordinates is \(buildingCoordinates)")
        print("buildingCoordinatesAndSize length is \(buildingCoordinatesAndSize.count)")
        
        return buildingCoordinatesAndSize
            //.reversed()
        
    }
    

    
    static func getOnScreenTemples(theta: CGFloat, coordinatesLength: CGFloat) -> Array<String> {
        var collectingOnScreenTemples = Array<String>()
        var templePosition: CGFloat
        
        // here is the key logic to determin what temples should be on screen
        for templeIndex in 0..<ImageSpiral.templeNames.count {
            templePosition = theta - 30 * CGFloat(templeIndex)
            if templePosition > 0 && templePosition < CGFloat(coordinatesLength - 15) {
            collectingOnScreenTemples.append(ImageSpiral.templeNames[templeIndex])
            }
        }
        print("collectingOnScreenTemples length after should be \(collectingOnScreenTemples.count)")
        
        // we keep the array the same length, so that ForEach in spiral view will like it
        while collectingOnScreenTemples.count < 60 {
            collectingOnScreenTemples.append("")
        }
        print("collectingOnScreenTemples length after add extra is \(collectingOnScreenTemples.count)")
     
        return collectingOnScreenTemples
    }
     

    // this function is very much like the last one
    static func getOnScreenTemplesPositions(theta: CGFloat, coordinatesLength: CGFloat) -> Array<CGFloat> {
        var collectingOnScreenTemplesPositions = Array<CGFloat>()
        var templePosition: CGFloat
        for templeIndex in 0..<ImageSpiral.templeNames.count {
            templePosition = theta - 30 * CGFloat(templeIndex)
            if templePosition > 0 && templePosition < CGFloat(coordinatesLength - 15) {
                collectingOnScreenTemplesPositions.append(templePosition)
            }
        }
         
        print("collectingOnScreenTemplesPositions length should be \(collectingOnScreenTemplesPositions.count)")
    
        while collectingOnScreenTemplesPositions.count < 60 {
            collectingOnScreenTemplesPositions.append(0)
        }
        
        print("collectingOnScreenTemplesPositions length after adde extra is \(collectingOnScreenTemplesPositions.count)")
        return collectingOnScreenTemplesPositions
     }
    
    static func readTempleNamesFromFile() -> Array<String> {
        
        //var templeNames: Array<String> = Array<String>()
        var allTempleNames: Array<String> = linesFromResourceForced(fileName: "templeNames")
        
//        templeNames.append("kirtland_temple")
//        templeNames.append("old_nauvoo_temple")
//        templeNames.append("st_george_temple")
//        templeNames.append("logan_temple")
//        templeNames.append("manti_temple")
//
//        templeNames.append("kirtland_temple")
//        templeNames.append("old_nauvoo_temple")
//        templeNames.append("st_george_temple")
//        templeNames.append("logan_temple")
//        templeNames.append("manti_temple")
//
//        templeNames.append("kirtland_temple")
//        templeNames.append("old_nauvoo_temple")
//        templeNames.append("st_george_temple")
//        templeNames.append("logan_temple")
//        templeNames.append("manti_temple")
        
        
        
        //print(allTempleNames)
        
        allTempleNames.removeLast()
    
        print("allTempleNames length is \(allTempleNames.count)")
        
        return allTempleNames
    }
    
    static func linesFromResourceForced(fileName: String) -> [String] {

        let path = Bundle.main.path(forResource: fileName, ofType: "")!
        let content = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
        return content.components(separatedBy: "\n")
    }
    

    
    
    
    
    
}
