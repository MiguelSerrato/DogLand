//
//  DogListModuleFactory.swift
//  DogLand
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//

import SwiftUI

struct DogListModuleFactory {
    @MainActor static func make() -> some View {
        // APIClient con URLSession
        let apiClient = APIClientImpl()
        
        // CoreDataStack
        let coreDataStack = CoreDataStack.shared
        let localDataSource = CoreDataDogDataSourceImpl(context: coreDataStack.viewContext)
        
        // Repository
        let repository = DogRepositoryImpl(remote: apiClient, local: localDataSource)
        
        // Use case
        let useCase = DefaultFetchDogsUseCase(repository: repository)
        
        // ViewModel
        let viewModel = DogListViewModel(fetchDogsUseCase: useCase)
        
        // View
        return DogListView(viewModel: viewModel)
    }
}
