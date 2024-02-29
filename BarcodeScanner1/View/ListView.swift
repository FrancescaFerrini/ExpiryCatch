//
//  ListView.swift
//  BarcodeScanner1
//
//  Created by Francesca Ferrini on 20/02/24.
//

import SwiftUI
import AVFoundation

struct ModalView: View {
    @Binding var isShowingScanner: Bool
    @Binding var productResponse: ProductResponse?
    @ObservedObject var savedProduct: SavedFoodViewModel
    @State var saved: SavedFoodModel?
    @Binding var scannedCode: String?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            
            Text("Scanned Code: \(scannedCode ?? "not found")")
                .padding()
            productNameView
            Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
                isShowingScanner = true
            }
            .font(.system(size: 20))
            .offset(x: -150,y: -350)
            
            
                    if(productResponse?.product?.productName == nil ) {
                        
                    } else {
                        Button("Add") {
                            saved = SavedFoodModel(productName: productResponse?.product?.productName, imageUrl: productResponse?.product?.image, nutritionGrades: productResponse?.product?.nutritionGrades, expirationDate: productResponse?.product?.expirationDate)
                            savedProduct.savedFoods.append(saved!)
                            savedProduct.saveProduct(saved!)
                            presentationMode.wrappedValue.dismiss()
                            isShowingScanner = true
                        }
                        .font(.system(size: 20))
                        .offset(x: 150, y: -360)
                        
                    }
            ForEach(savedProduct.savedFoods, id: \.self) { food in
                VStack(alignment: .leading) {
                    NavigationLink(destination: ProductDetailView(savedProduct: savedProduct, food: food)) { // Utilizziamo la NavigationLink direttamente qui
                        HStack {
                            AsyncImage(url: food.imageUrl ?? URL(string: "placeholder")
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
        .onAppear {
            fetchProductDataIfNeeded()
        }
    }
        private var productNameView: some View {
            if let productName = productResponse?.product?.productName {
                return Text("Product Name: \(productName)")
            } else {
                return Text("Product Name: Unknown")
            }
        }
        private func fetchProductDataIfNeeded() {
            guard scannedCode != nil else { return }
            guard let scannedCode = scannedCode else {
                return
            }
            let apiUrl = "https://world.openfoodfacts.net/api/v2/product/\(scannedCode).json"
            if let url = URL(string: apiUrl) {
                let session = URLSession.shared
                let task = session.dataTask(with: url) { data, response, error in
                    DispatchQueue.main.async {
                        do {
                            let decoder = JSONDecoder()
                                                        let result = try decoder.decode(ProductResponse.self, from: data!)
                                                        
                                                        productResponse = result
                                                    } catch {
                                                        
                                                    }
                                                    
                                                    
                                                }
                                            }
                                            
                                            task.resume()
                                        } else {
                                            print("ERRORRRR")
                                        }
                                    }
                            }
