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
    
    var body: some View {
        
        VStack {
            NavigationLink(destination: InAppWebView(url: "https://www.churchofjesuschrist.org/temples/list?lang=eng")) {
                    Text(sharedValues.currentTappedTempleName)
            }
            
            ScrollView {
                VStack {
                    // ...
                    ForEach(sharedValues.oneTempleInfo) {oneInfo in
                        Text(oneInfo.content)
                            //.fontWeight(.light)
                            
                            
                            //.position(x: screenWidth/2, y: CGFloat(oneInfo.id))
                            //.animation(withAnimation ? Animation.linear(duration: 3) : Animation.linear(duration: 0.001))
  
                    }
                    
                }
                //.frame(width: UIScreen.main.bounds.width)
            }
            
            //Text(settings.currentTappedTempleName)

        }
        .onTapGesture {
            SwiftUI.withAnimation(sharedValues.hasAnimation ? sharedValues.myAnimation : sharedValues.myNoAnimation) {
                sharedValues.oneTempleInfo.removeAll()
                //imageSpiralViewModel.updateOnScreenTemples(newTheta: sharedValues.sliderProgress)
            
                //var thisId = Int(sharedValues.currentTappedTempleId)
                //imageSpiralViewModel.changeATemple(id: thisId)

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
