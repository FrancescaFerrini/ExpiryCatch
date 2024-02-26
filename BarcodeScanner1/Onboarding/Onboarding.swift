//
//  Onboarding.swift
//  BarcodeScanner1
//
//  Created by Francesca Ferrini on 22/02/24.
//

import SwiftUI

struct Onboarding: View {
    
    @State private var isHandMoving = false
    
    var body: some View {
        ZStack{
            Color.color2.ignoresSafeArea(.all)
            VStack{
                
                Text("Scan the barcode!")
                    .font(.system(size: 35).bold())
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding(.bottom, 125.0)
                    .frame(width: 325,height: 45)
                    .foregroundColor(.color1)
                    .padding(.top, 70)
                
                ZStack{
                    Rectangle()
                        .fill()
                        .foregroundColor(.color1)
                        .frame(width: 300,height: 200)
                        .cornerRadius(10.0).shadow(radius: 5)
                        .padding(.bottom, 150)
                    Image("mano")
                        .resizable()
                        .frame(width: 325,height: 411)
                        .shadow(radius: 5)
                        .offset(x: isHandMoving ? 50 : 0)
                        .animation(
                                Animation.easeInOut(duration: 1.0)
                                    .repeatCount(3), // Numero di volte che vuoi che l'animazione si ripeta
                                value: isHandMoving
                            )
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Tempo totale di un'animazione * il numero di ripetizioni
                                    self.isHandMoving = false // Ferma il movimento della mano dopo che l'animazione si è ripetuta per il numero di volte desiderato
                                }
                            }
                }.padding(.top, -20)
                 .padding(.bottom,20)
                
                Text("        Break out your device and start capturing \n               those barcodes like a ")
                + Text("REAL PRO!").foregroundColor(.color1).bold()
                + Text("\nDon't worry, there are no scores, just ")
                + Text("food to save!").foregroundColor(.color1).bold()
                
            }
        } .onAppear {
            self.isHandMoving.toggle()
        }
    }
}

#Preview {
    Onboarding()
}
