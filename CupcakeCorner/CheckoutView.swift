//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Alessandre Livramento on 26/12/22.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var myOrder: MyOrder

    @State private var confirmationMessage = String()
    @State private var showingConfimation = false

    @State private var errorMessage = String()
    @State private var showingError = false

    var imageURL = "https://hws.dev/img/cupcakes@3x.jpg"

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: imageURL), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your total is \(myOrder.orderStruct.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfimation) {
            Button("OK") {}
        } message: {
            Text(confirmationMessage)
        }
        .alert("Warning!", isPresented: $showingError) {
            Button("OK") {}
        } message: {
            Text(errorMessage)
        }
    }

    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(myOrder.orderStruct) else {
            print("Failed to encode order")
            return
        }

        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)

            let decodeOrder = try JSONDecoder().decode(OrderStruct.self, from: data)
            confirmationMessage = "Your order for \(decodeOrder.quantity)x \(OrderStruct.types[decodeOrder.type].lowercased()) cupcakes in on its way!"
            showingConfimation = true

        } catch {
            errorMessage = "Checkout failed"
            showingError = true
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(myOrder: MyOrder())
    }
}
