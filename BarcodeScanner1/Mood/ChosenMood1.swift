//
//  ChosenMood1.swift
//  BarcodeScanner1
//
//  Created by Francesca Ferrini on 26/02/24.
//

import SwiftUI

struct ChosenMood1: View {
    var body: some View {
        VStack{
            Text("Pick your \n Expiry Catch mood!")
                .font(.system(size: 35))
                .multilineTextAlignment(.center)
                .padding(.bottom, 50)
                .foregroundColor(.colorM2).bold()
                .offset(y:10)
            
            ZStack{
                Rectangle()
                    .frame(width: 150,height: 150)
                    .foregroundColor(.colorM2)
                    .cornerRadius(30)
                Image("fire")
                    .frame(width: 197,height: 123)
            }
            
            Text("Hot")
                .font(.system(size: 35))
                .multilineTextAlignment(.center)
                .foregroundColor(.colorM2).bold()
                
            
            Text("This mood combines boldness\nand brazenness to spark interest, playfully\npushing conventional boundaries with\npiquancy and fun.")
                .offset(y: 28)
                .padding(.bottom,40)
        }
    }
}

#Preview {
    ChosenMood1()
}
