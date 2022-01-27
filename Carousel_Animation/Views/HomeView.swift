//
//  HomeView.swift
//  Carousel_Animation
//
//  Created by Stanley Pan on 2022/01/27.
//

import SwiftUI

struct HomeView: View {
    @State var currentIndex: Int = 0
    
    // Animation Properties
    @State var backgroundOffset: CGFloat = 0
    @State var textColor: Color = Color.white
    
    var body: some View {
        VStack {
            
            Text(foodItems[currentIndex].itemTitle)
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 100, alignment: .top)
                .padding(.top)
            
            // MARK: FoodItem Details with Image
            HStack(spacing: 10) {
                
                VStack(alignment: .leading, spacing: 25) {
                    
                    Label {
                        Text("1 Hour")
                    } icon: {
                        Image(systemName: "flame")
                            .frame(width: 30)
                    }
                    
                    Label {
                        Text("40")
                    } icon: {
                        Image(systemName: "bookmark")
                            .frame(width: 30)
                    }
                    
                    Label {
                        Text("Easy")
                    } icon: {
                        Image(systemName: "bolt")
                            .frame(width: 30)
                    }
                    
                    Label {
                        Text("Safety")
                    } icon: {
                        Image(systemName: "safari")
                            .frame(width: 30)
                    }
                    
                    Label {
                        Text("Healthy")
                    } icon: {
                        Image(systemName: "drop")
                            .frame(width: 30)
                    }
                }
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // MARK: Food Image
                GeometryReader { proxy in
                    let size = proxy.size
                    
                    Image(foodItems[currentIndex].itemImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                    // MARK: Circle Semi Border
                        .background(
                            Circle()
                                .trim(from: 0.5, to: 1)
                                .stroke(
                                    LinearGradient(
                                        colors: [textColor, textColor.opacity(0.1), textColor.opacity(0.1)],
                                        startPoint: .top,
                                        endPoint: .bottom)
                                    , lineWidth: 0.7
                                )
                                .padding(-15)
                                .rotationEffect(.init(degrees: -90))
                        )
                        .frame(width: size.width, height: size.width * (isSmallDevice() ? 1.5 : 1.8))
                        .frame(maxHeight: .infinity, alignment: .center)
                        .offset(x: 70)
                }
                .frame(height: (getScreenSize().width / 2) * (isSmallDevice() ? 1.6 : 2))
            }
            
            // MARK: Food Description
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                .font(.callout)
                .foregroundStyle(.secondary)
                .lineSpacing(8)
                .lineLimit(3)
                .padding(.vertical)
            
        }
        .padding()
        .foregroundColor(textColor)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            GeometryReader { proxy in
                let height = proxy.size.height
                
                LazyVStack(spacing: 0) {
                    
                    ForEach(foodItems.indices, id: \.self) { index in
                        if index % 2 == 0 {
                            Color("background")
                                .frame(height: height)
                        } else {
                            Color.white
                                .frame(height: height)
                        }
                    }
                }
                .offset(y: backgroundOffset)
            }
            .ignoresSafeArea()
        )
        .gesture(
            DragGesture()
                .onEnded({ value in
                    let translation = value.translation.height
                    
                    if translation < 0 && -translation > 50 {
                        // MARK: Swiped Up
                        withAnimation(.easeIn(duration: 0.6)) {
                            backgroundOffset += -getScreenSize().height
                        }
                        // Text Color Change
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            // Update index
                            currentIndex += 1
                            
                            withAnimation(.easeInOut) {
                                textColor = (textColor == Color.black ? Color.white : Color.black)
                            }
                        }
                    }
                    
                    if translation > 0 && translation > 50 {
                        // MARK: Swiped Down
                        withAnimation(.easeIn(duration: 0.6)) {
                            backgroundOffset += getScreenSize().height
                        }
                        
                        // Text Color Change
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            // Update index
                            currentIndex -= 1
                            
                            withAnimation(.easeInOut) {
                                textColor = (textColor == Color.black ? Color.white : Color.black)
                            }
                        }
                    }
                })
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension View {
    func getScreenSize() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func isSmallDevice() -> Bool {
        if getScreenSize().height < 750 {
            return true
        } else {
            return false
        }
    }
}
