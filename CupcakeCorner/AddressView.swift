//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Alessandre Livramento on 26/12/22.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var myOrder: MyOrder

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $myOrder.orderStruct.name)
                TextField("Street Address", text: $myOrder.orderStruct.streetAddress)
                TextField("City", text: $myOrder.orderStruct.city)
                TextField("Zip", text: $myOrder.orderStruct.zip)
            }

            Section {
                NavigationLink {
                    CheckoutView(myOrder: myOrder)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(myOrder.orderStruct.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(myOrder: MyOrder())
    }
}
