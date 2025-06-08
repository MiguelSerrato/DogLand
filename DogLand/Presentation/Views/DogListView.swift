//
//  DogListView.swift
//  DogLand
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//

import SwiftUI

struct DogListView<VM: DogListViewModelProtocol & ObservableObject>: View {
    @StateObject var viewModel: VM
    @State private var hasLoaded = false

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    if viewModel.isLoading {
                        ProgressView("Loading Dogs...")
                            .padding()
                            .background(.clear)
                            .frame(maxWidth: .infinity)
                    } else if let error = viewModel.errorMessage {
                        VStack {
                            Text("Error: \(error)")
                                .foregroundColor(.red)
                            Button("Reintentar") {
                                Task {
                                    await viewModel.loadDogs(forceRefresh: false)
                                }
                            }
                            .padding(.top)
                        }
                    } else {
                        ForEach(viewModel.dogs) { dog in
                            DogRowView(dog: dog)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top)
            }
            .background(.lightGray)
            .navigationTitle("Dogs We Love")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                        }
                        .foregroundColor(.darkGray)
                    }
                }
            }
            .task {
                if !hasLoaded {
                    hasLoaded = true
                    await viewModel.loadDogs(forceRefresh: false)
                }
            }
        }
    }
}
