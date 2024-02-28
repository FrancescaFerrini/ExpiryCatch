import SwiftUI
import AVFoundation
import SwiftData

struct ModalView: View {
    @Binding var isShowingScanner: Bool
    @Binding var productResponse: ProductResponse?
    @ObservedObject var savedProduct: SavedFoodViewModel
    @State var saved: SavedFoodModel?
    @Binding var scannedCode: String?
    @Environment(\.presentationMode) var presentationMode
    @Environment (\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
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
                
                Button(action: save, label: {
                    Text("Save")
                })
                .task {
                    fetchProductDataIfNeeded()
                }
            }
                
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
    
    func save() {
        saved = SavedFoodModel(productName: productResponse?.product?.productName, imageUrl: productResponse?.product?.image, expirationDate: productResponse?.product?.expirationDate)
        
        
        
        if let savedFood = saved {
            savedProduct.savedFoods.append(savedFood)
            context.insert(savedFood)
        }
        presentationMode.wrappedValue.dismiss()
        isShowingScanner = true
    }
}
#Preview {
    ModalView(isShowingScanner: .constant(true), productResponse: .constant(nil), savedProduct: SavedFoodViewModel(), scannedCode: .constant("Ciao sono Luca"))
        .modelContainer(for: [SavedFoodModel.self])
}


