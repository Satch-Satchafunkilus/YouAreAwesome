//
//  ContentView.swift
//  YouAreAwesome
//
//  Created by Tushar Munge on 3/18/25.
//

import AVFAudio
import SwiftUI

struct ContentView: View {
    @State private var imageName = ""
    @State private var lastImageNumber = -1
    @State private var message = ""
    @State private var lastMessageNumber = -1
    @State private var soundName = ""
    @State private var lastSoundNumber = -1
    @State private var audioPlayer: AVAudioPlayer!

    // For Assets Cat images labeled image0 to image9, and
    // sounds labeled sound0 to sound5
    let numberOfImages = 10
    let numberOfSounds = 6

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

            Spacer()
            
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
                var soundNumber: Int

                repeat {
                    messageNumber = Int.random(in: 0..<messages.count)
                } while messageNumber == lastMessageNumber

                //TODO: - Update the message variable -
                message = messages[messageNumber]
                lastMessageNumber = messageNumber

                repeat {
                    imageNumber = Int.random(in: 0...(numberOfImages - 1))
                } while imageNumber == lastImageNumber

                //TODO: - Update the imageName variable -
                imageName = "image\(imageNumber)"
                lastImageNumber = imageNumber

                repeat {
                    soundNumber = Int.random(in: 0..<(numberOfSounds - 1))
                } while soundNumber == lastSoundNumber
                
                //TODO: - Update the soundName variable -
                soundName = "sound\(soundNumber)"
                lastSoundNumber = soundNumber

                //TODO: - Get the Sound file -
                guard let soundFile = NSDataAsset(name: soundName) else {
                    print("😡 Could not read file named \(soundName)")

                    return
                }

                do {
                    audioPlayer = try AVAudioPlayer(data: soundFile.data)
                    audioPlayer.play()
                } catch {
                    print(
                        "😡 ERROR: \(error.localizedDescription) creating audioPlayer"
                    )
                }
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
