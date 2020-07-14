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
    static var theta: CGFloat = 3000

    static var startYear: String = ""
    static var endYear: String = ""
    
    //static var buildingCoordinatesAndSizeLength: Int = 0
    
    static let templeNames: Array<String> = readTempleNamesFromFile()
    static let templeNamesAndYears: Array<Array<String>> = readTempleNameYearFromFile()
//    
////    static var screenWidth: CGFloat = SharedValues().screenWidth
////    static var screenHeight: CGFloat = SharedValues().screenHeight
////    static var centerX: CGFloat = SharedValues().centerX
////    static var centerY: CGFloat = SharedValues().centerY
//    
//    static var screenWidth = UIScreen.main.bounds.size.width
//    static var screenHeight = UIScreen.main.bounds.size.height
//    static var centerX = UIScreen.main.bounds.size.width / 2
//    static var centerY = UIScreen.main.bounds.size.height * 0.8 / 2
    
    // we make each one unique, so that we can loop through them with ForEach
    struct Info: Identifiable {
        var content: String
        var id: Int
    }
    
//    static var screenWidth: CGFloat = UIScreen.main.bounds.size.width
//    static var screenHeight: CGFloat = UIScreen.main.bounds.size.height
    
    //static var coordinatesAndSizes: Array<Array<CGFloat>> = getCoordinatesAndSizes(centerX: centerX, centerY: centerY, mode: "default")
    
    // we want to keep this model private, so that only this ViewModel can access to this model. (door closed)
    // we put set here, so that only this ViewModel can modify this model, but others can see it. (glass door)
    // private(set) var spiralModel: Spiral<String>
    
    // we can also close the door and use a function to access the model
    @Published private var spiralModel: Spiral<Image> = ImageSpiral.createSpiral()
    
    // we will initialize with a function, createSpiral()
    // static means we can call this function on class, fot instace, we use this to initialze the model
    static func createSpiral() -> Spiral<Image> {
        
        // this is all coordinates
        let coordinatesAndSizes: Array<Array<CGFloat>> = getCoordinatesAndSizes(centerX: centerX, centerY: centerY, mode: "default")
        
        // this is what temples are on screen
        let onScreenTemplesString: Array<Array<String>> = getOnScreenTemples(theta: theta, coordinatesLength: CGFloat(coordinatesAndSizes.count))
        
        // this is what location should on screen temples reside
        // each element here is the index of each temple's location in all coordinates
        let onScreenTemplesPositions: Array<CGFloat> = getOnScreenTemplesPositions(theta: theta, coordinatesLength: CGFloat(coordinatesAndSizes.count))
        
        //finally we passing the needed parameters to create out spiral model
//        return Spiral<String>(numberOfTemples: onScreenTemples.count, coordinatesAndSizesP: coordinatesAndSizes, onScreenTemplesPositionsP: onScreenTemplesPositions) { index in
//        return onScreenTemples[index]
            
        return Spiral<Image>(onScreenTemplesString: onScreenTemplesString, coordinatesAndSizesP: coordinatesAndSizes, onScreenTemplesPositionsP: onScreenTemplesPositions)
        
    }

    // MARK: - Access to the Model
 
    
    var onScreenTemples: Array<Spiral<Image>.Temple> {
        return spiralModel.onScreenTemples
    }
    
    var mode: String {
        return spiralModel.mode
    }
    /*
    var onScreenTemplesPositions: Array<CGFloat> {
        return spiralModel.onScreenTemplesPositions
    }
    
    var coordinatesAndSizes: Array<Array<CGFloat>> {
        return spiralModel.coordinatesAndSizes
    }
     */
    
    // MARK: - Intent(s)
    // this is where user intents come in
    func choose(temple: Spiral<Image>.Temple) {
        spiralModel.choose(temple: temple)
    }
    
    func changeATemple(id: Int) {
        spiralModel.changeATemple(id: id)
    }
    
    func changeMode(newMode: String) {
        spiralModel.changeMode(newMode: newMode)
    }
    
    func getNewTheta(newTheta: CGFloat) {
        ImageSpiral.theta = newTheta
        print("new theta is \(ImageSpiral.theta)")
    }
    /*
    // when updating, we will modify all coordinates acoording to user's selection of moving mode.
    static func spinningMode(mode: String) {
        var x: CGFloat
        var y: CGFloat
        var angle: CGFloat
        var xNew: CGFloat
        var yNew: CGFloat
        
        
        for index in 0..<ImageSpiral.coordinatesAndSizes.count {
            
            //print(ImageSpiral.coordinatesAndSizes[index])
        
            
            x = ImageSpiral.coordinatesAndSizes[index][0]
            y = ImageSpiral.coordinatesAndSizes[index][1]
            angle = theta / 10000;
            xNew = (x - centerX) * cos(angle) - (y - centerY) * sin(angle) + centerX;
            yNew = (y - centerY) * cos(angle) + (x - centerX) * sin(angle) + centerY;
            
            ImageSpiral.coordinatesAndSizes[index][0] = xNew
            ImageSpiral.coordinatesAndSizes[index][1] = yNew
            
        }
        
        
        
    }
    
    */
    
    // this function updateds on screen temples
    func updateOnScreenTemples(newTheta: CGFloat) {
        
//        var onScreenTemplesPositionsNew: Array<CGFloat> = ImageSpiral.getOnScreenTemplesPositions(theta: newTheta, coordinatesLength: CGFloat(coordinatesAndSizes.count))
//        var onScreenTemplesNew: Array<String> = ImageSpiral.getOnScreenTemples(theta: newTheta, coordinatesLength: CGFloat(coordinatesAndSizes.count))
//        spiralModel.updateOnScreenTemples(onScreenTemplesPositionsNew: onScreenTemplesPositionsNew, onScreenTemplesNew: onScreenTemplesNew)

        //ImageSpiral.spinningMode(mode: "spin")
        
        let coordinatesAndSizes: Array<Array<CGFloat>> = ImageSpiral.getCoordinatesAndSizes(centerX: centerX, centerY: centerY, mode: spiralModel.mode)
        
        
        let onScreenTemplesString: Array<Array<String>> = ImageSpiral.getOnScreenTemples(theta: ImageSpiral.theta, coordinatesLength: CGFloat(coordinatesAndSizes.count))
        let onScreenTemplesPositions: Array<CGFloat> = ImageSpiral.getOnScreenTemplesPositions(theta: ImageSpiral.theta, coordinatesLength: CGFloat(coordinatesAndSizes.count))
        
        spiralModel.updateOnScreenTemples(onScreenTemplesString: onScreenTemplesString, coordinatesAndSizesP: coordinatesAndSizes, onScreenTemplesPositionsP: onScreenTemplesPositions)
        
    }

    // calculation the whole spiral coordinates
    // we include all temples on screen, even though some of them are very small in the center
    // because if we don't animation will suspend after the numbers of temples on screen reach max
    static func getCoordinatesAndSizes(centerX: CGFloat, centerY: CGFloat, mode: String) -> Array<Array<CGFloat>>{
        
        
        // when animation, less coordinates, but more temples
        //var t: CGFloat = -120
        
        // when no animation, more coordinates, but less temples
        var t: CGFloat = -120
        
        
        var buildingCoordinatesAndSize: Array<Array<CGFloat>> = Array<Array<CGFloat>>()
        var x: CGFloat
        var y: CGFloat
        let initialR: CGFloat = screenWidth / 10
        var size: CGFloat
        var t2: CGFloat
        var x2: CGFloat
        var y2: CGFloat
        
        var xNew: CGFloat
        var yNew: CGFloat
        var angle: CGFloat
        
        var oneSpiralCoordinateAndSize: Array<CGFloat> = Array<CGFloat>()
        
        
        
        
        // t stands for theta, it's a angle in spiral
        
        // when t < -18, we are at the center of spiral, the coordinates can be spreaded out more
        // therefore t is adding up a big value each time
//        while t < -18 {
//
//            x = centerX + initialR * exp(t * CGFloat(1) / tan(CGFloat(47) * CGFloat.pi / CGFloat(100))) * cos(t)
//            y = centerY + initialR * exp(t * CGFloat(1) / tan(CGFloat(47) * CGFloat.pi / CGFloat(100))) * sin(t)
//
//            if mode == "spin" {
//                angle = theta / 100
//                xNew = (x - centerX) * cos(angle) - (y - centerY) * sin(angle) + centerX;
//                yNew = (y - centerY) * cos(angle) + (x - centerX) * sin(angle) + centerY;
//            } else if mode == "zoom" {
//                angle = theta / 45
//                xNew = (x - centerX) * cos(angle) - (y - centerY) * sin(angle) + centerX;
//                yNew = (y - centerY) * cos(angle) + (x - centerX) * sin(angle) + centerY;
//            } else if mode == "3D" {
//                angle = theta / 500
//                xNew = (x - centerX) * cos(angle) - (y - centerY) * sin(angle) + centerX;
//                yNew = (y - centerY) * cos(angle) + (xNew - centerX) * sin(angle) + centerY;
//            } else  {
//                xNew = x
//                yNew = y
//
//            }
//            t2 = t - 2 * CGFloat.pi
//            x2 = centerX + initialR * exp(t2 * CGFloat(1) / tan(CGFloat(47) * CGFloat.pi / CGFloat(100))) * cos(t)
//            y2 = centerY + initialR * exp(t2 * CGFloat(1) / tan(CGFloat(47) * CGFloat.pi / CGFloat(100))) * sin(t)
//            size = sqrt(pow((x2 - x), 2) + pow((y2 - y), 2)) * 1.3
//
//            oneSpiralCoordinateAndSize.append(xNew)
//            oneSpiralCoordinateAndSize.append(yNew)
//            oneSpiralCoordinateAndSize.append(size)
//            buildingCoordinatesAndSize.append(oneSpiralCoordinateAndSize)
//
//            oneSpiralCoordinateAndSize.removeAll()
//
//            t += 1
//        }
//
//        print("buildingCoordinatesAndSize PRE length is \(buildingCoordinatesAndSize.count)")
//
//        print(mode)
        
        t = -18
        
        while t < 17.5
        {
            // spiral function：
            // x = p * cosA, y = p * sinA, where p = N * e^(B * cotC)
            // When C = PI/2, graph is a circle, when C = 0, graph is a straight line

            x = centerX + initialR * exp(t * CGFloat(1) / tan(CGFloat(47) * CGFloat.pi / CGFloat(100))) * cos(t)
            y = centerY + initialR * exp(t * CGFloat(1) / tan(CGFloat(47) * CGFloat.pi / CGFloat(100))) * sin(t)
            
            
            
            if mode == "spin" {
                angle = theta / 100
                xNew = (x - centerX) * cos(angle) - (y - centerY) * sin(angle) + centerX;
                yNew = (y - centerY) * cos(angle) + (x - centerX) * sin(angle) + centerY;
            } else if mode == "zoom" {
                angle = theta / 45
                xNew = (x - centerX) * cos(angle) - (y - centerY) * sin(angle) + centerX;
                yNew = (y - centerY) * cos(angle) + (x - centerX) * sin(angle) + centerY;
            } else if mode == "3D" {
                angle = theta / 500
                xNew = (x - centerX) * cos(angle) - (y - centerY) * sin(angle) + centerX;
                yNew = (y - centerY) * cos(angle) + (xNew - centerX) * sin(angle) + centerY;
            } else  {
                xNew = x
                yNew = y
                
            }
            
            // this is how we calculate sizes of each temple
            // by finding the distance betten two spiral lines while the angle difference is 2 * pi
            // got to multiply a constant to find the right size for that screen
            t2 = t - 2 * CGFloat.pi
            x2 = centerX + initialR * exp(t2 * CGFloat(1) / tan(CGFloat(47) * CGFloat.pi / CGFloat(100))) * cos(t)
            y2 = centerY + initialR * exp(t2 * CGFloat(1) / tan(CGFloat(47) * CGFloat.pi / CGFloat(100))) * sin(t)
            size = sqrt(pow((x2 - x), 2) + pow((y2 - y), 2)) * 1.3
            
            oneSpiralCoordinateAndSize.append(xNew)
            oneSpiralCoordinateAndSize.append(yNew)
            oneSpiralCoordinateAndSize.append(size)
            buildingCoordinatesAndSize.append(oneSpiralCoordinateAndSize)
            
            
            //print("oneSpiralCoordinateAndSize length is \(oneSpiralCoordinateAndSize.count)")
            
            oneSpiralCoordinateAndSize.removeAll()
            
            // when animation, less coordinates
            //t += 0.6
            
            // when no animation, more coordinates
            t += 0.02
            
            //print("X is \(x)")
            //print("Y is \(y)")
            
        }
        
        let topCoordinateInSpiralX = buildingCoordinatesAndSize[(buildingCoordinatesAndSize.count-1)][0];
        let topCoordinateInSpiralY = buildingCoordinatesAndSize[(buildingCoordinatesAndSize.count-1)][1];
        let topSizeInSpiral = buildingCoordinatesAndSize[(buildingCoordinatesAndSize.count-1)][2];

        
//        var q = topCoordinateInSpiralX
//
//        while q < screenWidth {
//
//            oneSpiralCoordinateAndSize.append(q)
//            oneSpiralCoordinateAndSize.append(topCoordinateInSpiralY)
//            oneSpiralCoordinateAndSize.append(topSizeInSpiral)
//            buildingCoordinatesAndSize.append(oneSpiralCoordinateAndSize)
//
//            //print("oneSpiralCoordinateAndSize length is \(oneSpiralCoordinateAndSize.count)")
//
//            oneSpiralCoordinateAndSize.removeAll()
//
//             q += 10
//        }
        
        
        // when animation, less coordinates
        
//        oneSpiralCoordinateAndSize.append(screenWidth*1.5)
//        oneSpiralCoordinateAndSize.append(topCoordinateInSpiralY)
//        oneSpiralCoordinateAndSize.append(topSizeInSpiral)
//        buildingCoordinatesAndSize.append(oneSpiralCoordinateAndSize)
//        oneSpiralCoordinateAndSize.removeAll()
        
        // when no animation, more coordinates
    
        
        
        if mode == "spin" {
            let secondTopCoordinateInSpiralX: CGFloat = buildingCoordinatesAndSize[(buildingCoordinatesAndSize.count-2)][0];
            let secondTopCoordinateInSpiralY: CGFloat = buildingCoordinatesAndSize[(buildingCoordinatesAndSize.count-2)][1];
            let xDirection: CGFloat = topCoordinateInSpiralX - secondTopCoordinateInSpiralX;
            let yDirection: CGFloat = topCoordinateInSpiralY - secondTopCoordinateInSpiralY;
            
            for i in 1..<40 {
                
                let step: CGFloat = CGFloat(i) * 20;
                
                oneSpiralCoordinateAndSize.append(xDirection / abs(xDirection) * step + secondTopCoordinateInSpiralX);
                oneSpiralCoordinateAndSize.append(yDirection / abs(yDirection) * step + secondTopCoordinateInSpiralY);
                oneSpiralCoordinateAndSize.append(topSizeInSpiral)
                buildingCoordinatesAndSize.append(oneSpiralCoordinateAndSize)
                oneSpiralCoordinateAndSize.removeAll()
            }
            
            
        } else  {
            var q = topCoordinateInSpiralX
            
            while q < screenWidth * 2 {
            
                oneSpiralCoordinateAndSize.append(q)
                oneSpiralCoordinateAndSize.append(topCoordinateInSpiralY)
                oneSpiralCoordinateAndSize.append(topSizeInSpiral)
                buildingCoordinatesAndSize.append(oneSpiralCoordinateAndSize)
        
                //print("oneSpiralCoordinateAndSize length is \(oneSpiralCoordinateAndSize.count)")

                oneSpiralCoordinateAndSize.removeAll()
        
                    q += 5
            }
            
        }
        
        
        

        //print("centerX is \(centerX)")
        //print("centerY is \(centerY)")
        //print("screenWidth is \(screenWidth)")
        //print("screenHeight is \(screenHeight)")
        
        //print("buildingCoordinates is \(buildingCoordinates)")
        print("buildingCoordinatesAndSize length is \(buildingCoordinatesAndSize.count)")
        //print("buildingCoordinatesAndSize is \(buildingCoordinatesAndSize)")
        
        //buildingCoordinatesAndSizeLength = buildingCoordinatesAndSize.count
        
        return buildingCoordinatesAndSize
            .reversed()
        
    }
    

    
    static func getOnScreenTemples(theta: CGFloat, coordinatesLength: CGFloat) -> Array<Array<String>> {
        var collectingOnScreenTemples = Array<String>()
        var templePosition: CGFloat
        
        var collectingOnScreenTemplesNames = Array<String>()
        var collectingOnScreenTemplesYears = Array<String>()
        
        //print(ImageSpiral.templeNamesAndYears[1])
        
        var gotStartYear: Bool = false
        // here is the key logic to determin what temples should be on screen
        for templeIndex in 0..<ImageSpiral.templeNames.count {
            
            templePosition = theta - 30*CGFloat(templeIndex)
            
            if templePosition >= 0 && templePosition < CGFloat(coordinatesLength) {
                collectingOnScreenTemples.append(ImageSpiral.templeNames[templeIndex])
                collectingOnScreenTemplesNames.append(ImageSpiral.templeNamesAndYears[0][templeIndex])
                collectingOnScreenTemplesYears.append(ImageSpiral.templeNamesAndYears[1][templeIndex])
                //print("name here -------\(ImageSpiral.templeNamesAndYears[0][templeIndex])")
                
                //print("year here +++\(ImageSpiral.templeNamesAndYears[1][templeIndex])")
                if gotStartYear == false {
                    startYear = ImageSpiral.templeNamesAndYears[1][templeIndex]
                    gotStartYear = true
                }
                endYear = ImageSpiral.templeNamesAndYears[1][templeIndex]
                
            }
            
            // this is kind of extra, we can just delete the < in last if,
            // but i still write it here so that its more understandable
            // if the center temples are out of all coordinates and size range, we still add it to on screen temple list
            // because if we do animation we need this
            if templePosition < 0 || templePosition >= CGFloat(coordinatesLength) {
                collectingOnScreenTemples.append("clear_image")
                collectingOnScreenTemplesNames.append("No Temple")
                collectingOnScreenTemplesYears.append("No Year")
            }
            
            //print(templePosition)
            
        }
        print("collectingOnScreenTemples length after should be \(collectingOnScreenTemples.count)")
        print("collectingOnScreenTemplesNames length after should be \(collectingOnScreenTemplesNames.count)")
        print("collectingOnScreenTemplesYears length after should be \(collectingOnScreenTemplesYears.count)")
        
        print("start year is \(startYear)")
        print("end year is \(endYear)")
        
//        //print("buildingCoordinatesAndSizeLength is \(buildingCoordinatesAndSizeLength)")
//        // we keep the array the same length, so that ForEach in spiral view will like it
//        while collectingOnScreenTemples.count < 61 {
//            collectingOnScreenTemples.append("clear_image")
//        }
//        print("collectingOnScreenTemples length after add extra is \(collectingOnScreenTemples.count)")
//
//        //print("collectingOnScreenTemples after add extra is \(collectingOnScreenTemples)")
     
        var collectingOnScreenTemplesNamesAndYears: Array<Array<String>> = Array<Array<String>>()
        collectingOnScreenTemplesNamesAndYears.append(collectingOnScreenTemples)
        collectingOnScreenTemplesNamesAndYears.append(collectingOnScreenTemplesNames)
        collectingOnScreenTemplesNamesAndYears.append(collectingOnScreenTemplesYears)
        
        //print(collectingOnScreenTemplesNamesAndYears)
        
        return collectingOnScreenTemplesNamesAndYears
    }
     

    // this function is very much like the last one
    static func getOnScreenTemplesPositions(theta: CGFloat, coordinatesLength: CGFloat) -> Array<CGFloat> {
        var collectingOnScreenTemplesPositions = Array<CGFloat>()
        var templePosition: CGFloat
        for templeIndex in 0..<ImageSpiral.templeNames.count {
            templePosition = theta - 30*CGFloat(templeIndex)
            if templePosition >= 0 && templePosition < CGFloat(coordinatesLength) {
                collectingOnScreenTemplesPositions.append(templePosition)
            }
            
            if templePosition < 0 || templePosition >= CGFloat(coordinatesLength) {
                collectingOnScreenTemplesPositions.append(0)
            }
            
        }
         
        print("collectingOnScreenTemplesPositions length should be \(collectingOnScreenTemplesPositions.count)")
    
//        //print("buildingCoordinatesAndSizeLength is \(buildingCoordinatesAndSizeLength)")
//        while collectingOnScreenTemplesPositions.count < 61 {
//            collectingOnScreenTemplesPositions.append(0)
//        }
//
//        print("collectingOnScreenTemplesPositions length after adde extra is \(collectingOnScreenTemplesPositions.count)")
        
//        print("collectingOnScreenTemplesPositions after adde extra is \(collectingOnScreenTemplesPositions)")
//
//        let collectingOnScreenTemplesPositionsReversed: Array<CGFloat> = collectingOnScreenTemplesPositions.reversed()
//        print("collectingOnScreenTemplesPositions after adde extra REVERSED is \(collectingOnScreenTemplesPositionsReversed)")
        
        return collectingOnScreenTemplesPositions
     }
    
    static func readTempleNamesFromFile() -> Array<String> {
        
        //var templeNames: Array<String> = Array<String>()
        var allTempleNames: Array<String> = linesFromResourceForced(fileName: "templeFilesNames")
        
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
    
    static func readTempleNameYearFromFile() -> Array<Array<String>> {
        var allTempleNamesYears: Array<String> = linesFromResourceForced(fileName: "templeNamesYears")
        allTempleNamesYears.removeLast()
        allTempleNamesYears.removeLast()
        // we do remove lastt twice, becasue there is shanghai temple in the file,
        // but we are not showing it becasue the church website does not have it yet
        
        var allTempleNames: Array<String> = Array<String>()
        var allTempleYears: Array<String> = Array<String>()
        
        for i in 0..<allTempleNamesYears.count / 2 {
            allTempleNames.append(allTempleNamesYears[2 * i])
            allTempleYears.append(allTempleNamesYears[2 * i + 1])
        }
        
        print("allTempleYear length is \(allTempleYears.count)")
        print("allTempleNames length is \(allTempleNames.count)")
        
        var allTempleNamesYearsCombine: Array<Array<String>> = Array<Array<String>>()
        allTempleNamesYearsCombine.append(allTempleNames)
        allTempleNamesYearsCombine.append(allTempleYears)
        
        return allTempleNamesYearsCombine
    }
    
    func readOneTempleInfoFromFile(fileName: String) -> Array<Info> {
    //func readOneTempleInfoFromFile(fileName: String) -> String {
        let oneTempleInfoNew: Array<String> = ImageSpiral.linesFromResourceForced(fileName: fileName)
        
        print("reading this temple's info from file: \(fileName)")
        
        var oneTempleInfo: Array<Info> = Array<Info>()
        for index in 0..<oneTempleInfoNew.count {
            oneTempleInfo.append(Info(content: oneTempleInfoNew[index], id: index))
        }
        
//        var oneTempleInfo: String = ""
//        for index in 0..<oneTempleInfoNew.count {
//            oneTempleInfo += oneTempleInfoNew[index]
//        }
        
        
        
        return oneTempleInfo
    }
    

    
    
    
    
    
}
