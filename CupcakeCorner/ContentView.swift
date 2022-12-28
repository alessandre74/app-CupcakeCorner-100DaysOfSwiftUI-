//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Alessandre Livramento on 26/12/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var myOrder = MyOrder()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $myOrder.orderStruct.type) {
                        ForEach(OrderStruct.types.indices, id: \.self) {
                            Text(OrderStruct.types[$0])
                        }
                    }

                    Stepper("Number of cakes: \(myOrder.orderStruct.quantity)", value: $myOrder.orderStruct.quantity, in: 3 ... 20)
                }

                Section {
                    Toggle("Any special requests?", isOn: $myOrder.orderStruct.specialRequestEnabled.animation())

                    if myOrder.orderStruct.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $myOrder.orderStruct.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $myOrder.orderStruct.addSprinkles)
                    }
                }

                Section {
                    NavigationLink {
                        AddressView(myOrder: myOrder)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
