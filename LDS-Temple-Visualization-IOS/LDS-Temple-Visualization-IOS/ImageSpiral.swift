//
//  ImageSpiral.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by Litian Zhang on 6/29/20.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI

// this is a ViewModel file

func createTempleContent(index: Int) -> String {
    return "Hi"
}

class ImageSpiral {
    
    // we want to keep this model private, so that only this ViewModel can access to this model. (door closed)
    // we put set here, so that only this ViewModel can modify this model, but others can see it. (glass door)
    // private(set) var spiralModel: Spiral<String>
    
    // we can also close the door and use a function to access the model
    private var spiralModel: Spiral<String> = ImageSpiral.createSpiral()
        
        // we will initialize with a function, createSpiral()
        //Spiral<String>(numberOfTemples: 2, templeContentFactory: createTempleContent)
    
        // you can also do this after =, to initiaze the model, then no need for the extra function
        //Spiral<String>(numberOfTemples: 2) { _ in "Hi"}
    
    // static means we can call this function on class, fot instace, we use this to initialze the model
    static func createSpiral() -> Spiral<String> {
        let templeNames: Array<String> = readTempleNamesFromFile()
        return Spiral<String>(numberOfTemples: templeNames.count) { index in
        return templeNames[index]
        
        }
    }
        
    
    // MARK: - Access to the Model
    var temples: Array<Spiral<String>.Temple> {
        return spiralModel.temples
    }
    
    // MARK: - Intent(s)
    // this is where user intents come in
    func choose(temple: Spiral<String>.Temple) {
        spiralModel.choose(temple: temple)
    }
    
    func getCoordinates(centerX: CGFloat, centerY: CGFloat) -> Array<Array<CGFloat>> {
        spiralModel.getCoordinates(centerX: centerX,centerY: centerY)
    }
    
    static func readTempleNamesFromFile() -> Array<String> {
        
        //var templeNames: Array<String> = Array<String>()
        let allTempleNames: Array<String> = linesFromResourceForced(fileName: "templeNames")
        
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
        
        
        
        print(allTempleNames)
        
        return allTempleNames
    }
    
    static func linesFromResourceForced(fileName: String) -> [String] {

        let path = Bundle.main.path(forResource: fileName, ofType: "")!
        let content = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
        return content.components(separatedBy: "\n")
    }
    
    
    
    
}
