//
//  Item.swift
//  ciao
//
//  Created by Fernando Sensenhauser on 29/02/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
