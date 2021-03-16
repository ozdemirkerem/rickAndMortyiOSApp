//
//  SearchView.swift
//  rickandmortyiOSApp
//
//  Created by Kerem Özdemir on 15.03.2021.
//

import SwiftUI
import URLImage

struct SearchView:View {
    @EnvironmentObject var mainData: DecodeAPI
    @State private var isEditing = false

    var body: some View{
        NavigationView{
            ScrollView{
                VStack{
                    HStack{
                    
                        Image(systemName: "magnifyingglass.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.gray)
                        
                        TextField("Search Character", text: $mainData.searchKey)
                            .font(.headline)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .onTapGesture {
                                self.isEditing = true
                            }
                        Spacer()
                        
                        if isEditing {
                            Button(action: {
                                self.isEditing = false
                                self.mainData.searchKey = ""
                            }){
                              Image(systemName: "multiply.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding()
                    .frame(height: 70)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: Color.offWhite.opacity(0.7), radius: 10, x: -5, y: -5)
                }
                .padding()
                
                if let characters = mainData.fetchedCharacters{
                    if characters.isEmpty{
                        Text("No Results Found")
                            .padding(.top,20)
                    }
                    else{
                        ForEach(characters){ data in
                            NavigationLink(destination: CharDetails(char: data)){
                                CharRow(char: data)
                            }
                            .navigationBarHidden(true)
                        }
                    }
                }
                else{
                    if mainData.searchKey != "" {
                        ProgressView()
                            .padding(.top,20)
                    }
                }
            }
            .navigationTitle("Search")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
    }
}

extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
}
