//
//  CampaignRepositoryImpl.swift
//  Listings
//
//  Created by Alexandru Dinu on 16.04.2025.
//

import Foundation

class CampaignRepositoryImpl: CampaignRepository {
    private let service: CampaignServiceProtocol

    init(service: CampaignServiceProtocol) {
        self.service = service
    }

    func getCampaigns(for channelId: String) async throws -> CampaignModel {
        let remoteModel = try await service.fetchCampaigns(for: channelId)
        return CampaignModel(
            id: UUID(),
            channel: remoteModel.channel,
            monthlyFees: remoteModel.monthlyFees.map { fee in
                MonthlyFeeModel(
                    id: UUID(),
                    price: fee.price,
                    details: fee.details,
                    currency: fee.currency
                )
            }
        )
    }
}
