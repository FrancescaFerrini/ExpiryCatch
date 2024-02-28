//
//  Product.swift
//  BarcodeScanner1
//
//  Created by Francesca Ferrini on 23/02/24.
//

import Foundation
import SwiftData

struct Product: Codable {
    let productName: String?
    let nutriments: Nutriments?
    let nutriscoreData: NutriscoreData?
    let nutritionGrades: String?
    let image: URL?
    let expirationDate: String?
    
    private enum CodingKeys: String, CodingKey {
        case productName = "product_name"
        case nutriments
        case nutriscoreData = "nutriscore_data"
        case nutritionGrades = "nutrition_grades"
        case image = "image_url"
        case expirationDate = "expiration_date"
    }
}


struct ProductResponse: Codable {
    let code: String
    let product: Product?
    let status: Int
    let statusVerbose: String
    
    private enum CodingKeys: String, CodingKey {
        case code, product, status
        case statusVerbose = "status_verbose"
    }
}


struct Nutriments: Codable {
    let carbohydrates: Double?
    let sugars: Double?
    let energy: Int?
    let energyKcal: Int?
    
    private enum CodingKeys: String, CodingKey {
        case carbohydrates, sugars, energy
        case energyKcal = "energy-kcal"
    }
}

struct NutriscoreData: Codable {
    let energyPoints: Int?
    let sugarsPoints: Int?
    let saturatedFatPoints: Int?
    let sodiumPoints: Int?
    let fiberPoints: Int?
    let proteinsPoints: Int?
    let fruitsVegetablesNutsPoints: Int?
    let score: Int?
    let grade: String?
    
    private enum CodingKeys: String, CodingKey {
        case energyPoints = "energy_points"
        case sugarsPoints = "sugars_points"
        case saturatedFatPoints = "saturated_fat_points"
        case sodiumPoints = "sodium_points"
        case fiberPoints = "fiber_points"
        case proteinsPoints = "proteins_points"
        case fruitsVegetablesNutsPoints = "fruits_vegetables_nuts_points"
        case score, grade
    }
}


class SavedFoodViewModel: ObservableObject, Identifiable{
    @Published var savedFoods: [SavedFoodModel] = []
    @Published var productResponse: ProductResponse?
    
    init() {
        
    }
    func fetchProductData(for code: String) {
        print("AAAAAAAAAAA")
        let apiUrl = "https://world.openfoodfacts.net/api/v2/product/\(code).json"
        
        if let url = URL(string: apiUrl) {
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Error: \(error)")
                        return
                    }
                    
                    guard let data = data else {
                        print("No data returned from API")
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(ProductResponse.self, from: data)
                        
                        // Check if product exists before updating
                        if let product = result.product {
                            self.productResponse = result
                        } else {
                            print("Product not found")
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }
            
            task.resume()
        } else {
            print("Invalid API URL")
        }
    }
}

@Model
class SavedFoodModel: Hashable, Identifiable {
    var id: UUID = UUID()
    var productName: String?
    var imageUrl: URL?
//    let nutritionGrades: String?
    var expirationDate: String?
    
    init(productName: String? = nil, imageUrl: URL? = nil, expirationDate: String? = nil) {
        self.productName = productName
        self.imageUrl = imageUrl
        self.expirationDate = expirationDate
    }
    
}



