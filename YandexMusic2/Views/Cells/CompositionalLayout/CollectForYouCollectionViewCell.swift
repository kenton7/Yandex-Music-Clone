//
//  CollectForYouCollectionViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 19.12.2023.
//

import UIKit

class CollectForYouCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "CollectForYouCollectionViewCell"
    
    let images: [UIImage] = [UIImage(named: "Premier")!,
                                     UIImage(named: "Dejavu")!,
                                     UIImage(named: "Tainik")!,
                                     UIImage(named: "PlaylistOfTheDay")!
    ]
    
    let playlistNames = ["Премьера", "Дежавю", "Тайник", "Плейлист дня"]
    
    let descriptionPlaylist = [
        "Открывает вам главные новинки",
        "Знакомит с тем, что вы ещё не слушали",
        "Достаёт забытое из вашей коллекции",
        "Звучит по-вашему каждый день"
    ]
    
    lazy var playlistImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 180, height: 180)
        imageView.layer.cornerRadius = 10
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
        
//        insertSubview(playlistImage, at: 1)
//        insertSubview(playlistNameLabel, at: 1)
//        insertSubview(descriptionLabel, at: 1)
        
        addSubview(playlistImage)
        addSubview(playlistNameLabel)
        addSubview(descriptionLabel)
        
        backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            playlistImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            playlistImage.topAnchor.constraint(equalTo: topAnchor),
            playlistImage.heightAnchor.constraint(equalToConstant: 180),
            playlistImage.widthAnchor.constraint(equalToConstant: 180),
            
            playlistNameLabel.topAnchor.constraint(equalTo: playlistImage.bottomAnchor, constant: 5),
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
