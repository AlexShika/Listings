//
//  GetCampaignsUseCase.swift
//  Listings
//
//  Created by Alexandru Dinu on 16.04.2025.
//

import Foundation

class GetCampaignsUseCase {
    private let repository: CampaignRepository

    init(repository: CampaignRepository) {
        self.repository = repository
    }

    func execute(for channelId: String) async throws -> CampaignModel {
        return try await repository.getCampaigns(for: channelId)
    }
}
