//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Sujal Ghosh on 18/12/16.
//  Copyright © 2016 Sujal. All rights reserved.
//

import UIKit

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(.notPlaying)
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAudio()
    }
    
    @IBAction func slow2xButtonAction(_ sender: Any) {
        configureUI(.playing)
        playSound(rate: 0.5, pitch: nil, echo: false, reverb: false)
    }
    
    @IBAction func fast2xButtonAction(_ sender: Any) {
        configureUI(.playing)
        playSound(rate: 2.0, pitch: nil, echo: false, reverb: false)
    }
    
    @IBAction func chipmunkButtonAction(_ sender: Any) {
        configureUI(.playing)
        playSound(rate: 1.0, pitch: 1200.0, echo: false, reverb: false)
    }
    
    @IBAction func darthvaderButtonAction(_ sender: Any) {
        configureUI(.playing)
        playSound(rate: 1.0, pitch: -1200.0, echo: false, reverb: false)
    }
    
    @IBAction func echoButtonAction(_ sender: Any) {
        configureUI(.playing)
        playSound(rate: 1.0, pitch: nil, echo: true, reverb: false)
    }
    
    @IBAction func reverbButtonAction(_ sender: Any) {
        configureUI(.playing)
        playSound(rate: 1.0, pitch: nil, echo: false, reverb: true)
    }
    
    @IBAction func stopPlayButtonAction(_ sender: Any) {
        stopAudio()
    }
}
