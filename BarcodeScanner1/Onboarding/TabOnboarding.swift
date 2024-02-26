//
//  TabOnboarding.swift
//  BarcodeScanner1
//
//  Created by Francesca Ferrini on 24/02/24.
//

import Foundation
import SwiftUI


struct TabOnboarding: View {
   
    @State private var selection = 0
    let onboardingSteps = ["Step 1", "Step 2", "Step 3"]
    @State private var showSecondView = false
    @State private var showNavigation = true
    
    var body: some View {
        ZStack {
            Color.color2.ignoresSafeArea()
            VStack {
                TabView(selection: $selection) {
                    Onboarding()
                        .tag(0)
                    Onboarding1()
                        .tag(1)
                    Onboarding2()
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack {
                    ForEach(0..<onboardingSteps.count) { index in
                        if index == selection {
                            Rectangle()
                                .frame(width: 20, height: 10)
                                .cornerRadius(10)
                                .foregroundColor(.color1)
                        } else {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.bottom, 24)
                .opacity(showNavigation && selection < onboardingSteps.count - 1 ? 1.0 : 0.0)
            }
            
            if selection < 2 { // Mostra il pulsante solo se la selezione è inferiore a 2
                Button(action: {
                    showSecondView = true
                    print("Skip!")
                }) {
                    Text("Skip")
                        .foregroundColor(.color1)
                        .font(.system(size: 24))
                        .padding()
                }
                .offset(y: -350) // Sposta il pulsante in alto
                .frame(maxWidth: .infinity, alignment: .trailing) // Allinea il pulsante a destra
            }
        }
        .fullScreenCover(isPresented: $showSecondView) {
            // Visualizza la seconda vista qui
            TabController()
        }
    }
}
