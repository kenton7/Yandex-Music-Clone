//
//  MiniPlayerCollectionViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 26.11.2023.
//

import UIKit

class MiniPlayerCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "MiniPlayerCollectionViewCell"
    
    lazy var trackImage: UIImageView = {
       let view = UIImageView(frame: CGRect(x: 10, y: 10, width: 40, height: 40))
        view.center.y = self.center.y
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    lazy var sliderOnMiniPlayer: UISlider = {
        let songSlider = UISlider()
        songSlider.frame = CGRect(x: 0, y: 0, width: 200, height: 5)
        songSlider.layer.cornerRadius = 15
        songSlider.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        songSlider.clipsToBounds = true
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
    
    lazy var playPauseButtonMiniPlayer: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold, scale: .large)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.fill", withConfiguration: config), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    lazy var likeButtonMiniPlayer: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: "heart.fill", withConfiguration: config), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemYellow
        return button
    }()
    
    lazy var songAuthor: UILabel = {
        let label = UILabel()
        label.text = UserDefaults.standard.string(forKey: "trackArtist")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont(name: "YandexSansText-Medium", size: 13)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        layer.cornerRadius = 8
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = bounds
        addSubview(blurView)
        blurView.layer.cornerRadius = 10
        blurView.clipsToBounds = true
        
        layer.cornerRadius = 10
        addSubview(trackImage)
        addSubview(sliderOnMiniPlayer)
        addSubview(playPauseButtonMiniPlayer)
        addSubview(likeButtonMiniPlayer)
        addSubview(songName)
        addSubview(songAuthor)
        
        NSLayoutConstraint.activate([
            
            sliderOnMiniPlayer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            sliderOnMiniPlayer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            sliderOnMiniPlayer.bottomAnchor.constraint(equalTo: topAnchor, constant: 0),
            
            playPauseButtonMiniPlayer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            playPauseButtonMiniPlayer.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            likeButtonMiniPlayer.trailingAnchor.constraint(equalTo: playPauseButtonMiniPlayer.leadingAnchor, constant: -20),
            likeButtonMiniPlayer.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            songAuthor.leadingAnchor.constraint(equalTo: trackImage.trailingAnchor, constant: 8),
            songAuthor.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            songName.leadingAnchor.constraint(equalTo: songAuthor.leadingAnchor),
            songName.bottomAnchor.constraint(equalTo: songAuthor.topAnchor, constant: 0)
        ])
    }
    
}
