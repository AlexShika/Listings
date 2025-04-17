//
//  CampaignsListView.swift
//  Listings
//
//  Created by Alexandru Dinu on 16.04.2025.
//

import SwiftUI

struct CampaignsListView: View {
    @ObservedObject var viewModel: CampaignsViewModel

    var body: some View {
        content
            .padding()
            .navigationBarHidden(true)
    }
}

extension CampaignsListView {
    var content: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading Campaigns...")
                    .padding()
            } else {
                Text("Select a Campaign from \(viewModel.campaign?.channel ?? "")")
                    .font(.headline)
                listView
                navigationButtons
            }
        }
    }
    
    var listView: some View {
        List(viewModel.campaign?.monthlyFees ?? [], id: \.id) { fee in
            HStack {
                VStack(alignment: .leading) {
                    Text("Price: \(fee.price) \(fee.currency)")
                    Text("Details:")
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(fee.details, id: \.self) { detail in
                            Text("• \(detail)")
                        }
                    }
                }
                Spacer()
                if viewModel.selectedCampaign?.id == fee.id {
                    Image(systemName: "checkmark")
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                viewModel.selectCampaign(campaign: fee)
            }
        }
        .listStyle(PlainListStyle())
    }
    
    var navigationButtons: some View {
        HStack {
            Button("Back") {
                viewModel.goBack()
            }
            Spacer()
            Button("Next") {
                viewModel.goToReview()
            }
            .disabled(viewModel.selectedCampaign == nil)
        }
    }
}
