//
//  SpecificsListView.swift
//  Listings
//
//  Created by Alexandru Dinu on 16.04.2025.
//

import SwiftUI

struct SpecificsListView: View {
    @ObservedObject var viewModel: SpecificsViewModel

    var body: some View {
        content
            .padding()
            .navigationBarHidden(true)
    }
}

extension SpecificsListView {
    
    var content: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading Channels...")
                    .padding()
            } else {
                Text("Select Targeting Specifics")
                    .font(.headline)
                listView
                buttonView
            }
        }
    }
    
    var listView: some View {
        List(viewModel.specifics, id: \.id) { specific in
            HStack {
                Text(specific.target)
                Spacer()
                if viewModel.selectedSpecifics.contains(where: { specific.id == $0.id }) {
                    Image(systemName: "checkmark")
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                viewModel.toggleSpecificSelection(specific: specific)
            }
        }
        .listStyle(PlainListStyle())
    }
    
    var buttonView: some View {
        Button("Next") {
            viewModel.goToChannels()
        }
        .disabled(viewModel.selectedSpecifics.isEmpty)
    }
}
