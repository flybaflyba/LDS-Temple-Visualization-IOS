//
//  AboutView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by tiantian on 2020/7/11.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI


struct AboutView: View {

    var body: some View {
        AboutViewMain()
            .navigationBarTitle("About")
    }

}

struct AboutViewMain: View {
    
    @EnvironmentObject var settings: SettingValues
    
    //let appUrl = URL(string: "https://litianzhang.com/latter-day-temples-visualization-android-app/")
    
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color.gray)
            
            VStack {
                
                
                Text("Programming by Litian Zhang under the supervision of Dr. Geoffrey Draper at Brigham Young University--Hawaii. \r\rTemple photos are copyrighted by Intellectual Reserve, Inc. Used by permission. \r\rThis app is a research project funded by Brigham Young University--Hawaii, however the contents are the responsibility of its developers. This app is not an \"official\" publication of the Church of Jesus Christ of Latter-day Saints.")
                    .padding()

                NavigationLink(destination: InAppWebView(url: "https://litianzhang.com/latter-day-temples-visualization-android-app/")) {
                    Text("Visit App Website")
                }
                
                //Button("Visit App Website") {UIApplication.shared.open(appUrl!)}
                
                
                    
//                Button(action: {
//                    SwiftUI.withAnimation(.easeOut) {
//                        settings.showAbout = false
//                    }
//
//                }) {
//                    Text("Return to Settings")
//                }
                
                .padding()
            }
            .onTapGesture {
                SwiftUI.withAnimation(.easeOut) {
                    settings.showAbout = false
                }
                                    
            }
            
        }
        
  
    }
    
        }

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
