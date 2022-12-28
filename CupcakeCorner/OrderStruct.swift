//
//  MyOrder.swift
//  CupcakeCorner
//
//  Created by Alessandre Livramento on 28/12/22.
//

import SwiftUI

class MyOrder: ObservableObject {
    @Published var orderStruct = OrderStruct()
}

struct OrderStruct: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }

    var extraFrosting = false
    var addSprinkles = false

    var name = String()
    var streetAddress = String()
    var city = String()
    var zip = String()

    var hasValidAddress: Bool {
        if name.isRealEmpty || streetAddress.isRealEmpty || city.isRealEmpty || zip.isRealEmpty {
            return false
        }

        return true
    }

    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
}

extension String {
    var isRealEmpty: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
