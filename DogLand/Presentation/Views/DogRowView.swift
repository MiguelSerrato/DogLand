//
//  DogRowView.swift
//  DogLand
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//

import SwiftUI

struct DogRowView: View {
    let dog: Dog
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .frame(height: 180)
            
            HStack(alignment: .bottom, spacing: 8) {
                AsyncImage(url: URL(string: dog.image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
                .frame(width: 130, height: 210)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .clipped()
                
                ZStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(dog.name)
                            .font(.title2)
                            .foregroundColor(.darkGray)
                            .accessibilityIdentifier(dog.name)
                        
                        Text(dog.description)
                            .foregroundColor(.normalGray)
                            .font(.body)
                            .lineLimit(3)
                            .accessibilityIdentifier(dog.description)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 12)
                    .padding(.bottom, 36)
                    .padding(.trailing, 16)
                    
                    VStack {
                        Spacer()
                        Text("Almost \(dog.age) years")
                            .fontWeight(.semibold)
                            .font(.subheadline)
                            .foregroundColor(.darkGray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .accessibilityIdentifier("\(dog.age)")
                    }.padding(.bottom, 32)
                }
                .padding(.leading, 12)
                .frame(height: 180)
            }
        }
        .padding(.horizontal)
        .padding(.top, 20)
    }
}

#Preview {
    //DogRowView()
}
