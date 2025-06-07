//
//  DogListView.swift
//  DogLand
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//

import SwiftUI

struct DogListView: View {
    @StateObject var viewModel: DogListViewModel
    @State private var hasLoaded = false
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Cargando perros...")
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                        Button("Reintentar") {
                            Task {
                                await viewModel.loadDogs()
                            }
                        }
                        .padding(.top)
                    }
                } else {
                    List(viewModel.dogs) { dog in
                        DogRowView(dog: dog)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Dogs We Love")
            .task {
                if !hasLoaded {
                    hasLoaded = true
                    await viewModel.loadDogs()
                }
            }
        }
    }
}

struct DogRowView: View {
    let dog: Dog
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: URL(string: dog.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.2)
            }
            .frame(width: 100, height: 140)
            .cornerRadius(12)
            .clipped()
            
            VStack(alignment: .leading, spacing: 6) {
                Text(dog.name)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(dog.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Almost \(dog.age) years")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding(.top, 6)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    //DogListView()
}
