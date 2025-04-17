//
//  ChannelRepositoryImpl.swift
//  Listings
//
//  Created by Alexandru Dinu on 16.04.2025.
//

import Foundation

class ChannelRepositoryImpl: ChannelRepository {
    private let service: ChannelServiceProtocol

    init(service: ChannelServiceProtocol) {
        self.service = service
    }

    func getChannels() async throws -> [ChannelModel] {
        let remoteModels = try await service.fetchChannels()
        return remoteModels.map { remoteModel in
            ChannelModel(
                id: UUID(),
                target: remoteModel.target,
                availableChannels: remoteModel.availableChannels.map { availableChannel in
                    AvailableChannelModel(
                        id: availableChannel.id,
                        name: availableChannel.name
                    )
                }
            )
        }
    }
}
