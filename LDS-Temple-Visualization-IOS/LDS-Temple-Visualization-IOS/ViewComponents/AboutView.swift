//
//  AboutView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by tiantian on 2020/7/11.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI


extension UITextView {

  func addHyperLinksToText(originalText: String, hyperLinks: [String: String]) {
    let style = NSMutableParagraphStyle()
    style.alignment = .left
    let attributedOriginalText = NSMutableAttributedString(string: originalText)
    for (hyperLink, urlString) in hyperLinks {
        let linkRange = attributedOriginalText.mutableString.range(of: hyperLink)
        let fullRange = NSRange(location: 0, length: attributedOriginalText.length)
        attributedOriginalText.addAttribute(NSAttributedString.Key.link, value: urlString, range: linkRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: fullRange)
        //attributedOriginalText.addAttribute(NSAttributedString.Key.font, value: YourFont, range: fullRange)
    }

    self.linkTextAttributes = [
       //NSAttributedString.Key.foregroundColor: YourColor,
        NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
    ]
    self.attributedText = attributedOriginalText
  }
}


struct TextView: UIViewRepresentable {
   

    func makeUIView(context: Context) -> UITextView {
        return UITextView()
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = "hi"
    }
}



func Litian() -> Text {
    var body: Text {
        Text("Litian Zhang")
            .bold()
            .foregroundColor(Color.blue)
            
    }
    
    
    return body
}

func AboutText() -> some View {
    
    var about = NSMutableAttributedString(string: "Programming by Litian Zhang under the supervision of Dr. Geoffrey Draper at Brigham Young University--Hawaii. \r\rTemple photos are copyrighted by Intellectual Reserve, Inc. Used by permission. \r\rThis app is a research project funded by Brigham Young University--Hawaii, however the contents are the responsibility of its developers. This app is not an \"official\" publication of the Church of Jesus Christ of Latter-day Saints.")
    
    about.addAttribute(.link, value: "1", range: NSRange(location:0, length: 4))
    about.addAttribute(.link, value: "1", range: NSRange(location:10, length: 4))
    about.addAttribute(.link, value: "1", range: NSRange(location:20, length: 4))
    
   
    
    
    var a = UITextView()
    a.addHyperLinksToText(originalText: "Testing hyperlinks here and there", hyperLinks: ["here": "someUrl1", "there": "someUrl2"])
        
        
    var body: some View {
        
        VStack {
       
            TextView()
            //UITextView()
            
            Text("  ")
            Text("  ")
            
            
            Text("Programming by ")

            + Litian()

            + Text(" under the supervision of ")
            + Text("Dr. Geoffrey Draper")
            + Text(" at ")
            + Text("Brigham Young University--Hawaii")


            + Text(". \r\rTemple photos are copyrighted by Intellectual Reserve, Inc. Used by permission. \r\rThis app is a research project funded by Brigham Young University--Hawaii, however the contents are the responsibility of its developers. This app is not an \"official\" publication of ")
            + Text("the Church of Jesus Christ of Latter-day Saints")
            + Text(".")
            
            Text("  ")
        }
        
        
    }
    return body
}







struct AboutView: View {

    var body: some View {
        AboutViewMain()
            .navigationBarTitle("About")
    }

}

struct AboutViewMain: View {
    
    @EnvironmentObject var sharedValues: SharedValues
    
    //let appUrl = URL(string: "https://litianzhang.com/latter-day-temples-visualization-android-app/")
    
    @State var goingToWebView: Bool = false
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color.gray)
            
            VStack {
                
                NavigationLink(destination: InAppWebView(url: "https://litianzhang.com/latter-day-temples-visualization-android-app/") , isActive: $goingToWebView) {
                    Text("")
                }
                
               
                ScrollView {
                    
                    //AboutText()
                    
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
            
//            .onTapGesture {
//                SwiftUI.withAnimation(.easeOut) {
//                    settings.showAbout = false
//                }
            
//                                    
//            }
            
        }
        
  
    }
    
        }

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
