//
//  ChannelService.swift
//  Listings
//
//  Created by Alexandru Dinu on 16.04.2025.
//

import Foundation

protocol ChannelServiceProtocol {
    func fetchChannels() async throws -> [ChannelRemoteModel]
}

class ChannelService: ChannelServiceProtocol {
    func fetchChannels() async throws -> [ChannelRemoteModel] {
        guard let url = URL(string: "https://api.npoint.io/b22fd39c053b256222b1") else {
            throw NSError(domain: "Invalid URL", code: -1, userInfo: nil)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        do {
            let response = try JSONDecoder().decode([ChannelRemoteModel].self, from: data)
            return response
        } catch {
            throw error
        }
    }
}
