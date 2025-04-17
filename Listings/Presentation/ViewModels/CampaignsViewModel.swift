//
//  CampaignsViewModel.swift
//  Listings
//
//  Created by Alexandru Dinu on 16.04.2025.
//

import Foundation

class CampaignsViewModel: ObservableObject {
    @Published var campaign: CampaignModel?
    @Published var selectedCampaign: MonthlyFeeModel?
    @Published var isLoading: Bool = false

    weak private var coordinator: AppCoordinator?
    private let getCampaignsUseCase: GetCampaignsUseCase
    private let selectedChannel: AvailableChannelModel

    init(getCampaignsUseCase: GetCampaignsUseCase, coordinator: AppCoordinator, selectedChannel: AvailableChannelModel) {
        self.getCampaignsUseCase = getCampaignsUseCase
        self.coordinator = coordinator
        self.selectedChannel = selectedChannel

        Task {
            await fetchCampaigns()
        }
    }

}

extension CampaignsViewModel {
    func selectCampaign(campaign: MonthlyFeeModel) {
        if selectedCampaign?.id == campaign.id {
            selectedCampaign = nil
            return
        }
        selectedCampaign = campaign
    }

    func goBack() {
        coordinator?.goBack()
    }

    func goToReview() {
        guard let selectedCampaign = selectedCampaign else { return }
        coordinator?.goToReview(selectedCampaign: selectedCampaign, channel: campaign?.channel ?? "")
    }
}

private extension CampaignsViewModel {
    @MainActor
    func fetchCampaigns() async {
        isLoading = true
        do {
            let campaign = try await getCampaignsUseCase.execute(for: selectedChannel.id)
            self.campaign = campaign
            self.isLoading = false
        } catch {
            self.isLoading = false
            print("Error fetching campaigns: \(error)")
        }
    }
}
