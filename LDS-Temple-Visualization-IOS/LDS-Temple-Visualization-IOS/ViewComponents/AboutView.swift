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
    
    @EnvironmentObject var sharedValues: SharedValues
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color.gray)
            
            VStack {
                ScrollView {
                    Text("  ")
                    Text("  ")
                    Text("Programming by Litian Zhang under the supervision of Dr. Geoffrey Draper at Brigham Young University--Hawaii. \r\rTemple photos are copyrighted by Intellectual Reserve, Inc. Used by permission. \r\rThis app is a research project funded by Brigham Young University--Hawaii, however the contents are the responsibility of its developers. This app is not an \"official\" publication of the Church of Jesus Christ of Latter-day Saints.")
                    Text("  ")
                    
                    NavigationLink(destination: InAppWebView(url: "https://litianzhang.com/latter-day-temples-visualization-android-app/")) {
                        HStack {
                            Text("Visit App Website")
                            Image(systemName: "link")
                        }
                    }
                }
                .padding()
                //.background(Color.red)
            }
        }
    }
    }

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
