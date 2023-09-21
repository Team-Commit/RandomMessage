//
//  File.swift
//  RandomMessageApp
//
//  Created by ㅣ on 2023/09/21.
//

import Foundation
import AVFoundation


class SoundEffect {
    
    var crashAudioPlayer: AVAudioPlayer?
    var oceanAudioPlayer: AVAudioPlayer?

    
    func playCrashSound() {
        
        guard let url = Bundle.main.url(forResource: "crash", withExtension: "mp3") else {return}
        do {
            crashAudioPlayer = try AVAudioPlayer(contentsOf: url)
            crashAudioPlayer?.play()
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
    
    func playOceanSound() {
        guard let url = Bundle.main.url(forResource: "summer-surf-120252", withExtension: "mp3") else { return }
        do {
            oceanAudioPlayer = try AVAudioPlayer(contentsOf: url)
            oceanAudioPlayer?.play()
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
    
}
