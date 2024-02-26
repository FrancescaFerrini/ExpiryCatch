//
//  ChosenMood.swift
//  BarcodeScanner1
//
//  Created by Francesca Ferrini on 26/02/24.
//

import SwiftUI

struct ChosenMood: View {
    var body: some View {
        VStack{
            Text("Pick your \n Expiry Catch mood!")
                .font(.system(size: 35))
                .multilineTextAlignment(.center)
                .padding(.bottom, 50)
                .foregroundColor(.colorM1).bold()
                .offset(y:-10)
            
            ZStack{
                Rectangle()
                    .frame(width: 150,height: 150)
                    .foregroundColor(.colorM1)
                    .cornerRadius(30)
                Image("im1")
                    .frame(width: 197,height: 123)
            }
            
            Text("Calm")
                .font(.system(size: 35))
                .multilineTextAlignment(.center)
                .foregroundColor(.colorM1).bold()
                
            
            Text("This mood is shown by kind words,calm\ntones, favouring kindness, avoiding\naggression, and creating a positive, welcoming atmosphere")
                .offset(y: 50)
        }
    }
}

#Preview {
    ChosenMood()
}
