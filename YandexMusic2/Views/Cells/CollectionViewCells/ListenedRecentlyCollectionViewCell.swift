//
//  ListenedRecentlyCollectionViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 30.10.2023.
//

import UIKit

class ListenedRecentlyCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "ListenedRecentlyCollectionViewCell"
    
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
        label.font = UIFont(name: "YandexSansText-Medium", size: 15)
        label.textColor = .white
        return label
    }()
    
    lazy var songAuthorName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "YandexSansText-Medium", size: 15)
        label.textColor = .lightGray
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        insertSubview(playlistImage, at: 1)
        insertSubview(playListOrSongNameLabel, at: 1)
        insertSubview(songAuthorName, at: 1)
        
//        addSubview(playlistImage)
//        addSubview(playListOrSongNameLabel)
//        addSubview(songAuthorName)
        
        NSLayoutConstraint.activate([
            playlistImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            playlistImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            playlistImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            playlistImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            playListOrSongNameLabel.topAnchor.constraint(equalTo: playlistImage.bottomAnchor, constant: 5),
            playListOrSongNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            playListOrSongNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            songAuthorName.topAnchor.constraint(equalTo: playListOrSongNameLabel.bottomAnchor, constant: 5),
            songAuthorName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            songAuthorName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
