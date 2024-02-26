//
//  Item.swift
//  BarcodeScanner1
//
//  Created by Francesca Ferrini on 23/02/24.
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

