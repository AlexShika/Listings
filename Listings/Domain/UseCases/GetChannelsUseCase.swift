//
//  GetChannelsUseCase.swift
//  Listings
//
//  Created by Alexandru Dinu on 16.04.2025.
//

import Foundation

class GetChannelsUseCase {
    private let repository: ChannelRepository

    init(repository: ChannelRepository) {
        self.repository = repository
    }

    func execute() async throws -> [ChannelModel] {
        return try await repository.getChannels()
    }
}