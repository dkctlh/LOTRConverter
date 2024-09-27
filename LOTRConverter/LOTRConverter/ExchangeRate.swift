//
//  ExchangeRate.swift
//  LOTRConverter
//
//  Created by Talha Dikici on 16.09.2024.
//

import SwiftUI

struct ExchangeRate: View {
    let leftImage: ImageResource
    let text: String
    let rightImage: ImageResource
    
    var body: some View {
        HStack {
            //Left Currency Image
            Image(leftImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
            
            //Exchange rate Text
            Text(text)
            
            //Right Currency Image
            Image(rightImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
        }
    }
}

#Preview {
    ExchangeRate(leftImage: .goldpiece, text: "1 Gold Piece = 4 Gold Pennies", rightImage: .goldpenny)
}

