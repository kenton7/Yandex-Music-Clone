//
//  AllMyTracksViews.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 10.11.2023.
//

import Foundation
import UIKit
import Lottie

class AllMyTracksViews: MiniPlayerView {
    
    lazy var trackPlayingAnimation: LottieAnimationView = {
        let animationView = LottieAnimationView()
        animationView.animation = LottieAnimation.named("TrackPlayingAnimation")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 2.5
        animationView.isHidden = true
        animationView.play()
        return animationView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setupMiniPlayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        addSubview(trackPlayingAnimation)
    }
    
    func setupMiniPlayer() {
        
        addSubview(miniPlayer)
        addSubview(likeButtonMiniPlayer)
        addSubview(songName)
        addSubview(songAuthor)
        addSubview(changeSourcePlayingMiniPlayer)
        addSubview(playPauseButtonMiniPlayer)
        addSubview(sliderOnMiniPlayer)
        
        NSLayoutConstraint.activate([
            
            miniPlayer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            miniPlayer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            miniPlayer.heightAnchor.constraint(equalToConstant: 40),
            miniPlayer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            likeButtonMiniPlayer.leadingAnchor.constraint(equalTo: miniPlayer.leadingAnchor, constant: 10),
            likeButtonMiniPlayer.topAnchor.constraint(equalTo: miniPlayer.topAnchor, constant: 10),
            likeButtonMiniPlayer.centerYAnchor.constraint(equalTo: miniPlayer.centerYAnchor),
            
            songName.leadingAnchor.constraint(equalTo: likeButtonMiniPlayer.trailingAnchor, constant: 10),
            songName.topAnchor.constraint(equalTo: miniPlayer.topAnchor, constant: 5),
            songAuthor.leadingAnchor.constraint(equalTo: likeButtonMiniPlayer.trailingAnchor, constant: 10),
            songAuthor.bottomAnchor.constraint(equalTo: likeButtonMiniPlayer.bottomAnchor, constant: 5),
            
            playPauseButtonMiniPlayer.trailingAnchor.constraint(equalTo: miniPlayer.trailingAnchor, constant: -10),
            playPauseButtonMiniPlayer.centerYAnchor.constraint(equalTo: miniPlayer.centerYAnchor),
            
            changeSourcePlayingMiniPlayer.trailingAnchor.constraint(equalTo: playPauseButtonMiniPlayer.leadingAnchor, constant: -20),
            changeSourcePlayingMiniPlayer.centerYAnchor.constraint(equalTo: miniPlayer.centerYAnchor),
            
            sliderOnMiniPlayer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -2),
            sliderOnMiniPlayer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2),
            sliderOnMiniPlayer.bottomAnchor.constraint(equalTo: miniPlayer.topAnchor, constant: 0)
        ])
    }
    
}
