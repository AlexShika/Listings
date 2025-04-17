//
//  MailComposer.swift
//  Listings
//
//  Created by Alexandru Dinu on 16.04.2025.
//

import SwiftUI
import MessageUI

struct MailComposer: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    let subject: String
    let body: String
    let recipient: String

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var parent: MailComposer

        init(parent: MailComposer) {
            self.parent = parent
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.setToRecipients([recipient])
        mailComposeVC.setSubject(subject)
        mailComposeVC.setMessageBody(body, isHTML: false)
        mailComposeVC.mailComposeDelegate = context.coordinator
        return mailComposeVC
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
}