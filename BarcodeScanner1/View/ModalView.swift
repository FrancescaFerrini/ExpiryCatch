import SwiftUI
import AVFoundation
struct ModalView: View {
    
    @Binding var isShowingScanner: Bool
    @Binding var productResponse: ProductResponse?
    @ObservedObject var savedProduct: SavedFoodViewModel
    @State var saved: SavedFoodModel?
    @Binding var scannedCode: String?
    @Environment(\.presentationMode) var presentationMode
    @State private var date = Date()
    @State private var showAlert = false
    @State private var isDateSelected = false
    
    var body: some View {
        VStack {
            Text("Scanned Code: \(scannedCode ?? "not found")")
                .padding()
                    productNameView
                    if(productResponse?.product?.productName == nil ) {
                        
                    } else {
                        DatePicker(
                               "Select expiration date: ",
                               selection: $date,
                               displayedComponents: [.date]
                           )
                        .datePickerStyle(.compact)
                        .padding()
                        
                        Button("Save Product") {
                            if isDateSelected {
                                saved = SavedFoodModel(productName: productResponse?.product?.productName, imageUrl: productResponse?.product?.image, nutritionGrades: productResponse?.product?.nutritionGrades, expirationDate: date)
                                savedProduct.savedFoods.append(saved!)
                                savedProduct.saveProduct(saved!)
                                presentationMode.wrappedValue.dismiss()
                                isShowingScanner = true
                            } else {
                                showAlert = true
                            }
                          
                        }
                        .font(.headline)
                        .alert(isPresented: $showAlert) {
                                  Alert(title: Text("Alert"), message: Text("Please select an expiration date."), dismissButton: .default(Text("OK")))
                              }
                        .padding()
                    }
            Spacer()
            Button("Press to dismiss") {
                presentationMode.wrappedValue.dismiss()
                isShowingScanner = true
            }
            
            .padding()
           
        }
        .padding()
        .onAppear {
            fetchProductDataIfNeeded()
        }
        .onChange(of: date) {
                   isDateSelected = true
               }
    }
        private var productNameView: some View {
            if let productName = productResponse?.product?.productName {
                return Text("Product Name: \(productName)")
            } else {
                return Text("Product Name: Unknown, please try again")
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
