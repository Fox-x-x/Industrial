//
//  MusicViewController.swift
//  Navigation
//
//  Created by Pavel Yurkov on 14.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation

class MusicViewController: UIViewController {
    
    weak var flowCoordinator: FeedCoordinator?
    
    private var songs = ["Кувалда — Бетономешалка",
                         "Metallica — Enter Sandman",
                         "Nirvana — Come as You Are",
                         "Imagine Dragond - Whatever it takes",
                         "The Pretty Reckless — Just Tonight"
    ]
    
    private lazy var Player = AVAudioPlayer()
    private lazy var currentTrack = 0
    private lazy var displayLink = CADisplayLink(target: self, selector: #selector(updateSongProgressBar))
    
    private lazy var logoView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "music")
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var bandAndSongNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.textColor = .black
        label.textAlignment = .center
        label.sizeToFit()
        label.text = "Nirvana - Come as you are"
        return label
    }()
    
    private lazy var songProgressBar: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        view.trackTintColor = .systemGray
        view.progressTintColor = .systemBlue
        return view
    }()
    
    private lazy var controlsView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var previousTrackButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "backward.end.alt.fill"), for: .normal)
        button.tintColor = .systemGray
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(previousTrackButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .systemGray
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var stopButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "stop.fill"), for: .normal)
        button.tintColor = .systemGray
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(stopButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextTrackButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "forward.end.alt.fill"), for: .normal)
        button.tintColor = .systemGray
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(nextTrackButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupLayout()
        
        configurePlayer(with: songs[currentTrack])
        displayLink.add(to: .current, forMode: .common)
        Player.delegate = self
    }
    
    private func configurePlayer(with song: String) {
        do {
            let _ = try prepareToPlay(song: song)
        } catch ApiError.songNotFound {
            handleApiError(error: ApiError.songNotFound, vc: self)
        } catch {
            handleApiError(error: ApiError.other, vc: self)
        }
    }
    
    private func isAbleToPlay(song: String) -> Bool {
        do {
            let _ = try prepareToPlay(song: song)
            return true
        } catch {
            return false
        }
    }
    
    private func prepareToPlay(song: String) throws {
        bandAndSongNameLabel.text = song
        if let songPath = Bundle.main.path(forResource: song, ofType: "mp3") {
            do {
                Player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: songPath))
                Player.prepareToPlay()
                playButton.isEnabled = true
            }
            catch {
                print(error)
                playButton.isEnabled = false
                throw ApiError.other
            }
        } else {
            print("song not found")
            playButton.isEnabled = false
            throw ApiError.songNotFound
        }
        
    }
    
    private func rewind(to track: Int) {
        if Player.isPlaying {
            if isAbleToPlay(song: songs[track]) {
                configurePlayer(with: songs[track])
                bandAndSongNameLabel.text = songs[track]
                playButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
                Player.play()
            } else {
                Player.stop()
                playButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
                handleApiError(error: .songNotFound, vc: self)
            }
        } else {
            configurePlayer(with: songs[track])
            bandAndSongNameLabel.text = songs[track]
        }
    }
    
    @objc private func previousTrackButtonPressed() {
        print("prev")
        currentTrack = currentTrack - 1
        if currentTrack < 0 {
            currentTrack = songs.count - 1
        }
        rewind(to: currentTrack)
    }
    
    @objc private func playButtonPressed() {
        if Player.isPlaying {
            Player.pause()
            playButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        else {
            Player.play()
            playButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    @objc private func stopButtonPressed() {
        print("stop")
        if Player.isPlaying {
            Player.stop()
        }
        else {
            print("Already stopped!")
        }
        Player.currentTime = 0
        playButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
    @objc private func nextTrackButtonPressed() {
        print("next")
        currentTrack = currentTrack + 1
        if currentTrack >= songs.count {
            currentTrack = 0
        }
        rewind(to: currentTrack)
    }
    
    @objc func updateSongProgressBar() {
        let currentTime = Player.currentTime
        let totalTime = Player.duration
        let progress = currentTime / totalTime
        songProgressBar.setProgress(Float(progress), animated: true)
    }
    
    private func setupLayout() {
        
        let buttonSize = 30
        let buttonOffset = 16
        
        view.addSubviews(logoView, contentView)
        contentView.addSubviews(bandAndSongNameLabel, songProgressBar, controlsView)
        controlsView.addSubviews(previousTrackButton, playButton, stopButton, nextTrackButton)
        
        contentView.backgroundColor = .systemGray6
        bandAndSongNameLabel.backgroundColor = .systemGray6
        controlsView.backgroundColor = .systemGray6
        
        logoView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(250)
            make.width.equalTo(250)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(logoView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(100)
        }
        
        bandAndSongNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(8)
            make.trailing.equalTo(contentView.snp.trailing).offset(-8)
            make.height.equalTo(16)
        }
        
        songProgressBar.snp.makeConstraints { (make) in
            make.top.equalTo(bandAndSongNameLabel.snp.bottom).offset(24)
            make.leading.equalTo(bandAndSongNameLabel.snp.leading)
            make.trailing.equalTo(bandAndSongNameLabel.snp.trailing)
            make.height.equalTo(0.5)
        }
        
        controlsView.snp.makeConstraints { (make) in
            make.top.equalTo(songProgressBar.snp.bottom).offset(16)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(buttonSize)
            make.width.equalTo(buttonSize * 4 + buttonOffset * 3)
        }
        
        previousTrackButton.snp.makeConstraints { (make) in
            make.top.equalTo(controlsView.snp.top)
            make.leading.equalTo(controlsView.snp.leading)
            make.height.equalTo(buttonSize)
            make.width.equalTo(buttonSize)
        }
        
        playButton.snp.makeConstraints { (make) in
            make.top.equalTo(controlsView.snp.top)
            make.leading.equalTo(previousTrackButton.snp.trailing).offset(buttonOffset)
            make.height.equalTo(buttonSize)
            make.width.equalTo(buttonSize)
        }
        
        stopButton.snp.makeConstraints { (make) in
            make.top.equalTo(controlsView.snp.top)
            make.leading.equalTo(playButton.snp.trailing).offset(buttonOffset)
            make.height.equalTo(buttonSize)
            make.width.equalTo(buttonSize)
        }
        
        nextTrackButton.snp.makeConstraints { (make) in
            make.top.equalTo(controlsView.snp.top)
            make.leading.equalTo(stopButton.snp.trailing).offset(buttonOffset)
            make.height.equalTo(buttonSize)
            make.width.equalTo(buttonSize)
        }
    }
}

extension MusicViewController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            print("finished!")
            Player.stop()
            Player.currentTime = 0
            playButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
}
