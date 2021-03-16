//
//  LocationView.swift
//  rickandmortyiOSApp
//
//  Created by Kerem Özdemir on 16.03.2021.
//

import SwiftUI

struct LocationView: View {
    @EnvironmentObject var mainData: DecodeAPI
    @State var cardType:CardType = .list

    
    var body: some View {
        
        NavigationView{
            ScrollView{
                
                if mainData.fetchedLocations.isEmpty{
                    ProgressView()
                        .padding(.top,50)
                }
                LazyVGrid(columns: cardType.columns, spacing: 15) {
                    ForEach(mainData.fetchedLocations){ loc in
                        VStack(alignment:.leading, spacing:20){
                            Text(loc.name)
                                .font(.system(size: 23, weight: .bold, design: .default))
                                .foregroundColor(.white)
                                .lineLimit(nil)
                                
                            HStack{
                                VStack(alignment:.leading){
                                    Text("Type: \(loc.type)")
                                        .font(.system(size: 15, weight: .bold, design: .default))
                                        .lineLimit(nil)
                                        .foregroundColor(.white)
                                        
                                    Text("Dimension: \(loc.dimension)")
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
                    
                    if mainData.pageLoad == true && mainData.locationPageURL != "End" {
                        ProgressView()
                            .padding(.top,50)
                            .onAppear(perform: {
                                print("Loading....")
                                mainData.pageLocations()
                            })
                    }
                    else{
                        GeometryReader{ reader -> Color in
                            
                            let offSet = reader.frame(in: .global).minY
                            let heightSet = UIScreen.main.bounds.height / 3
                            
                            if offSet < heightSet && !mainData.fetchedLocations.isEmpty{
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
            .navigationBarTitle("Locations")
        }
        .onAppear(){
            if mainData.fetchedLocations.isEmpty{
                mainData.pageEpisodes()
            }
        }

        
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
