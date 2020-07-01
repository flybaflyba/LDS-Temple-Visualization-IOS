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
        let allTemples: Array<String> = ["aaa", "aab", "aac", "aad", "aae"]
        return Spiral<String>(numberOfTemples: allTemples.count) { index in
        return allTemples[index]
        
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
}
