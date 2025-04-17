//
//  CampaignRepository.swift
//  Listings
//
//  Created by Alexandru Dinu on 16.04.2025.
//

import Foundation

protocol CampaignRepository {
    func getCampaigns(for channelId: String) async throws -> CampaignModel
}
