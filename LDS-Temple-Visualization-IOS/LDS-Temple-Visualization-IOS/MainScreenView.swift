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

struct MainScreenView: View {
    
    var body: some View {
        ZStack {
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

    // we make this observed object,
    // along with its published spiral model in its class,
    // this view will update when changes happen to the model 
    @ObservedObject var imageSpiralViewModel: ImageSpiral = ImageSpiral()

    @EnvironmentObject var sharedValues: SharedValues
    
    // we use computed value, we do this so that we can use sharefValues above
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

    
    // this struct is to check if animation ends
    // this is from online, so i still have questions about the logics in here...
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
            //print("checkIfFinished in animatable modifier called")
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
    
    
    
    // this function takes in on temple and draw it at a spicific location with a spicific size
    // animation, animation modifier(check if animation ends) and tap action are also implemented here
    func drawOneTempleWithAnimation(temple: Spiral<Image>.Temple) -> some View {
        var body: some View {
            ZStack {
                temple.content
                    .resizable()
                    .frame(width: temple.size, height: temple.size, alignment: Alignment.center)
                    .position(x: temple.x, y: temple.y)
                    .animation(sharedValues.animationOption == "slow" ? sharedValues.mySlowAnimation : sharedValues.myFastAnimation)
//                    .modifier(AnimatableModifierHere(bindedValue: sharedValues.sliderProgress) {
//                        if sharedValues.animationInProgress {
//                            print("animation finished")
//                            sharedValues.animationInProgress = false
//                        }
//                        //print("sharedValues.animationInProgress is \(sharedValues.animationInProgress) ")
//                        print("animatable modifier is called")
//                    })
                    .onTapGesture {
                        print("tapped a temple")
                        //print("showName is \(temple.showName)")
                        
                        // when tapped, we need to change the tapped temple size and location,
                        // we tapped again, we need to change it back
                        // how to detect we are tapping it in spiral view or single view? logic is in the method
                        imageSpiralViewModel.changeATemple(id: temple.id)
                        //print("tapped temple Link is \(temple.link)")
                        if (temple.tapped == true) {
                            SwiftUI.withAnimation(sharedValues.animationOption == "slow" ? sharedValues.mySlowAnimation : sharedValues.myFastAnimation) {
                                sharedValues.tappedATemple = false
                                sharedValues.singleTempleShow = false
                                print("tap a large temple")
                            }
                        } else {
                            SwiftUI.withAnimation(sharedValues.animationOption == "slow" ? sharedValues.mySlowAnimation : sharedValues.myFastAnimation) {
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
            }
        }
        return body
    }
    
    func drawOneTempleWithoutAnimation(temple: Spiral<Image>.Temple) -> some View {
        var body: some View {
            ZStack {
                temple.content
                    .resizable()
                    .frame(width: temple.size, height: temple.size, alignment: Alignment.center)
                    .position(x: temple.x, y: temple.y)
                    .animation(.none)
                    .onTapGesture {
                        print("tapped a temple")
                        imageSpiralViewModel.changeATemple(id: temple.id)
                        if (temple.tapped == true) {
                            SwiftUI.withAnimation(sharedValues.animationOption == "slow" ? sharedValues.mySlowAnimation : sharedValues.myFastAnimation) {
                                sharedValues.tappedATemple = false
                                sharedValues.singleTempleShow = false
                                print("tap a large temple")
                            }
                        } else {
                            SwiftUI.withAnimation(sharedValues.animationOption == "slow" ? sharedValues.mySlowAnimation : sharedValues.myFastAnimation) {
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
            }
        }
        return body
    }
    
    
    // we used functions to return a value then use it later to avoid the expressing to be too long. expressing is too long will cause can't type check in reasonable amount of time error
    
    func showNameLabelCondition(temple: Spiral<Image>.Temple) -> Bool {
        temple.showName && sharedValues.animationInProgress == false && sharedValues.showLabel && sharedValues.tappedATemple == false
    }
    
    func showNameLabelContent(temple: Spiral<Image>.Temple) -> String {
        // handle the last few temples, where their images is just with their names on it,
        // we dont what to show the names, so we just used name as " "
        temple.link == "no link" ? "" : temple.location
            
    }
    
    func showNameLabel(temple: Spiral<Image>.Temple) -> some View {
        Text(showNameLabelContent(temple: temple))
            .position(x: temple.x, y: temple.y + temple.size / 2 + 5)
            .font(.system(size: 10))
    }
    
    func drawTemples() -> some View {
        
        //print("app launchs here screen width and height \(UIScreen.main.bounds.size.width) \(UIScreen.main.bounds.size.height)")
        
        if sharedValues.orientationChanged == true {
            
            // we need this to keep the single temple view show after orientation changed.
            // we do this, we resume single temple view temple attributes into spiral view
            // then we do this again
            if sharedValues.singleTempleShow {
                imageSpiralViewModel.changeATemple(id: sharedValues.currentTappedTempleId)
            }
            
            // when orientation changed, we need to relocate spiral with current center x and y and sizes
            imageSpiralViewModel.updateOnScreenTemples(newTheta: sharedValues.sliderProgress)
            sharedValues.orientationChanged = false
            print("relocate spiral")
            
            // we do this above code again, after we relocate spiral, we bring up single temple view again by changeing the same temples attributes, such as x y and size
            if sharedValues.singleTempleShow {
                imageSpiralViewModel.changeATemple(id: sharedValues.currentTappedTempleId)
            }
            
            print("changed a temple")
        }
        
        var body: some View {
            ZStack {
                ForEach(imageSpiralViewModel.onScreenTemples) { temple in
                    if sharedValues.animationOption == "off" {
                        drawOneTempleWithoutAnimation(temple: temple)
                    } else {
                        drawOneTempleWithAnimation(temple: temple)
                    }
                    
                    
                    // we need to write a spiralDrawing method to used this comments with the coordinates, this method will just draw spiral on screen, for testing purposes. not it's not working. keep it here just in case we need to see how spiral looks
                    // this line shows us how the spiral looks like on screen
                    //spiralDrawing().stroke()
                    //drawOneTempleName(temple: temple)
                    if showNameLabelCondition(temple: temple) {
                        showNameLabel(temple: temple)
                        
                    }
                    
                }
            }
            // we do animation here so that label show and disappear is animiated, cant do it on Text within if (i dont know why)
            // we still need to animation in drawonetemple method.
            .animation(sharedValues.animationOption == "slow" ? sharedValues.mySlowAnimation : sharedValues.myFastAnimation)
            .modifier(AnimatableModifierHere(bindedValue: sharedValues.sliderProgress) {
                //(bindedValue: ((sharedValues.sliderProgress == sharedValues.lastSliderProgress && sharedValues.animationInProgress) ? sharedValues.sliderProgress : 0))
                
//                print("sharedValues.sliderProgress is \(sharedValues.sliderProgress)")
//                print("sharedValues.lastSliderProgress is \(sharedValues.lastSliderProgress)")
//                print("sharedValues.animationInProgress is \(sharedValues.animationInProgress)")
                
                //print("sharedValues.bindedValueForAnimatableModifier is \(sharedValues.bindedValueForAnimatableModifier)")
                
                print("animatable modifier is called")
                
                if sharedValues.animationInProgress {
                    print("animation finished")
                    sharedValues.animationInProgress = false
                }
                //print("sharedValues.animationInProgress is \(sharedValues.animationInProgress) ")
                
            })
        }
        return body
    }
    
    func PortraitView() -> some View {
        
        var body: some View {
            VStack {
                drawTemples()
                .frame(width: currentScreenWidth, height: currentScreenHeight * 0.75, alignment: Alignment.center)
                
                Spacer(minLength: 0)
                
                // we show mile stone dates once a temple is tapped,
                if sharedValues.tappedATemple == false {
                    
                    SliderView(imageSpiralViewModel: imageSpiralViewModel)
                        .frame(width: currentScreenWidth, height: currentScreenHeight * 0.25, alignment: Alignment.center)
                        //.background(Color.green)
                        // leave this this background color comment here for testing purposes
      
                } else {
                    MileStoneDatesView(imageSpiralViewModel: imageSpiralViewModel)
                        .frame(width: currentScreenWidth, height: currentScreenHeight * 0.25, alignment: Alignment.center)
                }
                // if we put back ground color for spiral, we might need this to fill up the bottom,
                // no need this if we don't set any custome color, just use the default light and dart mode of ios
//                Rectangle()
//                    .foregroundColor(Color.gray)
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
                
                if sharedValues.tappedATemple == false {
                    GeometryReader { geometry in
                        VStack {
                            // be aware force slider size was causing me a HUGE bug. that's why we used geometry reader here
                            SliderView(imageSpiralViewModel: imageSpiralViewModel)
                                .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.3, alignment: Alignment.center)
                                //.background(Color.red)
                                .position(x: geometry.size.width / 2, y: geometry.size.height * 0.6)
                        }
                    }
                } else {
                    MileStoneDatesView(imageSpiralViewModel: imageSpiralViewModel)
                        .frame(maxHeight: currentScreenHeight * 0.5)
                        //.background(Color.purple)
                }
            }
        }
        return body
}
    
    // this is very much like PortraitView
    func LandscapeViewForPad() -> some View {
        
        var body: some View {
            VStack {
                
                drawTemples()
                .frame(width: currentScreenWidth, height: currentScreenHeight * 0.75, alignment: Alignment.center)

                Spacer(minLength: 0)
                
                if sharedValues.tappedATemple == false {
                    
                    SliderView(imageSpiralViewModel: imageSpiralViewModel)
                        .frame(width: currentScreenWidth, height: currentScreenHeight * 0.25, alignment: Alignment.center)
                        //.background(Color.green)
                        // leave this this background color comment here for testing purposes
                } else {
                    
                    MileStoneDatesView(imageSpiralViewModel: imageSpiralViewModel)
                        .frame(width: currentScreenWidth, height: currentScreenHeight * 0.25, alignment: Alignment.center)
                }
            }
        }
        
        return body
}
    
    var body: some View {
        return ZStack {
            
            // we are checking for unknow here, every time app launches, orientation is unknow,
            // here is a possible bug, don't know how to solve yet
            // even user launch app in landscape mode, portrait view will still show...
            if (sharedValues.orientationInText == "portrait" || sharedValues.orientationInText == "unknown") {
                PortraitView()
            } else if (sharedValues.orientationInText == "landscape" || sharedValues.orientationInText == "unknown") {
                if sharedValues.currentDevice == .phone {
                    LandscapeViewForPhone()
                } else {
                    LandscapeViewForPad()
                    //PortraitView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
