//
//  CardType.swift
//  rickandmortyiOSApp
//
//  Created by Kerem Özdemir on 15.03.2021.
//

import Foundation
import SwiftUI

enum CardType:  CaseIterable {
    case list
    case grid
}

extension CardType {
    
    var columns: [GridItem] {
        switch self {
        case .list:
            return [
                GridItem(.flexible())
            ]
            
        case .grid:
            return [
                GridItem(.flexible()),
                GridItem(.flexible())
            ]
        }
    }
    
}
