//
//  HomeView.swift
//  DogLand
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//

import SwiftUI

struct HomeView: View {
    init() {
        configureNavigationAppearance()
    }
    
    func configureNavigationAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 24, weight: .medium),
            .foregroundColor: UIColor(named: "DarkGray")!
        ]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Bienvenido a la app de perros")
                    .font(.title)
                
                NavigationLink("Ver perros disponibles") {
                    DogListModuleFactory.make()
                }
                .padding()
            }
        }
    }
}


#Preview {
    HomeView()
}
