//
//  CharactersView.swift
//  rickandmortyiOSApp
//
//  Created by Kerem Özdemir on 15.03.2021.
//

import SwiftUI
import URLImage

struct CharactersView:View {
    @EnvironmentObject var mainData: DecodeAPI
    
    @State var cardType:CardType = .list
    @State var show = false
        
    var body: some View{
        ZStack{
            VStack{
                HStack{
                    Picker("ListAndGrid", selection: $cardType){
                        ForEach(CardType.allCases, id: \.self){ type in
                            switch type{
                            case .list:
                                Image(systemName: "rectangle.grid.1x2.fill")
                            case .grid:
                                Image(systemName: "rectangle.grid.2x2.fill")
                            }
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding()
                .padding(.leading,80)
                .padding(.trailing,80)
                
                HStack{
                    Text("Characters")
                        .font(.system(size: 30, weight: .heavy, design: .default))
                        .padding(.leading, 10)
                    Spacer()
                    Button(action: {
                        withAnimation {
                            self.show.toggle()
                        }
                    }){
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .foregroundColor(.black)
                            .font(.system(size: 40))
                            .padding(.trailing)
                    }
                }
                NavigationView{
                    ScrollView {
                        
                        if mainData.fetchedAllCharacters.isEmpty{
                            ProgressView()
                                .padding(.top,50)
                        }
                        LazyVGrid(columns: cardType.columns, spacing: 15) {
                            ForEach(mainData.fetchedAllCharacters){ char in
                                    NavigationLink(destination: CharDetails(char: char)){
                                        switch (cardType){
                                        case .list:
                                            CharRow(char: char)
                                        case .grid:
                                            GridRow(char: char)
                                        }
                                    }
                                    .navigationBarHidden(true)
                            }
                            
                            if mainData.pageLoad == true && mainData.pageURL != "End" {
                                ProgressView()
                                    .padding(.top,50)
                                    .onAppear(perform: {
                                        print("Loading....")
                                        mainData.pageCharacters()
                                    })
                            }
                            else{
                                GeometryReader{ reader -> Color in
                                    
                                    let offSet = reader.frame(in: .global).minY
                                    let heightSet = UIScreen.main.bounds.height / 3
                                    
                                    if offSet < heightSet && !mainData.fetchedAllCharacters.isEmpty{
                                        DispatchQueue.main.async {
                                            mainData.pageLoad = true
                                        }
                                    }
                                    return Color.clear
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                }
                .navigationBarHidden(true)
                .onAppear(){
                    if mainData.fetchedAllCharacters.isEmpty{
                        mainData.pageCharacters()
                    }
                }
            }
            
            if self.show{
                GeometryReader{_ in
                    VStack{
                        VStack{
                            Button(action: {}) {
                                HStack{
                                    Image(systemName: "eyeglasses")
                                        .font(.system(size:30))
                                    Spacer()
                                        .frame(width: 20)
                                    Text("Filter")
                                        .font(.system(size: 23, design: .default))
                                }
                            }

                            Divider()
                            
                            Button(action: {
                                
                                    self.show.toggle()
                        
                            }) {
                                HStack{
                                    Image(systemName: "rectangle.stack.person.crop")
                                        .font(.system(size:30))
                                    Spacer()
                                        .frame(width: 20)
                                    Text("Status")
                                        .font(.system(size: 23, design: .default))
                                }
                            }
                            Divider()
                            
                            Button(action: {
                                
                                    self.show.toggle()
                        
                            }) {
                                HStack{
                                    Image(systemName: "heart.fill")
                                        .font(.system(size:30))
                                    Spacer()
                                        .frame(width: 20)
                                    Text("Favorites")
                                        .font(.system(size: 23, design: .default))
                                }
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/4)
                        .background(Color("Color"))
                        .cornerRadius(10)
                        
                        Spacer()
                            .frame(height: 20)
                        
                        Button(action: {
                           
                                self.show.toggle()
                            
                        }){
                            Image(systemName: "multiply")
                                .font(.system(size:40))
                                
                        }
                        .frame(width: 50, height: 50)
                        .background(Color("Color"))
                        .cornerRadius(25)

                    }
                    .padding(.leading,100)
                    .padding(.top,20)
                    
                }
                .background(Color.black.opacity(0.5).edgesIgnoringSafeArea(.all))
            }
        }
    }
}

struct CharRow : View {
    
    var char: Character
    @State var isFavorite: Bool = false
    
    var body: some View {
          ZStack{
              HStack(spacing: -50){
                
                  URLImage(url: URL(string: "\(char.image)")!) { image in
                      image
                          .resizable()
                          .cornerRadius(10)
                          .frame(width: 100.0, height: 100.0, alignment:.leading)
                          .overlay(RoundedRectangle(cornerRadius: 10)
                          .stroke(Color.white, lineWidth: 4))
                          .shadow(radius: 10)
                  }
                  .zIndex(5)
                  HStack{
                      VStack(alignment: .leading, spacing: 4.0) {
                          Text(char.name)
                              .font(.system(size: 23, weight: .bold, design: .default))
                              .foregroundColor(.white)
                              .lineLimit(nil)
                              .padding(.top)
                          
                          HStack{
                              VStack(alignment:.leading){
                                  Text("Status: \(char.status)")
                                      .font(.system(size: 15, weight: .bold, design: .default))
                                      .lineLimit(nil)
                                      .foregroundColor(.white)
                                  
                                  Text("Species: \(char.species)")
                                      .font(.system(size: 15, weight: .bold, design: .default))
                                      .lineLimit(nil)
                                      .foregroundColor(.white)
                              }
                              Spacer()
                              
                          }
                          .padding(.bottom)
                      }
                  }
                  .padding()
                  .padding(.leading, 60)
                  .frame(maxWidth: .infinity, alignment: .trailing)
                  .background(Color(red: 32/255, green: 36/255, blue: 38/255))
                  .modifier(CardModifier())
                  .zIndex(1)
                  }
              .padding(.horizontal)
          }
    }
}

struct FavoriteChar: ToggleStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
 
        return HStack {
            Image(systemName: configuration.isOn ? "heart.fill" : "heart")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .red : .gray)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0, y: 0)
    }
    
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
    }
}

