//
//  NeuroMusicCollectionViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 06.11.2023.
//

import UIKit

class NeuroMusicCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "NeuroMusicCollectionViewCell"
    
    lazy var playImageView: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "play.circle")
        view.contentMode = .scaleAspectFit
        view.tintColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    lazy var neuroMusicTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "YandexSansText-Medium", size: 14)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(playImageView)
        addSubview(neuroMusicTitleLabel)
        
        NSLayoutConstraint.activate([
            playImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            playImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            playImageView.heightAnchor.constraint(equalToConstant: 25),
            playImageView.widthAnchor.constraint(equalToConstant: 25),
            
            neuroMusicTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            neuroMusicTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
}
