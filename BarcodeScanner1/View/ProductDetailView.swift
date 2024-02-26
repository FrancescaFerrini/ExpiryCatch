


import SwiftUI

struct ProductDetailView: View {
   
    @ObservedObject var savedProduct: SavedFoodViewModel
    var food: SavedFoodModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Text(food.productName ?? "")
                    .font(.title)
                    .padding()
                Text("Nutrition grade: \(food.nutritionGrades ?? "nutrition grade not found")")
                Text("Expiration Date: \(food.expirationDate ?? "expiration date not found")")
                
            }  
        }
    }
}


