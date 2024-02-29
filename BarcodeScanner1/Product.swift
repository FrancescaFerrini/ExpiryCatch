//
//  Product.swift
//  BarcodeScanner1
//
//  Created by Francesca Ferrini on 23/02/24.
//

import Foundation
import UserNotifications
import SwiftUI

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
                        if result.product != nil {
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
    
    func saveProduct(_ product: SavedFoodModel) {
        scheduleImmediateNotification(for: product)
        scheduleExpirationNotification(for: product)
    }

    func scheduleImmediateNotification(for product: SavedFoodModel) {
        let immediateContent = UNMutableNotificationContent()
        immediateContent.title = "Product Saved"
        immediateContent.body = "\(product.productName ?? "Your product") has been saved."

        let immediateTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let immediateRequest = UNNotificationRequest(identifier: "\(product.id.uuidString)_immediate", content: immediateContent, trigger: immediateTrigger)

        UNUserNotificationCenter.current().add(immediateRequest) { error in
            if let error = error {
                print("Error scheduling immediate notification for \(product.productName ?? "Unknown"): \(error.localizedDescription)")
            } else {
                print("Immediate notification scheduled for \(product.productName ?? "Unknown")")
            }
        }
    }

    func scheduleExpirationNotification(for product: SavedFoodModel) {
        guard let expirationDateString = product.expirationDate else {
            print("Expiration date not available for product: \(product.productName ?? "Unknown")")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        print("try")
        
        if let expirationDate = product.expirationDate {
            print("yrt")
            let expirationContent = UNMutableNotificationContent()
            expirationContent.title = "Product Expiration Reminder"
            expirationContent.body = "\(product.productName ?? "Your product") is expiring tomorrow!"

            let triggerDate = Calendar.current.date(byAdding: .day, value: -1, to: expirationDate)!
            let expirationTrigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day], from: triggerDate), repeats: false)

            let expirationRequest = UNNotificationRequest(identifier: "\(product.id.uuidString)_expiration", content: expirationContent, trigger: expirationTrigger)

            UNUserNotificationCenter.current().add(expirationRequest) { error in
                if let error = error {
                    print("Error scheduling expiration notification for \(product.productName ?? "Unknown"): \(error.localizedDescription)")
                } else {
                    print("Expiration notification scheduled for \(product.productName ?? "Unknown")")
                }
            }
        } else {
            print("Failed to parse expiration date for product: \(product.productName ?? "Unknown")")
        }
    }
}


struct SavedFoodModel: Hashable, Identifiable {
    let id: UUID = UUID()
    let productName: String?
    let imageUrl: URL?
    let nutritionGrades: String?
    let expirationDate: Date?
    
}
