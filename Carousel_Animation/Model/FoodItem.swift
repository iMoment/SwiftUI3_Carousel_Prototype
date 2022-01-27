//
//  FoodItem.swift
//  Carousel_Animation
//
//  Created by Stanley Pan on 2022/01/27.
//

import SwiftUI

// MARK: Sample Data Model
struct FoodItem: Identifiable {
    var id: String = UUID().uuidString
    var itemTitle: String
    var itemImage: String
}

var foodItems = [
    FoodItem(itemTitle: "Yummy & Light Choco Cake ", itemImage: "cake"),
    FoodItem(itemTitle: "Triple Flavor Icecream Delight", itemImage: "icecream"),
    FoodItem(itemTitle: "Tart Blueberry Muffin", itemImage: "muffin")
]
