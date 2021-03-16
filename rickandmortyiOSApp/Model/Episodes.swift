//
//  Episodes.swift
//  rickandmortyiOSApp
//
//  Created by Kerem Özdemir on 16.03.2021.
//

import SwiftUI

struct APIEpisode: Codable {
    var info: InfoEpisode
    var results: [Episode]
}

struct InfoEpisode: Codable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}

struct Episode: Identifiable,Codable {
    
    var id: Int
    var name: String
    var air_date: String
    var episode: String
    var characters: [String]

}
