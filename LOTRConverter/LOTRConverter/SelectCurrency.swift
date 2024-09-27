//
//  SelectCurrency.swift
//  LOTRConverter
//
//  Created by Talha Dikici on 16.09.2024.
//

import SwiftUI

struct SelectCurrency: View {
    @Environment(\.dismiss) var dismiss
    @Binding var topCurrency: Currency
    @Binding var bottomCurrency: Currency
    
    var body: some View {
        ZStack {
            //Parschment BackgroundImage
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                // Text
                Text("Select the currency you are starthing with:")
                    .fontWeight(.bold)
                
                //Currency icons
                IconGrid(currency: $topCurrency)
                
                //Text
                Text("Select the currency you would like to convert to :")
                    .fontWeight(.bold)
               
                //Currency icons
                IconGrid(currency: $bottomCurrency)
                
                //Done Button
                Button("Done"){
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown)
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
            }
            .padding()
            .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    SelectCurrency(topCurrency: .constant(.copperPenny), bottomCurrency: .constant(.silverPenny))
}
