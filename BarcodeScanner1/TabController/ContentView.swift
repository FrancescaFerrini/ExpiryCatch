//
//  ContentView.swift
//  BarcodeScanner1
//
//  Created by Fernando Sensenhauser on 27/02/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("hasViewedOnboarding") private var hasViewedOnboarding = false
       
       var body: some View {
           if hasViewedOnboarding {
               // Mostra la tua vista principale qui
               ScannerOverlayView()
           } else {
               //onboarding
               TabOnboarding()
                   .onDisappear {
                       //hasViewedOnboarding su true quando l'onboarding scompare
                       hasViewedOnboarding = true
                   }
           }
       }
}

#Preview {
    ContentView()
}
