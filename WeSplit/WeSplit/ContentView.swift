//
//  ContentView.swift
//  WeSplit
//
//  Created by Minyov Alexandra on 16.06.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkedAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection=Double(tipPercentage)
        
        let tipValue = checkedAmount/100 * tipSelection
        let grandTotal = checkedAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return  amountPerPerson
        
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section{
                    TextField("Amount:", value: $checkedAmount, format:.currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people" , selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                Section{
                    Picker("Tip Percentage:", selection: $tipPercentage){
                        ForEach(tipPercentages, id:\.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }
            } .navigationTitle("WeSplit")
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard){
                        Spacer()
                        Button("Done"){
                            amountIsFocused = false
                        }
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
