//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Sujal Ghosh on 18/12/16.
//  Copyright © 2016 Sujal. All rights reserved.
//

import UIKit
import AVFoundation

private let PlayerViewSID = "RecordSoundToPlaySoundSID"

class RecordSoundsViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    var audioRecorder: AVAudioRecorder!
    var filePath: URL?
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAudioRecordingPermission(nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        instructionLabel.text = "Tap to Record"
        stopRecordingButton.isEnabled = false
        recordButton.isEnabled = true
    }
    
    // MARK: Actions
    @IBAction func recordButtonAction(_ sender: Any) {
        checkAudioRecordingPermission() { isPermitted in
            if !isPermitted {
                Alerts.showAlert("Error", message: Alerts.RecordingDisabledMessage, presentingViewController: self)
                return
            }
            self.instructionLabel.text = "Recording in progress"
            self.stopRecordingButton.isEnabled = true
            self.recordButton.isEnabled = false
            
            let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
            let recordingName = "recordedVoice.wav"
            let pathArray = [dirPath, recordingName]
            self.filePath = URL(string: pathArray.joined(separator: "/"))
            
            let session = AVAudioSession.sharedInstance()
            try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
            
            try! self.audioRecorder = AVAudioRecorder(url: self.filePath!, settings: [:])
            self.audioRecorder.delegate = self
            self.audioRecorder.isMeteringEnabled = true
            self.audioRecorder.prepareToRecord()
            self.audioRecorder.record()
        }
    }
    
    @IBAction func stopRecordButtonAction(_ sender: Any) {
        audioRecorder.stop()
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier?.compare(PlayerViewSID) == ComparisonResult.orderedSame) {
            let playsoundViewController = segue.destination as! PlaySoundsViewController
            playsoundViewController.recordedAudioURL = filePath
        }
    }
}

extension RecordSoundsViewController: AVAudioRecorderDelegate {
    
    func checkAudioRecordingPermission(_ completion: ((Bool) -> ())?) {
        switch AVAudioSession.sharedInstance().recordPermission() {
        case AVAudioSessionRecordPermission.denied:
            Alerts.showAlert("Error", message: Alerts.RecordingDisabledMessage, presentingViewController: self)
            completion?(false)
        case AVAudioSessionRecordPermission.undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission({ isPermitted in
                if !isPermitted {
                    Alerts.showAlert("Error", message: Alerts.RecordingDisabledMessage, presentingViewController: self)
                    completion?(false)
                } else {
                    completion?(true)
                }
            })
        default:
            completion?(true)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        performSegue(withIdentifier: PlayerViewSID, sender: nil)
    }
}
