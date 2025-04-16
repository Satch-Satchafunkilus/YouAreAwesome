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
    @State private var lastSoundNumber = -1
    
    @State private var soundIsOn: Bool = true
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

            HStack {
                Text("Sound On:")
                Toggle("", isOn: $soundIsOn)
                    .labelsHidden()
                    .onChange(of: soundIsOn) {
                        // If launch the App, and you toggle Sound On to off,
                        // before clicking on Show Message (which also triggers
                        // playing a sound), the App crashes, as the State
                        // variable audioPlayer is nil. Checking if it's not
                        // nil solves this.
                        if audioPlayer != nil && audioPlayer.isPlaying {
                            audioPlayer.stop()
                        }
                    }
                
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
                    
                    lastMessageNumber = nonRepeatingRandom(
                        lastNumber: lastMessageNumber,
                        upperBound: (messages.count - 1)
                    )
                    
                    //TODO: - Update the message variable -
                    message = messages[lastMessageNumber]
                    
                    lastImageNumber = nonRepeatingRandom(
                        lastNumber: lastImageNumber,
                        upperBound: (numberOfImages - 1)
                    )
                    
                    //TODO: - Update the imageName variable -
                    imageName = "image\(lastImageNumber)"
                    
                    lastSoundNumber = nonRepeatingRandom(
                        lastNumber: lastSoundNumber,
                        upperBound: (numberOfSounds - 1)
                    )
                    
                    if soundIsOn {
                        playSound(soundName: "sound\(lastSoundNumber)")
                    }
                }
                .buttonStyle(.borderedProminent)
                .font(.title2)
            }
        }
        .padding()
    }

    func nonRepeatingRandom(lastNumber: Int, upperBound: Int) -> Int {
        var newNumber: Int

        repeat {
            newNumber = Int.random(in: 0...upperBound)
        } while newNumber == lastNumber

        return newNumber
    }
    
    func playSound(soundName: String) {
        // Prior to playing a sound, check if it's already playing one.
        // If it is, stop it. This prevents overlapping sounds from
        // playing.
        if audioPlayer != nil && audioPlayer.isPlaying {
            audioPlayer.stop()
        }
        
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
}

#Preview {
    ContentView()
}
