//
//  ChosenMood2.swift
//  BarcodeScanner1
//
//  Created by Francesca Ferrini on 26/02/24.
//

import SwiftUI

struct ChosenMood2: View {
    var body: some View {
        VStack{
            Text("Pick your \n Expiry Catch mood!")
                .font(.system(size: 35))
                .multilineTextAlignment(.center)
                .padding(.bottom, 50)
                .foregroundColor(.colorM3).bold()
                .offset(y:-10)
                .padding(.bottom, -20)
            
            ZStack{
                Rectangle()
                    .frame(width: 150,height: 150)
                    .foregroundColor(.colorM3)
                    .cornerRadius(30)
                Image("hurricane")
                    .frame(width: 197,height: 123)
            }
            
            Text("Extreme")
                .font(.system(size: 35))
                .multilineTextAlignment(.center)
                .foregroundColor(.colorM3).bold()
                
            
            Text("This mood exudes boldness \nand provocation, driving fearless pursuit of\n intense experiences and challenges.")
                .offset(y: 50)
                .padding(.bottom,40)
        }
    }
}

#Preview {
    ChosenMood2()
}
