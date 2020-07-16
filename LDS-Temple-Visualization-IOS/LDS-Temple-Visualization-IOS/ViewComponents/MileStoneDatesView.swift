//
//  MileStoneDatesView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by tiantian on 2020/7/13.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI

struct MileStoneDatesView: View {
    
    @EnvironmentObject var sharedValues: SharedValues
    
    @ObservedObject var imageSpiralViewModel: ImageSpiral
    
    var oneTempleInfo: String {
        get {
            
            var s: String = " "
            for i in sharedValues.oneTempleInfo {
                s += i.content
            }
            return s
        }
    }
    
    var body: some View {
        
        // "https://www.churchofjesuschrist.org/temples/list?lang=eng"
        
        VStack {
            NavigationLink(destination: InAppWebView(url:
//                                                        (sharedValues.currentTappedTempleLink == "no link" ? sharedValues.templesList : sharedValues.currentTappedTempleLink)
                                                        sharedValues.currentTappedTempleLink
                            )) {
                    Text(sharedValues.currentTappedTempleName)
            }
            
            ScrollView {
                VStack {
                    // ...
//                    ForEach(sharedValues.oneTempleInfo) {oneInfo in
//                        Text(oneInfo.content)
//                            //.fontWeight(.light)
//
//                            //.position(x: screenWidth/2, y: CGFloat(oneInfo.id))
//                            //.animation(withAnimation ? Animation.linear(duration: 3) : Animation.linear(duration: 0.001))
//
//                    }
                    Text(oneTempleInfo)
                        .multilineTextAlignment(.center)
                    
                }
                //.frame(width: UIScreen.main.bounds.width)
            }
            
            //Text(settings.currentTappedTempleName)

        }
        //.animation(sharedValues.hasAnimation ? sharedValues.myAnimation : sharedValues.myNoAnimation)
        .onTapGesture {
            SwiftUI.withAnimation(sharedValues.hasAnimation ? sharedValues.myAnimation : sharedValues.myNoAnimation) {
                //sharedValues.oneTempleInfo.removeAll()
                //imageSpiralViewModel.updateOnScreenTemples(newTheta: sharedValues.sliderProgress)
                sharedValues.tappedATemple = false
                //var thisId = Int(sharedValues.currentTappedTempleId)
                //imageSpiralViewModel.changeATemple(id: thisId)

                //sharedValues.singleTempleShow = false
            }
        }
        
        
        
    }
}

//
//
//struct MileStoneDatesView_Previews: PreviewProvider {
//    static var previews: some View {
//        MileStoneDatesView()
//    }
//}
