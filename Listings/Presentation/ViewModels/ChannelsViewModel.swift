//
//  ChannelsViewModel.swift
//  Listings
//
//  Created by Alexandru Dinu on 16.04.2025.
//

import Foundation

class ChannelsViewModel: ObservableObject {
    @Published var channels: [AvailableChannelModel] = []
    @Published var selectedChannel: AvailableChannelModel?
    

    weak private var coordinator: AppCoordinator?
    private let selectedSpecifics: [ChannelModel]
    
    init(selectedSpecifics: [ChannelModel], coordinator: AppCoordinator?) {
        self.selectedSpecifics = selectedSpecifics
        self.coordinator = coordinator
        extractChannels()
    }

}

extension ChannelsViewModel {
    func selectChannel(channel: AvailableChannelModel) {
        selectedChannel = channel
    }

    func goToCampaigns() {
        guard let selectedChannel = selectedChannel else { return }
        coordinator?.goToCampaigns(selectedChannel: selectedChannel)
    }
}

private extension ChannelsViewModel {
    func extractChannels() {
        let allChannels = selectedSpecifics.flatMap { $0.availableChannels }
        let uniqueChannels = Dictionary(grouping: allChannels, by: { $0.id })
            .compactMap { $0.value.first }
        self.channels = uniqueChannels
    }
}
