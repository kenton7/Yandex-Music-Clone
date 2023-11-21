//
//  PopularPlaylistsCollectionViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 05.11.2023.
//

import UIKit

class PopularPlaylistsCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "PopularPlaylistsCollectionViewCell"
    
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
        label.font = UIFont(name: "YandexSansText-Medium", size: 13)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var likePlaylistImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .lightGray
        image.image = UIImage(systemName: "heart")
        return image
    }()
    
    lazy var likesCount: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "YandexSansText-Medium", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(likePlaylistImageView)
        addSubview(likesCount)
        
        NSLayoutConstraint.activate([
            playlistImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            playlistImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            playlistImage.topAnchor.constraint(equalTo: topAnchor),
            playlistImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            playListOrSongNameLabel.topAnchor.constraint(equalTo: playlistImage.bottomAnchor, constant: 5),
            playListOrSongNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            playListOrSongNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            likePlaylistImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            likePlaylistImageView.topAnchor.constraint(equalTo: playListOrSongNameLabel.bottomAnchor, constant: 5),
            
            likesCount.leadingAnchor.constraint(equalTo: likePlaylistImageView.trailingAnchor, constant: 5),
            likesCount.topAnchor.constraint(equalTo: playListOrSongNameLabel.bottomAnchor, constant: 5),
            likesCount.centerYAnchor.constraint(equalTo: likePlaylistImageView.centerYAnchor),
        ])
    }
    
}
