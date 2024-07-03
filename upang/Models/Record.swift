//
//  Records.swift
//  upang
//
//  Created by Alvin Miftah on 26/06/24.
//

import Foundation
//import SwiftData

/*
struct Record: Codable {
    let profile: Profile
    let data: [Transaction]
    let total: Balance
}

struct Transaction: Codable, Identifiable {
    let id: Int
    let date: String
    let description: String
    let category: String
    let amount: Int
}

struct Profile: Codable {
    let name: String
    let age: Int
    let email: String
}

struct Balance: Codable {
    let totalIncome: Int
    let totalExpense: Int
    let netBalance: Int
    
    enum CodingKeys: String, CodingKey {
        case totalIncome = "total_income"
        case totalExpense = "total_expense"
        case netBalance = "net_balance"
    }
}
 */


/*
// SwiftData Model
@Model
class Record: Codable {
    enum CodingKeys: CodingKey {
        case profile
        case data
        case total
    }
    
    var profile: Profile
    var data: [Transaction]
    var total: Balance
    
    init(profile: Profile, data: [Transaction], total: Balance){
        self.profile = profile
        self.data = data
        self.total = total
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.profile = try container.decode(Profile.self, forKey: .profile)
        self.data = try container.decode([Transaction].self, forKey: .data)
        self.total = try container.decode(Balance.self, forKey: .total)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(profile, forKey: .profile)
        try container.encode(data, forKey: .data)
        try container.encode(total, forKey: .total)
    }
}
*/
