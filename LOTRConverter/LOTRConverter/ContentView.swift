//
//  ContentView.swift
//  LOTRConverter
//
//  Created by Talha Dikici on 16.09.2024.
//

import SwiftUI
import TipKit

struct ContentView: View {
    @State var showExchangeInfo = false
    @State var showSelectCurrency = false
    
    @State var leftAmount = ""
    @State var rightAmount = ""
    
    @FocusState var leftTyping
    @FocusState var rightTyping
    
    @State var leftCurrency: Currency = .silverPiece
    @State var rightCurrency: Currency = .goldPiece
    
    var body: some View {
        ZStack{
            //BackgroundImage
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                //PravingPony ImageView
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                //Exchange Text
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                //Conversion Section
                HStack{
                    //Left conversion section
                    VStack{
                        //Currency
                        HStack{
                            //Currency image
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                            //Currency Text
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        .popoverTip(CurrencyTip(), arrowEdge: .bottom)
                        
                        //Textfield
                        TextField("Amount", text: $leftAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($leftTyping)
                            .keyboardType(.decimalPad)
                
                    }
                    
                    //EqualSign
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)
                    
                    //Right conversion section
                    VStack{
                        //Currency
                        HStack{
                            //Currency image
                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                            //Currency Text
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        //Textfield
                        TextField("Amount", text: $rightAmount)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                            .focused($rightTyping)
                            .keyboardType(.decimalPad)
                        
                    }
                }
                .padding()
                .background(.black.opacity(0.5))
                .clipShape(.capsule)
                Spacer()
                
                //Info Button
                HStack {
                    Spacer()
                    Button {
                        showExchangeInfo.toggle()
                        
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing)
                }
            }
            
        }
        .task {
            try? Tips.configure()
        }
        .onTapGesture {
            hideKeyboard()
        }
        .onChange(of: leftAmount) {
            if leftTyping {
                rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
            }
        }
        .onChange(of: rightAmount) {
            if rightTyping{
                leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
            }
        }
        .onChange(of: leftCurrency) {
            leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
        }
        .onChange(of: rightCurrency) {
            rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
        }
        .sheet(isPresented: $showExchangeInfo) {
            ExchangeInfo()
        }
        .sheet(isPresented: $showSelectCurrency) {
            SelectCurrency( topCurrency: $leftCurrency,
                            bottomCurrency: $rightCurrency)
        }
    }
}
extension View{
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }}

#Preview {
    ContentView()
}
