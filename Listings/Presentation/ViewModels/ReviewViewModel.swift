//
//  ReviewViewModel.swift
//  Listings
//
//  Created by Alexandru Dinu on 16.04.2025.
//

import Foundation
import MessageUI

class ReviewViewModel: ObservableObject {
    @Published var emailSent: Bool = false
    @Published var showMailComposer: Bool = false
    @Published var mailError: Bool = false

    let selectedCampaign: MonthlyFeeModel
    let channel: String

    weak private var coordinator: AppCoordinator?

    init(coordinator: AppCoordinator?, selectedCampaign: MonthlyFeeModel, channel: String) {
        self.coordinator = coordinator
        self.channel = channel
        self.selectedCampaign = selectedCampaign
    }

}

extension ReviewViewModel {
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            showMailComposer = true
        } else {
            mailError = true
        }
    }

    func emailBody() -> String {
        """
        Channel: \(channel)
        Price: \(selectedCampaign.price) \(selectedCampaign.currency)
        Details:
        \(selectedCampaign.details.joined(separator: "\n"))
        """
    }

    func recipientEmail() -> String {
        "bogus@bogus.com"
    }
}
