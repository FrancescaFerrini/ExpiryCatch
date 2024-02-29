//
//  ListView.swift
//  BarcodeScanner1
//
//  Created by Francesca Ferrini on 20/02/24.
//

import SwiftUI
import SwiftData


struct ListView: View {
    @Query var savedBarcode: [SavedFoodModel]
    
    @ObservedObject var savedProduct: SavedFoodViewModel
    
        var body: some View {
            NavigationStack {
                ScrollView {
                    ForEach(savedBarcode, id: \.self) { food in
                        VStack(alignment: .leading) {
                            
                            NavigationLink {
                                ProductDetailView(savedProduct: savedProduct, food: food)
                            } label: {
                                HStack {
                                    AsyncImage(url: food.imageUrl)
                                        .scaledToFill()
                                        .frame(width: 130, height: 130)
                                        .clipped()
                                        .clipShape(UnevenRoundedRectangle(bottomLeadingRadius: 8.43, bottomTrailingRadius: 8.43))
                                        .padding()
                                    
                                    Text(food.productName ?? "Name not found")
                                        
                                        .bold()
                                        .padding()
                                }
                                .padding(.vertical)
                            }
                            .padding()
                            .background(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .foregroundColor(Color.white)
                                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .strokeBorder(Color.gray.opacity(0.1), lineWidth: 2)
                                        .padding(.top, -2)
                                })
                            
                            
                            
                        }
                        
                    }
                }
                
                
            }
    }
}
