//
//  ContentView.swift
//  speech-playback-configurator
//
//  Created by Mertcan Kırcı on 2.05.2025.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @State private var voiceText = String()
    @State private var selectedSpeed: VoiceSpeed = .medium
    @State private var selectedGender: Gender = .male
    
    var body: some View {
        GeometryReader { geo in
            GroupBox {
                VStack {
                    GroupBox {
                        HStack {
                            Picker(selection: $selectedSpeed, label: Text("")) {
                                Text("Slow").tag(VoiceSpeed.slow)
                                Text("Medium").tag(VoiceSpeed.medium)
                                Text("Fast").tag(VoiceSpeed.fast)
                            }
                            .pickerStyle(.segmented)
                            
                            Picker(selection: $selectedGender, label: Text("")) {
                                Text("Male").tag(Gender.male)
                                Text("Female").tag(Gender.female)
                            }
                            .pickerStyle(.menu)
                        }
                    }
                    
                    TextField("Enter Text", text: $voiceText, axis: .vertical)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.clear)
                                .stroke(.black, style: StrokeStyle(lineWidth: 1))
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    Button {
                        speak()
                    } label: {
                        Image(systemName: "waveform")
                            .resizable()
                            .foregroundStyle(.secondary)
                            .padding(12)
                            .aspectRatio(contentMode: .fit)
                            .background(
                                Color.teal.gradient.opacity(0.2)
                            )
                            .clipShape(Circle())
                            .frame(width: 44, height: 44)
                    }
                    .disabled(voiceText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .frame(maxHeight: .infinity, alignment: .center)
        }
        .padding()
    }
    
    private func speak() {
        let utterance = AVSpeechUtterance(string: voiceText)
        utterance.rate = selectedSpeed.rawValue
        
        switch selectedGender {
        case .male:
            utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Daniel-compact")
        case .female:
            utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Samantha-compact")
        }
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}

fileprivate enum VoiceSpeed: Float, Hashable {
    case fast = 1.0
    case medium = 0.5
    case slow = 0.3
}

fileprivate enum Gender: Hashable {
    case male
    case female
}

#Preview {
    ContentView()
}
