//
//  ContentView.swift
//  YouAreAwesome
//
//  Created by Tushar Munge on 3/18/25.
//

import SwiftUI

struct ContentView: View {
    @State private var imageString = ""
    @State private var message = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: imageString)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.orange)
            
            Text(message)
                .font(.largeTitle)
                .fontWeight(.thin)
            
            Spacer()
            
            Button("Press Me!") {
                let imageString1 = "sun.max.fill"
                let imageString2 = "hand.thumbsup"
                let message1 = "You are Awesome!"
                let message2 = "You are Great!"
                
                if message == message1 {
                    imageString = imageString2
                    message = message2
                } else {
                    imageString = imageString1
                    message = message1
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
