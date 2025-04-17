//
//  CampaignModel.swift
//  Listings
//
//  Created by Alexandru Dinu on 16.04.2025.
//


import Foundation

struct CampaignModel: Identifiable {
    let id: UUID
    let channel: String
    let monthlyFees: [MonthlyFeeModel]
}

struct MonthlyFeeModel: Identifiable {
    let id: UUID
    let price: Int
    let details: [String]
    let currency: String
}
