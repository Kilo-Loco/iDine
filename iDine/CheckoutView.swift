//
//  CheckoutView.swift
//  iDine
//
//  Created by Kyle Lee on 7/9/19.
//  Copyright © 2019 Kyle Lee. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    
    @EnvironmentObject var order: Order
    static let paymentTypes = ["Cash", "Credit Card", "iDine Points"]
    static let tipAmounts = [10, 15, 20, 25, 0]
    
    @State private var paymentType = 0
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var tipAmount = 1
    
    var totalPrice: Double {
        let total = Double(order.total)
        let tipValue = total / 200 * Double(Self.tipAmounts[tipAmount])
        return total + tipValue
    }
    
    var body: some View {
        Form {
            Section {
                
                Picker(selection: $paymentType, label: Text("How do you want to pay?")) {
                    ForEach(0 ..< Self.paymentTypes.count) {
                        Text(Self.paymentTypes[$0])
                    }
                }
                
                Toggle(isOn: $addLoyaltyDetails) {
                    Text("Add iDine loyalty card")
                }
                
                if addLoyaltyDetails {
                    TextField("Enter your iDine ID", text: $loyaltyNumber)
                }
            }
            
            Section(header: Text("Add a tip?")) {
                SegmentedControl(selection: $tipAmount) {
                    ForEach(0 ..< Self.tipAmounts.count) {
                        Text("\(Self.tipAmounts[$0])")
                    }
                }
            }
            
            Section(header: Text("TOTAL: $\(totalPrice, specifier: "%.2f")")) {
                Button(action: {
                    
                }) {
                    Text("Confirm Order")
                }
            }
            
        }
        .navigationBarTitle(Text("Payment"), displayMode: .inline)
    }
}

#if DEBUG
struct CheckoutView_Previews : PreviewProvider {
    static let order = Order()
    
    static var previews: some View {
        NavigationView {
            CheckoutView().environmentObject(order)
        }
    }
}
#endif
