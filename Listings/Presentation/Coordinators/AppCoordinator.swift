//
//  AppCoordinator.swift
//  Listings
//
//  Created by Alexandru Dinu on 16.04.2025.
//

import SwiftUI

class AppCoordinator: ObservableObject {
    @Published var navigationPath: NavigationPath = NavigationPath()
    @Published var specificsViewModel: SpecificsViewModel?

    enum Destination: Hashable {
        case channels(selectedSpecifics: [ChannelModel])
        case campaigns(selectedChannel: AvailableChannelModel)
        case review(selectedCampaign: MonthlyFeeModel, channel: String)

        func hash(into hasher: inout Hasher) {
            switch self {
            case .channels(let selectedSpecifics):
                hasher.combine("channels")
                hasher.combine(selectedSpecifics.map { $0.id })
            case .campaigns(let selectedChannel):
                hasher.combine("campaigns")
                hasher.combine(selectedChannel.id)
            case .review(let selectedCampaign, _):
                hasher.combine("review")
                hasher.combine(selectedCampaign.id)
            }
        }

        static func == (lhs: Destination, rhs: Destination) -> Bool {
            switch (lhs, rhs) {
            case (.channels(let lhsSpecifics), .channels(let rhsSpecifics)):
                return lhsSpecifics.map { $0.id } == rhsSpecifics.map { $0.id }
            case (.campaigns(let lhsChannel), .campaigns(let rhsChannel)):
                return lhsChannel.id == rhsChannel.id
            case (.review(let lhsCampaign, _), .review(let rhsCampaign, _)):
                return lhsCampaign.id == rhsCampaign.id
            default:
                return false
            }
        }
    }

    init() {
        Task {
            await initializeSpecificsViewModel()
        }
    }

    @MainActor
    private func initializeSpecificsViewModel() async {
        let service = ChannelService()
        let repository = ChannelRepositoryImpl(service: service)
        let getChannelsUseCase = GetChannelsUseCase(repository: repository)
        self.specificsViewModel = SpecificsViewModel(getChannelsUseCase: getChannelsUseCase, coordinator: self)
    }

    func view(for destination: Destination) -> AnyView {
        switch destination {
        case .channels(let selectedSpecifics):
            let channelsViewModel = ChannelsViewModel(selectedSpecifics: selectedSpecifics, coordinator: self)
            return AnyView(ChannelsListView(viewModel: channelsViewModel))
        case .campaigns(let selectedChannel):
            let service = CampaignService()
            let repository = CampaignRepositoryImpl(service: service)
            let getCampaignsUseCase = GetCampaignsUseCase(repository: repository)
            let campaignsViewModel = CampaignsViewModel(getCampaignsUseCase: getCampaignsUseCase, coordinator: self, selectedChannel: selectedChannel)
            return AnyView(CampaignsListView(viewModel: campaignsViewModel))
        case .review(let selectedCampaign, let channel):
            let reviewViewModel = ReviewViewModel(coordinator: self, selectedCampaign: selectedCampaign, channel: channel)
            return AnyView(ReviewView(viewModel: reviewViewModel))
        }
    }

    func goToChannels(selectedSpecifics: [ChannelModel]) {
        navigationPath.append(Destination.channels(selectedSpecifics: selectedSpecifics))
    }

    func goToCampaigns(selectedChannel: AvailableChannelModel) {
        navigationPath.append(Destination.campaigns(selectedChannel: selectedChannel))
    }

    func goToReview(selectedCampaign: MonthlyFeeModel, channel: String) {
        navigationPath.append(Destination.review(selectedCampaign: selectedCampaign, channel: channel))
    }

    func goBack() {
        navigationPath.removeLast()
    }
}
