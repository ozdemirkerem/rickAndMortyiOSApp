//
//  Locations.swift
//  rickandmortyiOSApp
//
//  Created by Kerem Özdemir on 16.03.2021.
//

import SwiftUI

struct APILocations: Codable {
    var info: InfoLocation
    var results: [LocationAPI]
}

struct InfoLocation: Codable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}

struct LocationAPI: Identifiable,Codable {
    
    var id: Int
    var name: String
    var type: String
    var dimension: String
    var residents: [String]

}
