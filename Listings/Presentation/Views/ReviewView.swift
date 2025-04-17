//
//  ReviewView.swift
//  Listings
//
//  Created by Alexandru Dinu on 16.04.2025.
//

import SwiftUI

struct ReviewView: View {
    @ObservedObject var viewModel: ReviewViewModel

    var body: some View {
        content
            .padding()
            .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $viewModel.showMailComposer) {
                MailComposer(
                    subject: "Campaign Review",
                    body: viewModel.emailBody(),
                    recipient: viewModel.recipientEmail()
                )
            }
            .alert(isPresented: $viewModel.mailError) {
                Alert(
                    title: Text("Error"),
                    message: Text("This device cannot send emails."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationBarHidden(true)
    }
}

extension ReviewView {
    
    var content: some View {
        VStack(spacing: 20) {
            Text("Review Your Selection")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top)

            detailsView
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)

            Spacer()

            buttonView
        }
    }
    
    var detailsView: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Channel")
                .font(.headline)
                .foregroundColor(.secondary)
            Text(viewModel.channel)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.vertical, 5)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)

            Divider()

            Text("Price")
                .font(.headline)
                .foregroundColor(.secondary)
            Text("\(viewModel.selectedCampaign.price) \(viewModel.selectedCampaign.currency)")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.vertical, 5)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)

            Divider()

            Text("Details")
                .font(.headline)
                .foregroundColor(.secondary)
            VStack(alignment: .leading, spacing: 5) {
                ForEach(viewModel.selectedCampaign.details, id: \.self) { detail in
                    Text("• \(detail)")
                        .font(.body)
                        .foregroundColor(.primary)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
        }
    }
    
    var buttonView: some View {
        Button(action: {
            viewModel.sendEmail()
        }) {
            Text("Send Email")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}
