//
//  Onboarding2.swift
//  BarcodeScanner1
//
//  Created by Francesca Ferrini on 24/02/24.
//

import SwiftUI
struct Onboarding2: View {
    @State private var step = 0
    let onboardingSteps = ["Step 1", "Step 2", "Step 3"]
    let stepColors: [Color] = [.colorM1, .colorM2, .colorM3]
    @State private var showNavigation = true
    @State private var showSecondView = false
    
    var body: some View {
        ZStack{
            VStack {
                TabView(selection: $step) {
                    ChosenMood()
                        .tag(0)
                    ChosenMood1()
                        .tag(1)
                    ChosenMood2()
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack(spacing: 20) {
                    ForEach(0..<onboardingSteps.count) { index in
                        Rectangle()
                            .frame(width: self.rectWidth(forIndex: index), height: self.rectHeight(forIndex: index))
                            .cornerRadius(10)
                            .foregroundColor(self.stepColors[index])
                            .onTapGesture {
                                self.step = index
                            }
                    }
                }
                .padding(.bottom, 100)
            }
            if step < 3 { // Mostra il pulsante solo se la selezione è inferiore a 2
                Button(action: {
                    showSecondView = true
                    print("Continue")
                }) {
                    Text("Continue >")
                        .foregroundColor(.color1)
                        .font(.system(size: 24))
                        .padding()
                }
                .offset(x: -30,y: 340) // Sposta il pulsante in alto
                .frame(maxWidth: .infinity, alignment: .trailing) // Allinea il pulsante a destra
            }
        }.fullScreenCover(isPresented: $showSecondView) {
            // Visualizza la seconda vista qui
            TabController()
        }
    }
    
    func rectWidth(forIndex index: Int) -> CGFloat {
        return index == step ? 59 : 35
    }
    
    func rectHeight(forIndex index: Int) -> CGFloat {
        return index == step ? 59 : 35
    }
}



#Preview {
    Onboarding2()
}
