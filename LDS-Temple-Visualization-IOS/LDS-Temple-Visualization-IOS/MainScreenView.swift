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

public var currentScreenWidthPublic: CGFloat = 0
public var currentScreenHeighPublic: CGFloat = 0
public var orientationInTextPublic: String = " "


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
            currentScreenWidthPublic = sharedValues.currentScreenWidth
            currentScreenHeighPublic = sharedValues.currentScreenHeight
            orientationInTextPublic = sharedValues.orientationInText
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
    
    var animationGoingOn: Bool {
        get {
            return sharedValues.animationInProgress
        }
    }
    
    
    struct AnimatableModifierHere: AnimatableModifier {

        var targetValue: CGFloat

        // SwiftUI gradually varies it from old value to the new value
        var animatableData: CGFloat {
            didSet {
                checkIfFinished()
            }
        }

        var completion: () -> ()

        // Re-created every time the control argument changes
        init(bindedValue: CGFloat, completion: @escaping () -> ()) {
            self.completion = completion

            // Set animatableData to the new value. But SwiftUI again directly
            // and gradually varies the value while the body
            // is being called to animate. Following line serves the purpose of
            // associating the extenal argument with the animatableData.
            self.animatableData = bindedValue
            targetValue = bindedValue
        }

        func checkIfFinished() -> () {
            //print("Current value: \(animatableData)")
            if (animatableData == targetValue) {
                //if animatableData.isEqual(to: targetValue) {
                DispatchQueue.main.async {
                    self.completion()
                }
            }
        }

        // Called after each gradual change in animatableData to allow the
        // modifier to animate
        func body(content: Content) -> some View {
            // content is the view on which .modifier is applied
            content
            // We don't want the system also to
            // implicitly animate default system animatons it each time we set it. It will also cancel
            // out other implicit animations now present on the content.
                .animation(nil)
        }
    }

//    var animationProgress: Double = 0
//
//    var animatableData: Double {
//            get {
//                print("animation progress is \(animationProgress)")
//                return animationProgress
//
//            }
//            set {
//                print("animation progress is \(animationProgress)")
//                animationProgress = newValue
//
//            }
//        }
    
    func drawOneTemple(temple: Spiral<Image>.Temple) -> some View {
        var body: some View {
            
            ZStack {
                
            
                temple.content
                .resizable()
                .frame(width: temple.size, height: temple.size, alignment: Alignment.center)
                .position(x: temple.x, y: temple.y)
                //.position(x: temple.x, y: (sharedValues.orientationInText == "portrait" || sharedValues.orientationInText == "unknown" ? (temple.size > currentScreenWidth * 0.25 ? temple.y : temple.y) : (temple.size > currentScreenHeight * 0.2 ? temple.y : temple.y) ))
                .animation(sharedValues.hasAnimation ? sharedValues.mySlowAnimation : sharedValues.myFastAnimation)
                //.modifier(AnimatableModifierHere(bindedValue: sharedValues.sliderProgress) {})
                    .modifier(AnimatableModifierHere(bindedValue: sharedValues.sliderProgress) {

                        if sharedValues.animationInProgress {
                            print("animation finished")
                            sharedValues.animationInProgress = false
                        }

                        //print("sharedValues.animationInProgress is \(sharedValues.animationInProgress) ")

                    })
                    
                    
                .onTapGesture {
                    print("tapped a temple")
                    
                    print("showName is \(temple.showName)")
                    
                    imageSpiralViewModel.changeATemple(id: temple.id)
                    //print("tapped temple Link is \(temple.link)")
                    if (temple.tapped == true) {
                        SwiftUI.withAnimation(sharedValues.hasAnimation ? sharedValues.mySlowAnimation : sharedValues.myFastAnimation) {
                            sharedValues.tappedATemple = false
                            sharedValues.singleTempleShow = false
                            print("tap a large temple")
                        }
                    } else {
                        SwiftUI.withAnimation(sharedValues.hasAnimation ? sharedValues.mySlowAnimation : sharedValues.myFastAnimation) {
                            sharedValues.oneTempleInfo = imageSpiralViewModel.readOneTempleInfoFromFile(fileName: temple.fileName)
                            sharedValues.tappedATemple = true
                            sharedValues.singleTempleShow = true
                            print("tap a small temple")
                        }
                        sharedValues.currentTappedTempleName = temple.name
                        sharedValues.currentTappedTempleId = temple.id
                        sharedValues.currentTappedTempleLink = temple.link
                    }
                    print("tapped temple's size is \(temple.size)")
                }
                
                
                //if temple.showName {
                    //HStack {
                        
                    //}
                //}
                
               
                
                
                
                
                
           
         
         
                
            }
        }
        
        return body
    }
    
//    func drawOneTempleName(temple: Spiral<Image>.Temple) -> some View {
//        var body: some View {
//            ZStack {
//                if temple.showName && sharedValues.animationInProgress == false {
//                    Text(temple.name)
//                        .position(x: temple.x, y: temple.y + temple.size / 2 + 5)
//                        .font(.system(size: 10))
//                        .animation(sharedValues.hasAnimation ? sharedValues.myAnimation : sharedValues.myNoAnimation)
//
//                }
//            }
//
//
//        }
//
//        return body
//    }
    
    func showNameLabelCondition(temple: Spiral<Image>.Temple) -> Bool {
        temple.showName && sharedValues.animationInProgress == false && sharedValues.showLabel && sharedValues.tappedATemple == false
    }
    
    func showNameLabelContent(temple: Spiral<Image>.Temple) -> String {
        temple.link == "no link" ? "" : temple.name
            
    }
    
    func drawTemples() -> some View {
        
       
        //print("app launchs here screen width and height \(UIScreen.main.bounds.size.width) \(UIScreen.main.bounds.size.height)")
        
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
                ForEach(imageSpiralViewModel.onScreenTemples) { temple in
                    
                    drawOneTemple(temple: temple)
                        
                    // this line shows us how the spiral looks like on screen
                    //spiralDrawing().stroke()
                    //drawOneTempleName(temple: temple)
                    if showNameLabelCondition(temple: temple) {
                        
                        // handle the last few temples, where their images is just with their names on it,
                        // we dont what to show the names, so we just used name as " "
//                        if link == "no link" {
//                            name = " "
//                        }
                        Text(showNameLabelContent(temple: temple))
                            .position(x: temple.x, y: temple.y + temple.size / 2 + 5)
                            .font(.system(size: 10))
                    }
                }
                
//                ForEach(imageSpiralViewModel.onScreenTemples) { temple in
//                    if temple.showName && sharedValues.animationInProgress == false {
//
//                        // handle the last few temples, where their images is just with their names on it,
//                        // we dont what to show the names, so we just used name as " "
////                        if link == "no link" {
////                            name = " "
////                        }
//                        Text(temple.link == "no link" ? "" : temple.name)
//                            .position(x: temple.x, y: temple.y + temple.size / 2 + 5)
//                            .font(.system(size: 10))
//                    }
//                }
                //.animation(sharedValues.hasAnimation ? sharedValues.myAnimation : sharedValues.myNoAnimation)
                
                 
//                // display temple names on larger temples
//                ForEach(imageSpiralViewModel.onScreenTemples) { temple in
//                    Text(
//                        //(sharedValues.orientationInText == "portrait" || sharedValues.orientationInText == "unknown" ? (temple.size > currentScreenWidth * 0.2 ? temple.location : "") : (temple.size > currentScreenHeight * 0.15 ? temple.location : ""))
//
//                    (sharedValues.animationInProgress ? " " :
//                        (sharedValues.orientationInText == "portrait" || sharedValues.orientationInText == "unknown" ?
//                        (temple.size > currentScreenWidth * 0.2 ? temple.location : "") :
//                        (temple.size > currentScreenHeight * 0.15 ? temple.location : ""))
//                    )
//                    )
//
//                        //.frame(width: temple.size, height: temple.size / 2, alignment: Alignment.center)
//                        .position(x: temple.x, y: temple.y + temple.size / 2 + 5)
//                        .font(.system(size: 10))
//                    //.animation(sharedValues.hasAnimation ? sharedValues.myAnimation : sharedValues.myNoAnimation)
////                    .modifier(AnimatableModifierHere(bindedValue: sharedValues.sliderProgress) {
////
////                        if sharedValues.animationInProgress {
////                            print("animation finished")
////                            sharedValues.animationInProgress = false
////                        }
////
////                        //print("sharedValues.animationInProgress is \(sharedValues.animationInProgress) ")
////
////                                    })
//
//
//
//                }
                
            }
            .animation(sharedValues.hasAnimation ? sharedValues.mySlowAnimation : sharedValues.myFastAnimation)
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
                    GeometryReader { geometry in
                        VStack {
                            //YearDisplayView(startYear: ImageSpiral.startYear, endYear: ImageSpiral.endYear)
                                //.frame(width: currentScreenWidth / 2, height: currentScreenHeight / 2, alignment: Alignment.bottom)
                                //.background(Color.green)
                            
                            
                            SliderView(imageSpiralViewModel: imageSpiralViewModel)
                                .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.3, alignment: Alignment.center)
                                //.background(Color.red)
                                //.frame(maxWidth: currentScreenWidth * 0.5, maxHeight: currentScreenHeight * 0.6)
                                .position(x: geometry.size.width / 2, y: geometry.size.height * 0.6)
                        }
                    
                    }
                            
                    
                } else {
//                    Rectangle()
                    MileStoneDatesView(imageSpiralViewModel: imageSpiralViewModel)
                        .frame(maxHeight: currentScreenHeight * 0.5)
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
            
            // when app lauch, orientation is alway unknown, weird, at least with my phone. it's like this
//            if sharedValues.orientationInText == "unknown" {
//
//                if UIScreen.main.bounds.size.width < UIScreen.main.bounds.size.height {
//                    PortraitView()
//                } else {
//                    if sharedValues.currentDevice == .phone {
//                        LandscapeViewForPhone()
//                    } else {
//                        LandscapeViewForPad()
//                        //PortraitView()
//                    }
//                }
//
//                //Text("orientationInText when launch is \(sharedValues.orientationInText) why is it unknow? ")
//
//            } else {
                if (sharedValues.orientationInText == "portrait"
                        || sharedValues.orientationInText == "unknown"
                )


                {

                    PortraitView()

                } else if (sharedValues.orientationInText == "landscape"
                        || sharedValues.orientationInText == "unknown"
                )


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
//            }
            
            
        }
        
                        
        
        
        
        
    }
    
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
