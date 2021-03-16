//
//  CharacterDetailView.swift
//  rickandmortyiOSApp
//
//  Created by Kerem Özdemir on 15.03.2021.
//

import SwiftUI
import URLImage

struct CharDetails : View {
    
    var char: Character
    @State var isFavorite : Bool = false
    
    let episodeColumns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
    ]

    var body: some View {
        
        ScrollView{
            ZStack{
                VStack(spacing: -30) {
                    HStack{
                        URLImage(url: URL(string: "\(char.image)")!) { image in
                        image
                            .resizable()
                            .cornerRadius(10)
                            .frame(width: 200.0, height: 200.0, alignment:.trailing)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                            .overlay(FavoriteButton(isSet: $isFavorite), alignment: .topTrailing)
                        }
                        .padding(.top,5)
                    }
                    .zIndex(5)
                    
                VStack(alignment: .center, spacing: 10){
                    Text(char.name)
                        .font(.system(size: 30, weight: .bold, design: .default))
                        .foregroundColor(.white)
                        .lineLimit(nil)
                        .padding(.top,30)
                    
                    VStack(alignment: .leading){
                        Text("Status: \(char.status)")
                            .font(.system(size: 15, weight: .bold, design: .default))
                            .lineLimit(1)
                            .foregroundColor(.white)
                        Text("Species: \(char.species)")
                            .font(.system(size: 15, weight: .bold, design: .default))
                            .lineLimit(1)
                            .foregroundColor(.white)
                        Text("Gender: \(char.gender)")
                            .font(.system(size: 15, weight: .bold, design: .default))
                            .lineLimit(1)
                            .foregroundColor(.white)
                        Text("Location: \(char.location.name)")
                            .font(.system(size: 15, weight: .bold, design: .default))
                            .lineLimit(1)
                            .foregroundColor(.white)
                    }
                    .padding(.leading,5)
                    
                    
                    Text("Episodes")
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .foregroundColor(.white)
                        .padding(.top,10)

                    LazyVGrid(columns: episodeColumns){
                        ForEach(char.episode, id: \.self){ episodeRow in
                            Text(episodeRow.replacingOccurrences(of: "https://rickandmortyapi.com/api/episode/", with: ""))
                                .font(.system(size: 15, weight: .bold, design: .default))
                                .foregroundColor(Color(red: 32/255, green: 36/255, blue: 38/255))
                        }
                        .frame(width:(UIScreen.main.bounds.width-60)/6, height: 50)
                        .background(Color(red: 255/255, green: 255/255, blue: 255/255))
                        .modifier(CardModifier())
                        .padding(.vertical,5)
                    }
                }
                .padding(.top,10)
                .padding()
                .cornerRadius(15)
                .frame(width:(UIScreen.main.bounds.width-60))
                .background(Color(red: 32/255, green: 36/255, blue: 38/255))
                .modifier(CardModifier())
                .zIndex(1)
                }
            }
        }

    }
}


