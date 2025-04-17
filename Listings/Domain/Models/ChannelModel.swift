//
//  ChannelModel.swift
//  Listings
//
//  Created by Alexandru Dinu on 16.04.2025.
//


import Foundation

struct ChannelModel: Identifiable {
    let id: UUID
    let target: String
    let availableChannels: [AvailableChannelModel]
}

struct AvailableChannelModel: Identifiable {
    let id: String
    let name: String
}
