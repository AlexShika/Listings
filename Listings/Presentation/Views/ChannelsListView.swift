//
//  ChannelsListView.swift
//  Listings
//
//  Created by Alexandru Dinu on 16.04.2025.
//

import SwiftUI

struct ChannelsListView: View {
    @ObservedObject var viewModel: ChannelsViewModel

    var body: some View {
        content
            .padding()
            .navigationBarHidden(true)
    }
}

extension ChannelsListView {
    
    var content: some View {
        VStack {
            Text("Select a Channel")
                .font(.headline)
            listView
            buttonView
        }
    }
    
    var listView: some View {
        List(viewModel.channels, id: \.id) { channel in
            HStack {
                Text(channel.name)
                Spacer()
                if viewModel.selectedChannel?.id == channel.id {
                    Image(systemName: "checkmark")
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                viewModel.selectChannel(channel: channel)
            }
        }
        .listStyle(PlainListStyle())
    }
    
    var buttonView: some View {
        Button("Next") {
            viewModel.goToCampaigns()
        }
        .disabled(viewModel.selectedChannel == nil)
    }
}
