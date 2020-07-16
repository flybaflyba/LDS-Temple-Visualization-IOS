//
//  MainScreenView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by Litian Zhang on 6/29/20.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI


// use screen Height to set how much space each view should take on the screen
public var screenWidth = (UIDevice.current.userInterfaceIdiom == .phone ? min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) : min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 0.7)
public var screenHeight = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
public var centerX = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) / 2
public var centerY = screenHeight * 0.8 / 2



//let statusbarHeight = UIApplication.shared.st


struct MainScreenView: View {
//
//    @Binding var mode: String
//    @Binding var hasAnimation: Bool
//
    
//    @State var mode: String = "default"
//    @State var hasAnimation: Bool = true
    
    
    //@EnvironmentObject var settings: SettingValues
    
        
//    func getAppTitle() -> String {
//        var title = settings.appTitle
//        return title
//    }
    
    
    //UIDevice.current.orientation.isPortrait
   
    
    
    
    var body: some View {
        
        ZStack {
          
//            Rectangle()
//                .background(Color.red)
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
            
            
            NavigationView {
                SpiralView()
                    
                    //.frame(width: screenWidth, height: screenHeight, alignment: Alignment.center)
                    //.background(Color.gray)
                    .navigationBarTitle("Latter-day Temples", displayMode: .inline)
                    .navigationBarItems(trailing:
                                            NavigationLink(destination: SettingView()) {
                                                Image(systemName: "ellipsis.circle.fill")

                                            }
                                                

                )
                
        }
            .navigationViewStyle(StackNavigationViewStyle())
            
        }

            
            
            
    }
}



struct SpiralView: View {

    
    //@EnvironmentObject var deviceOrientationEnv: DeviceOrientationEnv
    
    
    // we make this observed object,
    // along with its published spiral model in its class,
    // this view will update when changes happen to the model 
    @ObservedObject var imageSpiralViewModel: ImageSpiral = ImageSpiral()

    //screenWidth: SharedValues.screenWidth, screenHeight: SharedValues.screenHeight, centerX: SharedValues.centerX, centerY: SharedValues.centerY
    
    @EnvironmentObject var sharedValues: SharedValues
    
    var currentScreenWidth: CGFloat {
        get {
            //print("new screen width: \(sharedValues.currentScreenWidth)")
            return sharedValues.currentScreenWidth
        }
    }
    
    var currentScreenHeight: CGFloat {
        get {
            //print("new screen height: \(sharedValues.currentScreenHeight)")
            return sharedValues.currentScreenHeight
        }
    }
    
    
    func drawTemples() -> some View {
        
       
        
        if sharedValues.orientationChanged == true {
            
            if sharedValues.singleTempleShow {
                imageSpiralViewModel.changeATemple(id: sharedValues.currentTappedTempleId)
            }
            
            imageSpiralViewModel.updateOnScreenTemples(newTheta: sharedValues.sliderProgress)
            sharedValues.orientationChanged = false
            print("relocate spiral")
            
            if sharedValues.singleTempleShow {
                imageSpiralViewModel.changeATemple(id: sharedValues.currentTappedTempleId)
            }
           
            print("changed a temple")
        
        }
        
        var body: some View {
           
            ZStack {
                ForEach(imageSpiralViewModel.onScreenTemples) {temple in
                    temple.content
                        .resizable()
                        .frame(width: temple.size, height: temple.size, alignment: Alignment.center)
                        .position(x: temple.x, y: temple.y)
                        .animation(sharedValues.hasAnimation ? sharedValues.myAnimation : sharedValues.myNoAnimation)
                        .onTapGesture {
                            //print(temple)
                            //imageSpiralViewModel.choose(temple: temple)
                            //print(temple.year)
                            //temple.content.resizable().frame(width: screenWidth, height: screenWidth, alignment: Alignment.center)
                            
                            print("tapped a temple")
                            
                            imageSpiralViewModel.changeATemple(id: temple.id)
                            
                            print("tapped temple Link is \(temple.link)")
                            
                            //print(screenWidth)
                            //print(sharedValues.orientation.rawValue)
                           
                            //print("hi")
                            
                            if (temple.tapped == true) {
                                SwiftUI.withAnimation(sharedValues.hasAnimation ? sharedValues.myAnimation : sharedValues.myNoAnimation) {
                                    
                                    //sharedValues.oneTempleInfo.removeAll()
                                    
                                    sharedValues.tappedATemple = false
                                 
                                    sharedValues.singleTempleShow = false
                                    print("tap a large temple")
                                    
                                
                                }
                            } else {
                                SwiftUI.withAnimation(sharedValues.hasAnimation ? sharedValues.myAnimation : sharedValues.myNoAnimation) {
                                    sharedValues.oneTempleInfo = imageSpiralViewModel.readOneTempleInfoFromFile(fileName: temple.fileName)
                                    
                                    sharedValues.tappedATemple = true
                                    
                                    sharedValues.singleTempleShow = true
                                    print("tap a small temple")
                                }
                                
                                sharedValues.currentTappedTempleName = temple.name
                                sharedValues.currentTappedTempleId = temple.id
                                sharedValues.currentTappedTempleLink = temple.link
                            
                                //print(sharedValues.currentTappedTempleName)
                                
                                
                                //print(oneTempleInfo)
                            }
                            
                            //print("hello")
                            
                        }
                    // this line shows us how the spiral looks like on screen
                    //spiralDrawing().stroke()
                }
                
//                if sharedValues.orientationInText == "portrait" {
//                    VStack {
//                        Text("portrait")
//                        Text("currentScreenWidth is: \(currentScreenWidth)")
//                        Text("currentScreenHeight is: \(currentScreenHeight)")
//                    }
//                } else if sharedValues.orientationInText == "landscape" {
//                    VStack {
//                        Text("landscape")
//                        Text("currentScreenWidth is: \(currentScreenWidth)")
//                        Text("currentScreenHeight is: \(currentScreenHeight)")
//                    }
//                }
                
            }
            
           
            
        }
        
        return body
    }
    
    
    func PortraitView() -> some View {
        
        var body: some View {
            VStack {
            
                drawTemples()
                   
                .frame(width: currentScreenWidth, height: currentScreenHeight * 0.75, alignment: Alignment.center)
                //.position(x: currentScreenWidth/2, y: currentScreenHeight/2)
                //.background(Color.green)
                // we need this background color for testing purposes
                
                Spacer(minLength: 0)
                
//                if sharedValues.oneTempleInfo.count == 0 {
                if sharedValues.tappedATemple == false {
                    
                    //YearDisplayView(startYear: ImageSpiral.startYear, endYear: ImageSpiral.endYear)
                        //.frame(width: currentScreenWidth, height: currentScreenHeight * 0.1, alignment: Alignment.center)
                        //.background(Color.blue)
                        // we need this background color for testing purposes
                     
                    //Spacer(minLength: 0)

                    SliderView(imageSpiralViewModel: imageSpiralViewModel)
                        .frame(width: currentScreenWidth, height: currentScreenHeight * 0.25, alignment: Alignment.center)
                        //.background(Color.green)
                        // we need this background color for testing purposes
                    
                    
                } else {
                    MileStoneDatesView(imageSpiralViewModel: imageSpiralViewModel)
                        .frame(width: currentScreenWidth, height: currentScreenHeight * 0.25, alignment: Alignment.center)
                        
                }
                
    //                    Rectangle()
    //                        .foregroundColor(Color.gray)
                
            }
        }
        
        return body
}
    
    func LandscapeViewForPhone() -> some View {
        
        var body: some View {
    
            HStack {
                
                
                
                drawTemples()
                    .frame(width: currentScreenWidth / 2 , height: currentScreenHeight, alignment: Alignment.center)
                    //.background(Color.yellow)
                
        

//                if sharedValues.oneTempleInfo.count == 0 {
                if sharedValues.tappedATemple == false {
                    VStack {
                        //YearDisplayView(startYear: ImageSpiral.startYear, endYear: ImageSpiral.endYear)
                            //.frame(width: currentScreenWidth / 2, height: currentScreenHeight / 2, alignment: Alignment.bottom)
                            //.background(Color.green)
                        
                        
                        SliderView(imageSpiralViewModel: imageSpiralViewModel)
                            .frame(width: currentScreenWidth / 2, height: currentScreenHeight / 3, alignment: Alignment.center)
                            //.background(Color.red)
                    }
                } else {
//                    Rectangle()
                    MileStoneDatesView(imageSpiralViewModel: imageSpiralViewModel)
                        .frame(maxHeight: currentScreenHeight * 0.6)
                        //.background(Color.purple)
//                        .onTapGesture {
//                            SwiftUI.withAnimation(sharedValues.hasAnimation ? sharedValues.myAnimation : sharedValues.myNoAnimation) {
//                                sharedValues.oneTempleInfo.removeAll()
//                            }
//
//                        }
                    
//                    Rectangle()
//                        .background(Color.green)
                    
                }
                
//                Rectangle()
//                    .background(Color.green)

                
              
                
            }
            
            
//            HStack {
//
//
//                drawTemples()
//                    .frame(width: currentScreenWidth * 1 / 2 , height: currentScreenHeight, alignment: Alignment.center)
//                    .background(Color.yellow)
//
//                Spacer(minLength: 0)
//
//                if sharedValues.oneTempleInfo.count == 0 {
//                    VStack {
//                        YearDisplayView(startYear: ImageSpiral.startYear, endYear: ImageSpiral.endYear)
//                            .frame(width: currentScreenWidth / 2, height: currentScreenHeight / 2, alignment: Alignment.bottom)
//
//                        Spacer(minLength: 0)
//
//                        SliderView(imageSpiralViewModel: imageSpiralViewModel)
//                            .frame(width: currentScreenWidth / 2, height: currentScreenHeight / 2, alignment: Alignment.center)
//
//                    }
//                } else {
//                    MileStoneDatesView(imageSpiralViewModel: imageSpiralViewModel)
//                        .frame(width: currentScreenWidth / 2, height: currentScreenHeight * 0.6, alignment: Alignment.center)
//                        .background(Color.red)
//
//
//
//                }
//        }
//
            
        }
        
        return body
}
    
    // this is very much like PortraitView
    func LandscapeViewForPad() -> some View {
        
        var body: some View {
            VStack {
            
                drawTemples()
                   
                .frame(width: currentScreenWidth, height: currentScreenHeight * 0.75, alignment: Alignment.center)
                //.position(x: currentScreenWidth/2, y: currentScreenHeight/2)
                //.background(Color.green)
                // we need this background color for testing purposes
                
                Spacer(minLength: 0)
                
//                if sharedValues.oneTempleInfo.count == 0 {
                if sharedValues.tappedATemple == false {
                    
                    
                     
                    

                    SliderView(imageSpiralViewModel: imageSpiralViewModel)
                        .frame(width: currentScreenWidth, height: currentScreenHeight * 0.25, alignment: Alignment.center)
                        //.background(Color.green)
                        // we need this background color for testing purposes
                    
                    //Spacer(minLength: 0)
                    
                    //YearDisplayView(startYear: ImageSpiral.startYear, endYear: ImageSpiral.endYear)
                        //.frame(width: currentScreenWidth, height: currentScreenHeight * 0.1, alignment: Alignment.center)
                        //.background(Color.blue)
                        // we need this background color for testing purposes
                    
                } else {
                    MileStoneDatesView(imageSpiralViewModel: imageSpiralViewModel)
                        .frame(width: currentScreenWidth, height: currentScreenHeight * 0.25, alignment: Alignment.center)
                        
                }
                
    //                    Rectangle()
    //                        .foregroundColor(Color.gray)
                
            }
        }
        
        return body
}
    
    var body: some View {
        
        
        
        return ZStack {
        
//            PortraitView()
            
            if (sharedValues.orientationInText == "portrait"
                    || sharedValues.orientationInText == "unknown")


            {

                PortraitView()

            } else if (sharedValues.orientationInText == "landscape"
                        || sharedValues.orientationInText == "unknown")


            {

                if sharedValues.currentDevice == .phone {
                    LandscapeViewForPhone()
                } else {
                    LandscapeViewForPad()
                    //PortraitView()
                }
                //LandscapeView()

                //LandscapeViewSimilarToPortraitView()
            }
        }
        
                        
        
        
        
        
    }
    
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
