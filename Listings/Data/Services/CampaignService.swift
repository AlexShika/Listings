//
//  CampaignService.swift
//  Listings
//
//  Created by Alexandru Dinu on 16.04.2025.
//

import Foundation

protocol CampaignServiceProtocol {
    func fetchCampaigns(for channelId: String) async throws -> CampaignRemoteModel
}

class CampaignService: CampaignServiceProtocol {
    func fetchCampaigns(for channelId: String) async throws -> CampaignRemoteModel {
        guard let url = URL(string: "https://api.npoint.io/\(channelId)") else {
            throw NSError(domain: "Invalid URL", code: -1, userInfo: nil)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        do {
            let response = try JSONDecoder().decode(CampaignRemoteModel.self, from: data)
            return response
        } catch {
            throw error
        }
    }
}
