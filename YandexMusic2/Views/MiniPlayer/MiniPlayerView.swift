//
//  MiniPlayerView.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 11.11.2023.
//

import UIKit

class MiniPlayerView: UIView {
    
    static let shared = MiniPlayerView()
    
    lazy var miniPlayer: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        //blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurView)
        blurView.frame = view.bounds
        return view
    }()
    
    lazy var sliderOnMiniPlayer: UISlider = {
        let songSlider = UISlider()
        songSlider.minimumValue = 0
        songSlider.setThumbImage(UIImage(), for: .normal)
        songSlider.minimumTrackTintColor = UIColor(red: 245/255, green: 209/255, blue: 100/255, alpha: 1)
        songSlider.maximumTrackTintColor = .darkGray
        songSlider.translatesAutoresizingMaskIntoConstraints = false
        songSlider.isUserInteractionEnabled = false
        songSlider.value = UserDefaults.standard.float(forKey: "valueSlider")
        songSlider.maximumValue = UserDefaults.standard.float(forKey: "maximumValue")
        return songSlider
    }()
    
    lazy var songAuthor: UILabel = {
        let label = UILabel()
        label.text = UserDefaults.standard.string(forKey: "trackArtist")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont(name: "YandexSansText-Medium", size: 12)
        label.text = UserDefaults.standard.string(forKey: "songAuthor")
        return label
    }()
    
    lazy var songName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = UserDefaults.standard.string(forKey: "songName")
        return label
    }()
    
    lazy var likeButtonMiniPlayer: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: "heart.fill", withConfiguration: config), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemYellow
        return button
    }()
    
    lazy var changeSourcePlayingMiniPlayer: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: "airpodsmax", withConfiguration: config), for: .normal)
        button.tintColor = .systemYellow
        return button
    }()
    
    lazy var playPauseButtonMiniPlayer: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold, scale: .large)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.fill", withConfiguration: config), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
                
        //addSubview(miniPlayer)
        addSubview(likeButtonMiniPlayer)
        addSubview(songName)
        addSubview(songAuthor)
        addSubview(changeSourcePlayingMiniPlayer)
        addSubview(playPauseButtonMiniPlayer)
        addSubview(sliderOnMiniPlayer)
        
        insertSubview(miniPlayer, at: 1)
        insertSubview(likeButtonMiniPlayer, at: 1)
        
        
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
