//
//  ChannelRemoteModel.swift
//  Listings
//
//  Created by Alexandru Dinu on 16.04.2025.
//

import Foundation

struct ChannelRemoteModel: Decodable {
    let target: String
    let availableChannels: [AvailableChannelRemoteModel]

    enum CodingKeys: String, CodingKey {
        case target
        case availableChannels = "available_channels"
    }
}

struct AvailableChannelRemoteModel: Decodable {
    let id: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "channel_id"
        case name = "channel"
    }
}
