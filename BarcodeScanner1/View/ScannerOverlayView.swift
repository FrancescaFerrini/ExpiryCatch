//
//  ScannerOverlayView.swift
//  BarcodeScanner1
//
//  Created by Francesca Ferrini on 23/02/24.
//
import SwiftUI



struct ScannerOverlayView: View {
    
    @State private var isSecondViewPresented = false
       
    var body: some View {
        NavigationView {
                    VStack {
                        
                        Text("Contenuto principale")
                    }
                    .navigationTitle("Vista Principale")
                    .navigationBarItems(trailing:
                        NavigationLink(destination: TabController()) {
                            Image(systemName: "barcode.viewfinder")
                        }
                    )
                }
        }
}

#Preview {
    ScannerOverlayView()
}
