//
//  AllMyTracksCollectionViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 18.12.2023.
//

import UIKit
import Lottie

class AllMyTracksCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "AllMyTracksCollectionViewCell"
    
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
    
    lazy var songImage: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.backgroundColor = .red
        return view
    }()
    
    lazy var songName: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "YandexSansText-Medium", size: 15)
        label.textColor = .white
        label.text = "Название песни"
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    lazy var songAuthor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "YandexSansText-Medium", size: 13)
        label.textColor = .lightGray
        label.text = "Имя артиста"
        return label
    }()
    
    private lazy var stackViewForSongInfo: UIStackView = {
       let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        return view
    }()
    
    lazy var explicitImageView: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: "explicit")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.isHidden = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        

        backgroundColor = .black
        contentView.addSubview(moreButton)
        contentView.addSubview(songImage)
        contentView.addSubview(songName)
        contentView.addSubview(songAuthor)
        contentView.addSubview(stackViewForSongInfo)
        contentView.addSubview(explicitImageView)
        stackViewForSongInfo.addArrangedSubview(songName)
        stackViewForSongInfo.addArrangedSubview(songAuthor)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        NSLayoutConstraint.activate([
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            moreButton.heightAnchor.constraint(equalToConstant: 15),
            moreButton.widthAnchor.constraint(equalToConstant: 15),
            moreButton.centerYAnchor.constraint(equalTo: stackViewForSongInfo.centerYAnchor),
            
            songImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            songImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            songImage.heightAnchor.constraint(equalToConstant: 50),
            songImage.widthAnchor.constraint(equalToConstant: 50),
            
            stackViewForSongInfo.leadingAnchor.constraint(equalTo: songImage.trailingAnchor, constant: 10),
            stackViewForSongInfo.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackViewForSongInfo.trailingAnchor.constraint(equalTo: moreButton.leadingAnchor, constant: -10),
            
            explicitImageView.trailingAnchor.constraint(equalTo: moreButton.leadingAnchor, constant: -10),
            explicitImageView.heightAnchor.constraint(equalToConstant: 15),
            explicitImageView.widthAnchor.constraint(equalToConstant: 15),
            explicitImageView.centerYAnchor.constraint(equalTo: stackViewForSongInfo.centerYAnchor)
        ])
        
    }
}
