//
//  HomeView.swift
//  DogLand
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//

import SwiftUI

struct HomeView: View {
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
