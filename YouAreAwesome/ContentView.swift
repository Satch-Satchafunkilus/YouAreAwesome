//
//  ContentView.swift
//  YouAreAwesome
//
//  Created by Tushar Munge on 3/18/25.
//

import SwiftUI

struct ContentView: View {
    @State private var imageName = ""
    @State private var lastImageNumber = 0
    @State private var message = ""
    @State private var lastMessageNumber = 0

    var body: some View {
        VStack {
            Text(message)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundStyle(.red)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                .frame(height: 100)
                .animation(.easeInOut(duration: 0.15), value: message)

            Image(imageName)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(radius: 30)
                .animation(.default, value: imageName)

            Spacer()

            Button("Show Message") {
                let messages = [
                    "You Are Awesome!",
                    "Gadzookd my Friend! I am astonished at how utterly mgnificent you are!",
                    "When the Genius Bar Needs Help, They Call You!",
                    "You Are Great!",
                    "You Are Fantastic!",
                    "Fabulous? That's You!",
                    "You Make Me Smile!",
                ]

                var messageNumber: Int
                var imageNumber: Int

                repeat {
                    messageNumber = Int.random(in: 0..<messages.count)
                    imageNumber = Int.random(in: 0...9)
                } while messageNumber == lastMessageNumber
                    || imageNumber == lastImageNumber

                lastMessageNumber = messageNumber
                lastImageNumber = imageNumber
                
                //TODO: - Update the message & imageName variables -
                message = messages[messageNumber]
                imageName = "image\(imageNumber)"
            }
            .buttonStyle(.borderedProminent)
            .font(.title2)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
