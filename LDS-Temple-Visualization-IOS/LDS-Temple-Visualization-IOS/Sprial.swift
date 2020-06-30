//
//  Sprial.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by Litian Zhang on 6/29/20.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import Foundation

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
}
