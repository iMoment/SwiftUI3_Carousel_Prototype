//
//  HomeView.swift
//  Carousel_Animation
//
//  Created by Stanley Pan on 2022/01/27.
//

import SwiftUI

struct HomeView: View {
    @State var currentIndex: Int = 0
    
    var body: some View {
        VStack {
            Text(foodItems[currentIndex].itemTitle)
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 100, alignment: .top)
                .padding(.top)
            
            // MARK: FoodItem Details with Image
            FoodItemDetail(currentIndex: self.currentIndex)
            
        }
        .padding()
        .foregroundColor(Color.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("background"))
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
}

struct FoodItemDetail: View {
    var currentIndex: Int
    
    var body: some View {
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
                            .stroke(
                                LinearGradient(
                                    colors: [Color.white, Color.white.opacity(0.1), Color.white.opacity(0.1)],
                                    startPoint: .top,
                                    endPoint: .bottom)
                                , lineWidth: 0.7
                            )
                            .padding(-15)
                            .rotationEffect(.init(degrees: -90))
                    )
                    .frame(width: size.width, height: size.width * 1.8)
                    .frame(maxHeight: .infinity, alignment: .center)
                    .offset(x: 70)
            }
            .frame(height: (getScreenSize().width / 2) * 2)
        }
    }
}
