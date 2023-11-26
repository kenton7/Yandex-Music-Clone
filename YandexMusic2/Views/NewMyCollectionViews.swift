//
//  NewMyCollectionViews.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 25.11.2023.
//

import UIKit
import Lottie

class NewMyCollectionViews: MiniPlayerView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(ILikeTableViewCell.self, forCellReuseIdentifier: ILikeTableViewCell.cellID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        return tableView
    }()
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .black
        
        addSubview(tableView)
        addSubview(miniPlayer)
        miniPlayer.addSubview(miniPlayerCollectionView)
        
//        addSubview(likeButtonMiniPlayer)
//        addSubview(songName)
//        addSubview(songAuthor)
//        addSubview(changeSourcePlayingMiniPlayer)
//        addSubview(playPauseButtonMiniPlayer)
//        addSubview(sliderOnMiniPlayer)
        addSubview(trackPlayingAnimation)
        
        NSLayoutConstraint.activate([
            
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            miniPlayer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            miniPlayer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            miniPlayer.heightAnchor.constraint(equalToConstant: 65),
            miniPlayer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            miniPlayerCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            miniPlayerCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            miniPlayerCollectionView.centerYAnchor.constraint(equalTo: miniPlayer.centerYAnchor),
            miniPlayerCollectionView.heightAnchor.constraint(equalToConstant: 50),
            
//            likeButtonMiniPlayer.leadingAnchor.constraint(equalTo: miniPlayer.leadingAnchor, constant: 10),
//            likeButtonMiniPlayer.topAnchor.constraint(equalTo: miniPlayer.topAnchor, constant: 10),
//            likeButtonMiniPlayer.centerYAnchor.constraint(equalTo: miniPlayer.centerYAnchor),
//            
//            songName.leadingAnchor.constraint(equalTo: likeButtonMiniPlayer.trailingAnchor, constant: 10),
//            songName.topAnchor.constraint(equalTo: miniPlayer.topAnchor, constant: 5),
//            songAuthor.leadingAnchor.constraint(equalTo: likeButtonMiniPlayer.trailingAnchor, constant: 10),
//            songAuthor.bottomAnchor.constraint(equalTo: likeButtonMiniPlayer.bottomAnchor, constant: 5),
//            
//            playPauseButtonMiniPlayer.trailingAnchor.constraint(equalTo: miniPlayer.trailingAnchor, constant: -10),
//            playPauseButtonMiniPlayer.centerYAnchor.constraint(equalTo: miniPlayer.centerYAnchor),
//            
//            changeSourcePlayingMiniPlayer.trailingAnchor.constraint(equalTo: playPauseButtonMiniPlayer.leadingAnchor, constant: -20),
//            changeSourcePlayingMiniPlayer.centerYAnchor.constraint(equalTo: miniPlayer.centerYAnchor),
//            
//            sliderOnMiniPlayer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -2),
//            sliderOnMiniPlayer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2),
//            sliderOnMiniPlayer.bottomAnchor.constraint(equalTo: miniPlayer.topAnchor, constant: 0)
        ])
    }
}
