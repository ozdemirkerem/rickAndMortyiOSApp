//
//  FavoriteButton.swift
//  rickandmortyiOSApp
//
//  Created by Kerem Özdemir on 16.03.2021.
//

import SwiftUI
import Combine

struct FavoriteButton: View {
    @Binding var isSet: Bool

    var body: some View {
        Button(action: {
            isSet.toggle()
        }) {
            Image(systemName: isSet ? "heart.fill" : "heart")
                .foregroundColor(isSet ? Color.red : Color.gray)
                //.foregroundColor(.white)
                .frame(width: 30, height: 30, alignment: .center)
                .padding(10.5)
                .background(Color.white)
                .cornerRadius(10)
                .offset(x: 18, y: -18)
                .shadow(radius: 10)
        }
    }
}
