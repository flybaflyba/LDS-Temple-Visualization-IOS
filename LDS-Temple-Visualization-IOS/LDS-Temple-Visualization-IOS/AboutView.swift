//
//  AboutView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by tiantian on 2020/7/11.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    @EnvironmentObject var settings: SettingValues
    
    var body: some View {
        VStack {
            
            Text("Programming by Litian Zhang under the supervision of Dr. Geoffrey Draper at Brigham Young University--Hawaii. \r\rTemple photos are copyrighted by Intellectual Reserve, Inc. Used by permission. \r\rThis app is a research project funded by Brigham Young University--Hawaii, however the contents are the responsibility of its developers. This app is not an \"official\" publication of the Church of Jesus Christ of Latter-day Saints.")
                .padding()

            Button(action: {
                SwiftUI.withAnimation(.easeOut) {
                    settings.showAbout = false
                }
                
            }) {
                Text("Return to Settings")
            }
            .padding()
                        
           
//
//            Button(action: {
//
//            }) {
//                Text("Visit App Website")
//            }
//            .padding()
            
           
            //Text("<a href='https://litianzhang.com/latter-day-temples-visualization-android-app/'>Visit the app's website</a>")
   
        }
    }
}


struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
