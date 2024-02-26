//
//  SheetView.swift
//  BarcodeScanner1
//
//  Created by Francesca Ferrini on 21/02/24.
//

import SwiftUI

struct SheetView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button("Press to dismiss") {
            dismiss()
        }
        .font(.title)
        .padding()
        .background(.black)
    }
}
