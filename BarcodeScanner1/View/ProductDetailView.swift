//
//  ProductDetailView.swift
//  BarcodeScanner1
//
//  Created by Salvatore Flauto on 26/02/24.
//


import SwiftUI

struct ProductDetailView: View {
   
    @ObservedObject var savedProduct: SavedFoodViewModel
    var food: SavedFoodModel
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Text(food.productName ?? "")
                    .font(.title)
                    .padding()
                Text("Nutrition grade: \(food.nutritionGrades ?? "nutrition grade not found")")
                if let expirationDate = food.expirationDate {
                                   Text("Expiration date: \(dateFormatter.string(from: expirationDate))")
                               } else {
                                   Text("Expiration date not available")
                               }
                
            }
        }
    }
}
