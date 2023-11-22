//
//  MainChildCollectForYouCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 30.10.2023.
//

import UIKit

class MainChildCollectForYouCell: UICollectionViewCell {
    
    static let cellID = "MainChildCollectForYouCell"
    
    lazy var playlistImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var playlistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.font = UIFont.boldSystemFont(ofSize: 15)
        label.font = UIFont(name: "YandexSansText-Medium", size: 14)
        label.text = "Премьера"
        label.textColor = .white
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "YandexSansText-Medium", size: 15)
        label.text = "Открывает вам главные новинки"
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        insertSubview(playlistImage, at: 1)
        insertSubview(playlistNameLabel, at: 1)
        insertSubview(descriptionLabel, at: 1)
//        addSubview(playlistImage)
//        addSubview(playlistNameLabel)
//        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            playlistImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            playlistImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            playlistImage.topAnchor.constraint(equalTo: topAnchor),
            playlistImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            playlistNameLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            playlistNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            playlistNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: playlistNameLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
