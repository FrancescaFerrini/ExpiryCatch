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
            Text("Scanned Code:")
            Text("Scanned Code: \(scannedCode ?? "not found")")
                .padding()
            productNameView
            Button("Press to dismiss") {
                presentationMode.wrappedValue.dismiss()
                isShowingScanner = true
            }
            .font(.title)
            .padding()
            .background(Color.black)
            
                    if(productResponse?.product?.productName == nil ) {
                        
                    } else {
                        Button("Save") {
                            saved = SavedFoodModel(productName: productResponse?.product?.productName, imageUrl: productResponse?.product?.image, nutritionGrades: productResponse?.product?.nutritionGrades, expirationDate: productResponse?.product?.expirationDate)
                            savedProduct.savedFoods.append(saved!)
                            presentationMode.wrappedValue.dismiss()
                            isShowingScanner = true
                        }
                        .padding()
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
