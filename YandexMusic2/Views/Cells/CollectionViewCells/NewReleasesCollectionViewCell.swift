//
//  NewReleasesCollectionViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 02.11.2023.
//

import UIKit

class NewReleasesCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "NewReleasesCollectionViewCell"
    
    lazy var playlistImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var playListOrSongNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "YandexSansText-Medium", size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    lazy var songAuthorName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "YandexSansText-Medium", size: 14)
        label.textColor = .lightGray
        return label
    }()
    
    lazy var typeOfReleaseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "YandexSansText-Medium", size: 14)
        label.textColor = .lightGray
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
        
        addSubview(playlistImage)
        addSubview(playListOrSongNameLabel)
        addSubview(songAuthorName)
        addSubview(typeOfReleaseLabel)
        
        NSLayoutConstraint.activate([
            playlistImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            playlistImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            playlistImage.topAnchor.constraint(equalTo: topAnchor),
            playlistImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            playListOrSongNameLabel.topAnchor.constraint(equalTo: playlistImage.bottomAnchor, constant: 5),
            playListOrSongNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            playListOrSongNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            songAuthorName.topAnchor.constraint(equalTo: playListOrSongNameLabel.bottomAnchor, constant: 5),
            songAuthorName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            songAuthorName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            typeOfReleaseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            typeOfReleaseLabel.topAnchor.constraint(equalTo: songAuthorName.bottomAnchor)
        ])
    }
    
}
