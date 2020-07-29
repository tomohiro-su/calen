//
//  MicViewController.swift
//  Caren
//
//  Created by 須田　知弘 on 2020/06/26.
//  Copyright © 2020 tomohiro.suda. All rights reserved.
//

import UIKit
import AVFoundation

class MicViewController: UIViewController {
    
    var audioRecorder: AVAudioRecorder!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    var audioPlayerNode: AVAudioPlayerNode!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(.playAndRecord, mode: .default)
            try session.setActive(true)
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecorder = try AVAudioRecorder(url: getAudioFileUrl(), settings: settings)
            audioRecorder.delegate = self as? AVAudioRecorderDelegate
        } catch let error {
            print(error)
        }
        
    }
    
    @IBAction func record(_ sender: Any) {
        if !audioRecorder.isRecording {
            audioRecorder.record()
        } else {
            audioRecorder.stop()
        }
    }
    
    
    @IBAction func play(_ sender: Any) {
        audioEngine = AVAudioEngine()
        do {
            audioFile = try AVAudioFile(forReading: getAudioFileUrl())
            
            audioPlayerNode = AVAudioPlayerNode()
            audioEngine.attach(audioPlayerNode)
            audioEngine.connect(audioPlayerNode, to: audioEngine.outputNode, format: audioFile.processingFormat)
            
            audioPlayerNode.stop()
            audioPlayerNode.scheduleFile(audioFile, at: nil)
            
            try audioEngine.start()
            audioPlayerNode.play()
        } catch let error {
            print(error)
        }
    }
    
    func getAudioFileUrl() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDirect = paths[0]
        let audioUrl = docsDirect.appendingPathComponent("recording.m4a")
        
        return audioUrl
    }
}
