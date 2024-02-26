//
//  Onboarding1.swift
//  BarcodeScanner1
//
//  Created by Salvatore Flauto on 26/02/24.
//

import SwiftUI

struct Onboarding1: View {
    var body: some View {
        ZStack{
            
            Color.color2.ignoresSafeArea(.all)
            
            VStack{
                
                Text("Set a reminders")
                    .font(.system(size: 35).bold())
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .frame(width: 325,height: 45)
                    .foregroundColor(.color1)
                    .offset(y:-50)
                    .padding(.top, 61)
                
                
                Text("  so you never forget to use foods!")
                    .font(.system(size: 20))
                    .padding(.top,-55)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 50){
                    VStack(spacing: 40){
                        ZStack{
                            Rectangle()
                                .fill()
                                .foregroundColor(.white)
                                .frame(width: 320,height: 60)
                                .cornerRadius(20.0).shadow(radius: 5)
                                .rotationEffect(Angle(degrees: -2))
                            HStack{
                                Image("im")
                                    .resizable().frame(width: 45,height: 45)
                                    .offset(y: 5)
                                    .rotationEffect(Angle(degrees: -2))
                                
                                VStack{
                                    
                                    Text("BEWARE!")
                                        .bold()
                                        .padding(.leading, -117)
                                    
                                    
                                    Text("The pasta is about to expire 🥲")
                                    
                                }.rotationEffect(Angle(degrees: -2))
                            }
                        }
                        
                        ZStack{
                            Rectangle()
                                .fill()
                                .foregroundColor(.white)
                                .frame(width: 320,height: 60)
                                .cornerRadius(20.0).shadow(radius: 5)
                                .rotationEffect(Angle(degrees: 2))
                            HStack{
                                Image("im")
                                    .resizable().frame(width: 45,height: 45)
                                    .offset(y:-5)
                                    .rotationEffect(Angle(degrees: 2))
                                
                                VStack{
                                    
                                    Text("BEWARE!")
                                        .bold()
                                        .padding(.leading, -117)
                                    
                                    
                                    Text("The pasta is about to expire 🥲")
                                    
                                }.rotationEffect(Angle(degrees: 2))
                                
                            }
                        }
                        ZStack{
                            Rectangle()
                                .fill()
                                .foregroundColor(.white)
                                .frame(width: 320,height: 60)
                                .cornerRadius(20.0).shadow(radius: 5)
                                .rotationEffect(Angle(degrees: -2))
                            HStack{
                                Image("im")
                                    .resizable().frame(width: 45,height: 45)
                                    .offset(y: 5)
                                    .rotationEffect(Angle(degrees: -2))
                                
                                VStack{
                                    
                                    Text("BEWARE!")
                                        .bold()
                                        .padding(.leading, -117)
                                    
                                    
                                    Text("The pasta is about to expire 🥲")
                                    
                                }.rotationEffect(Angle(degrees: -2))
                                
                            }
                        }
                        ZStack{
                            Rectangle()
                                .fill()
                                .foregroundColor(.white)
                                .frame(width: 320,height: 60)
                                .cornerRadius(20.0).shadow(radius: 5)
                                .rotationEffect(Angle(degrees: 2))
                            HStack{
                                Image("im")
                                    .resizable().frame(width: 45,height: 45)
                                    .offset(y:-5)
                                    .rotationEffect(Angle(degrees: 2))
                                
                                VStack{
                                    
                                    Text("BEWARE!")
                                        .bold()
                                        .padding(.leading, -117)
                                    
                                    
                                    Text("The pasta is about to expire 🥲")
                                    
                                }.rotationEffect(Angle(degrees: 2))
                                
                            }
                        }
                    }
                    
                    Text("         You will receive ")
                    + Text("fun").foregroundColor(.color1).bold()
                    + Text(" and ")
                    + Text("encouraging").foregroundColor(.color1).bold()
                    + Text("\n            notifications to keep you on track!")
                    + Text("\n Foods will be so ")
                    + Text("happy ").foregroundColor(.color1).bold()
                    + Text("to be ")
                    + Text("consumed on time! ").foregroundColor(.color1).bold()
                }
            }
        }
    }
}

#Preview {
    Onboarding1()
}
