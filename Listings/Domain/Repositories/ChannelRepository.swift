//
//  ChannelRepository.swift
//  Listings
//
//  Created by Alexandru Dinu on 16.04.2025.
//

import Foundation

protocol ChannelRepository {
    func getChannels() async throws -> [ChannelModel] 
}
