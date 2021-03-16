//
//  GridView.swift
//  rickandmortyiOSApp
//
//  Created by Kerem Özdemir on 15.03.2021.
//

import SwiftUI
import URLImage

struct GridRow : View {
    
    var char: Character
    
    var body: some View {
      ZStack{
          VStack(spacing: -30) {
                    
              URLImage(url: URL(string: "\(char.image)")!) { image in
                  image
                      .resizable()
                      .cornerRadius(10)
                      .frame(width: 120.0, height: 120.0, alignment:.center)
                      .overlay(RoundedRectangle(cornerRadius: 10)
                      .stroke(Color.white, lineWidth: 4))
                      .shadow(radius: 10)
                      
              }
              .padding(.top)
              .zIndex(5)
              VStack(alignment: .center, spacing: 10){
                  Text(char.name)
                      .font(.system(size: 23, weight: .bold, design: .default))
                      .foregroundColor(.white)
                      .lineLimit(nil)
                      .padding(.top,30)
                  HStack{
                      VStack(alignment: .leading){
                          Text("Status: \(char.status)")
                              .font(.system(size: 15, weight: .bold, design: .default))
                              .lineLimit(nil)
                              .foregroundColor(.white)
                          
                          Text("Species: \(char.species)")
                              .font(.system(size: 15, weight: .bold, design: .default))
                              .lineLimit(nil)
                              .foregroundColor(.white)
                      }
                      .padding(.leading,5)
                      Spacer()
                  }
              }
              .padding(.vertical)
              .padding()
              .cornerRadius(15)
              .frame(width:(UIScreen.main.bounds.width-60)/2)
              .background(Color(red: 32/255, green: 36/255, blue: 38/255))
              .modifier(CardModifier())
              .zIndex(1)
          }
      }
    }
}
