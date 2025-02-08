//
//  ContentView.swift
//  lesson16and17
//
//  Created by ADY M on 2/6/25.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    
    @State private var message = ""
    @State private var photoName = ""
    @State private var lastMessageNumber = -1
    @State private var lastphotoNumber = -1
    @State private var audioPlayer: AVAudioPlayer!
    @State private var soundIsOn = true
    
    let numberOfPhotos = 10  //photo label
    
    @State private var lastSoundNumber = -1
    let numberOfSounds = 6 //sound label
 
    var body: some View {
        
        VStack {
            Text(message)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundStyle(.red)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                .frame(height: 100)
                .animation(.easeIn(duration: 0.15), value: message)
            Spacer()
            Image(photoName)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 45))
                .shadow(radius: 50)
                .animation(.default, value: photoName)
            
            Spacer()
            //toggle button on and off
            HStack {
                Text("Sound On")
                Toggle("Sound On:", isOn: $soundIsOn)
                    .labelsHidden() //hidden elements of label
                    .onChange(of: soundIsOn) { //modif of the toggle
                        if audioPlayer != nil  && audioPlayer.isPlaying {
                            audioPlayer.stop()
                            
                        }
                    }
                
                // && and || or compound cond
                Spacer()
                
                Button("Show Message!") {
                    let messages = ["You are Awesome!",
                                    "You are Great!",
                                    "You are Fantastic!",
                                    "Fabulous? That's You!",
                                    "You  make me Smile!",
                                    "When the Genius Bar needs help, they call You!"]
                    
                    //                refactoring code: repetitve random
                    func nonRepeatingRandom(lastNumber: Int, upperBound: Int) -> Int {
                        var newNumber: Int
                        repeat {
                            newNumber = Int.random(in: 0...upperBound)
                        } while newNumber == lastNumber
                        return newNumber
                    }
                    
                    
                    lastMessageNumber = nonRepeatingRandom(lastNumber: lastMessageNumber, upperBound: messages.count-1)
                    message = messages[lastMessageNumber]
                    
                    lastphotoNumber = nonRepeatingRandom(lastNumber: lastphotoNumber, upperBound: numberOfPhotos-1)
                    photoName = "photo\(lastphotoNumber)"
                    
                    
                    lastSoundNumber = nonRepeatingRandom(lastNumber: lastSoundNumber, upperBound: numberOfSounds-1)
                    if soundIsOn {  //bool value
                        playSound(soundName: "sound\(lastSoundNumber)")
                    }
                    
                }
            }
            .tint(.accentColor)
            .buttonStyle(.borderedProminent)
            .font(.title2)
            
        }
        
        .padding()
    }
    
    
    func playSound(soundName: String) {
        if audioPlayer != nil  && audioPlayer.isPlaying {
            audioPlayer.stop()
            
        }
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("😭 Could not read file named \(soundName)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("😭 ERROR: \(error.localizedDescription) creating audioPlayer.")
        
        }
        
    }
}


#Preview("Light Mode") {
    ContentView()
        .preferredColorScheme(.light)
}
#Preview("Dark Mode") {
    ContentView()
        .preferredColorScheme(.dark)
}
