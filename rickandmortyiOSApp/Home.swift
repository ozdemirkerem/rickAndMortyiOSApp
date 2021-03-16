//
//  Home.swift
//  rickandmortyiOSApp
//
//  Created by Kerem Özdemir on 15.03.2021.
//

import SwiftUI

struct Home: View {
    @StateObject var mainData = DecodeAPI()

    var body: some View {
        
        TabView{
            SearchView()
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName:  "magnifyingglass.circle")
                    Text("Search")
                }
                .environmentObject(mainData)
            CharactersView()
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "person.2.square.stack")
                    Text("Characters")
                }
                .environmentObject(mainData)
            LocationView()
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem{
                    Image(systemName: "map")
                    Text("Locations")
                }
                .environmentObject(mainData)
            EpisodesView()
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem{
                    Image(systemName: "tv")
                    Text("Episodes")
                }
                .environmentObject(mainData)
        }
        .accentColor(.red)
        .onAppear() {
            UITabBar.appearance().barTintColor = .white
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
