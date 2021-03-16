//
//  EpisodesView.swift
//  rickandmortyiOSApp
//
//  Created by Kerem Özdemir on 16.03.2021.
//

import SwiftUI

struct EpisodesView: View {
    @EnvironmentObject var mainData: DecodeAPI
    @State var cardType:CardType = .list


    var body: some View {
        NavigationView{
            ScrollView{
                
                if mainData.fetchedEpisodes.isEmpty{
                    ProgressView()
                        .padding(.top,50)
                }
                LazyVGrid(columns: cardType.columns, spacing: 15) {
                    ForEach(mainData.fetchedEpisodes){ episode in
                        VStack(alignment:.leading, spacing:20){
                            Text(episode.name)
                                .font(.system(size: 23, weight: .bold, design: .default))
                                .foregroundColor(.white)
                                .lineLimit(nil)
                                
                            HStack{
                                VStack(alignment:.leading){
                                    Text("Date: \(episode.air_date)")
                                        .font(.system(size: 15, weight: .bold, design: .default))
                                        .lineLimit(nil)
                                        .foregroundColor(.white)
                                        
                                    Text("Episode: \(episode.episode)")
                                        .font(.system(size: 15, weight: .bold, design: .default))
                                        .lineLimit(nil)
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(.bottom)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 32/255, green: 36/255, blue: 38/255))
                    .modifier(CardModifier())
                    
                    if mainData.pageLoad == true && mainData.episodePageURL != "End" {
                        ProgressView()
                            .padding(.top,50)
                            .onAppear(perform: {
                                print("Loading....")
                                mainData.pageEpisodes()
                            })
                    }
                    else{
                        GeometryReader{ reader -> Color in
                            
                            let offSet = reader.frame(in: .global).minY
                            let heightSet = UIScreen.main.bounds.height / 3
                            
                            if offSet < heightSet && !mainData.fetchedEpisodes.isEmpty{
                                DispatchQueue.main.async {
                                    mainData.pageLoad = true
                                }
                            }
                            return Color.clear
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitle("Episodes")
        }
        .onAppear(){
            if mainData.fetchedEpisodes.isEmpty{
                mainData.pageEpisodes()
            }
        }
    }
}

struct EpisodesView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesView()
    }
}
