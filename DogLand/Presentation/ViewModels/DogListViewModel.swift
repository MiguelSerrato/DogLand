//
//  DogListViewModel.swift
//  DogLand
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//

import Foundation

@MainActor
protocol DogListViewModelProtocol: ObservableObject {
    var dogs: [Dog] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    func loadDogs(forceRefresh: Bool) async
}

@MainActor
class DogListViewModel: DogListViewModelProtocol {
    @Published var dogs: [Dog] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let fetchDogsUseCase: FetchDogsUseCase

    init(fetchDogsUseCase: FetchDogsUseCase) {
        self.fetchDogsUseCase = fetchDogsUseCase
    }

    func loadDogs(forceRefresh: Bool = false) async {
        isLoading = true
        do {
            let result = try await fetchDogsUseCase.execute(
                forceRefresh: forceRefresh
            )
            dogs = result
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
