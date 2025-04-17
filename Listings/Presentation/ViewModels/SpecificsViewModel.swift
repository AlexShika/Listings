//
//  SpecificsViewModel.swift
//  Listings
//
//  Created by Alexandru Dinu on 16.04.2025.
//

import Foundation

class SpecificsViewModel: ObservableObject {
    @Published var specifics: [ChannelModel] = []
    @Published var selectedSpecifics: [ChannelModel] = []
    @Published var isLoading: Bool = false

    weak private var coordinator: AppCoordinator?
    private let getChannelsUseCase: GetChannelsUseCase

    init(getChannelsUseCase: GetChannelsUseCase, coordinator: AppCoordinator?) {
        self.getChannelsUseCase = getChannelsUseCase
        self.coordinator = coordinator
        
        Task {
            await fetchChannels()
        }
    }

}

extension SpecificsViewModel {
    func toggleSpecificSelection(specific: ChannelModel) {
        if selectedSpecifics.contains(where: { specific.id == $0.id }) {
            selectedSpecifics.removeAll { $0.id == specific.id }
        } else {
            selectedSpecifics.append(specific)
        }
    }

    func goToChannels() {
        coordinator?.goToChannels(selectedSpecifics: selectedSpecifics)
    }
}

private extension SpecificsViewModel {
    @MainActor
    func fetchChannels() async {
        isLoading = true
        do {
            let channels = try await getChannelsUseCase.execute()
            self.specifics = channels
            self.isLoading = false
        } catch {
            self.isLoading = false
            print("Error fetching channels: \(error)")
        }
    }
}
