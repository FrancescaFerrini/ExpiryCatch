//
//  Onboarding2.swift
//  BarcodeScanner1
//
//  Created by Salvatore Flauto on 26/02/24.
//

import SwiftUI
struct Onboarding2: View {
    @State private var step = 0
    let onboardingSteps = ["Step 1", "Step 2", "Step 3"]
    let stepColors: [Color] = [.colorM1, .colorM2, .colorM3]
    
    var body: some View {
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
            .padding(.top, 60)
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
