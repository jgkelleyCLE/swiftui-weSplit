//
//  ContentView.swift
//  WeSplit
//
//  Created by Jack Kelley on 1/13/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let percentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        //calculate total
        
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipAmount = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipAmount
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var checkTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipAmount = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipAmount
        
        return grandTotal
    }
    

        
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Check Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much tip do you want to tip?") {
                    
//                    Picker("Tip Percentage", selection: $tipPercentage){
//                        ForEach(percentages, id: \.self){
//                            Text("\($0)%")
//                        }
//                    }.pickerStyle(.segmented)
                    
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(0..<101) {
                            Text("\($0)%")
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                }
                
                Section ("Total with tip"){
                    Text(checkTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
               
                Section("Amount per person") {
                    
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                
               
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
            
            
        }
        
    }
}

#Preview {
    ContentView()
}
