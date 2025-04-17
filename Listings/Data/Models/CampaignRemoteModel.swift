//
//  CampaignRemoteModel.swift
//  Listings
//
//  Created by Alexandru Dinu on 16.04.2025.
//

import Foundation

struct CampaignRemoteModel: Decodable {
    let channel: String
    let monthlyFees: [MonthlyFeeRemoteModel]

    enum CodingKeys: String, CodingKey {
        case channel
        case monthlyFees = "monthly_fees"
    }
}

struct MonthlyFeeRemoteModel: Decodable {
    let price: Int
    let details: [String]
    let currency: String
}
