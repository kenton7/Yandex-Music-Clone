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
    
    lazy var miniPlayerCollectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        //layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.layer.cornerRadius = 8
        collectionView.register(MiniPlayerCollectionViewCell.self, forCellWithReuseIdentifier: MiniPlayerCollectionViewCell.cellID)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        insertSubview(miniPlayer, at: 1)
        //insertSubview(miniPlayerCollectionView, at: 2)
        miniPlayer.addSubview(miniPlayerCollectionView)
        
        
        NSLayoutConstraint.activate([
            
            miniPlayer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            miniPlayer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            miniPlayer.heightAnchor.constraint(equalToConstant: 65),
            miniPlayer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            
            miniPlayerCollectionView.leadingAnchor.constraint(equalTo: miniPlayer.leadingAnchor, constant: 10),
            miniPlayerCollectionView.trailingAnchor.constraint(equalTo: miniPlayer.trailingAnchor, constant: -10),
            miniPlayerCollectionView.centerYAnchor.constraint(equalTo: miniPlayer.centerYAnchor),
            miniPlayerCollectionView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

