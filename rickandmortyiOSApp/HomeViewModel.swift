//
//  HomeViewModel.swift
//  rickandmortyiOSApp
//
//  Created by Kerem Özdemir on 15.03.2021.
//

import SwiftUI
import Combine

class DecodeAPI: ObservableObject {
    
    @Published var searchKey = ""
    @Published var pageURL = "https://rickandmortyapi.com/api/character"
    @Published var episodePageURL = "https://rickandmortyapi.com/api/episode"
    @Published var locationPageURL = "https://rickandmortyapi.com/api/location"

    @Published var pageLoad : Bool = false
    
    var searchCancellable: AnyCancellable? = nil
    
    @Published var fetchedCharacters: [Character]? = nil
    @Published var fetchedAllCharacters: [Character] = []
    @Published var fetchedInfo: Info? = nil
    
    @Published var fetchedEpisodes: [Episode] = []
    @Published var fetchedEpisodesInfo: InfoEpisode? = nil
    
    @Published var fetchedLocations: [LocationAPI] = []
    @Published var fetchedLocationsInfo: InfoLocation? = nil
    
    init() {
        searchCancellable = $searchKey
            .removeDuplicates()
            .debounce(for: 1, scheduler: RunLoop.main)
            .sink(receiveValue: { searchValue in
                if searchValue == ""{
                    self.fetchedCharacters = nil
                }else{
                    self.searchCharacters()
                }
            })
    }
    
    func searchCharacters(){
        
        let entryWord = searchKey.replacingOccurrences(of: " ", with: "%20")
        
        let url = "https://rickandmortyapi.com/api/character/?name=\(entryWord)"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data,_,error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let APIData = data else{
                print("no data")
                return
            }
            
            do{
                let characters = try JSONDecoder().decode(APICharacters.self, from: APIData)
                DispatchQueue.main.async {
                    if self.fetchedCharacters == nil {
                        self.fetchedCharacters = characters.results
                    }
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
    func pageCharacters(){
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: pageURL)!) { (data,_,error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let APIData = data else{
                print("no data")
                return
            }
            
            do{
                let characters = try JSONDecoder().decode(APICharacters.self, from: APIData)
                DispatchQueue.main.async {
                    
                    self.fetchedAllCharacters.append(contentsOf: characters.results)
                    self.fetchedInfo = characters.info
                    self.pageURL = characters.info.next ?? "End"
                        
                    print(self.pageURL)
                    }
                }
            catch{
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
    func pageEpisodes(){
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: episodePageURL)!) { (data,_,error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let APIData = data else{
                print("no data")
                return
            }
            
            do{
                let episodes = try JSONDecoder().decode(APIEpisode.self, from: APIData)
                DispatchQueue.main.async {
                    
                    self.fetchedEpisodes.append(contentsOf: episodes.results)
                    self.fetchedEpisodesInfo = episodes.info
                    self.episodePageURL = episodes.info.next ?? "End"
                        
                    print(self.episodePageURL)
                    }
                }
            catch{
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
    func pageLocations(){
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: locationPageURL)!) { (data,_,error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let APIData = data else{
                print("no data")
                return
            }
            
            do{
                let locations = try JSONDecoder().decode(APILocations.self, from: APIData)
                DispatchQueue.main.async {
                    
                    self.fetchedLocations.append(contentsOf: locations.results)
                    self.fetchedLocationsInfo = locations.info
                    self.locationPageURL = locations.info.next ?? "End"
                        
                    print(self.locationPageURL)
                    }
                }
            catch{
                print(error.localizedDescription)
            }
        }
        .resume()
    }
}
