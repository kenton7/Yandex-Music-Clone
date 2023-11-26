//
//  MoreInYourCollectionViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 25.11.2023.
//

import UIKit

class MoreInYourCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "MoreInYourCollectionViewCell"
    
    let playlistTypes = [
        "Плейлисты",
        "Скачанное",
        "Альбомы",
        "Детям",
        "Аудиокниги",
        "Подкасты"
    ]
    
    lazy var playlistTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Плейлист"
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    lazy var informationAboutPlaylistLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "3 часа"
        label.textAlignment = .left
        label.textColor = .lightGray
        label.font = .boldSystemFont(ofSize: 9)
        return label
    }()
    
    lazy var imageView1 = createImageView()
    lazy var imageView2 = createImageView()
    lazy var imageView3 = createImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return imageView
    }
    
    private func configure() {
        layer.cornerRadius = 12
        addSubview(imageView3)
        addSubview(imageView2)
        addSubview(imageView1)
        addSubview(playlistTypeLabel)
        addSubview(informationAboutPlaylistLabel)
        
        NSLayoutConstraint.activate([
            playlistTypeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            playlistTypeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            imageView3.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageView3.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            imageView2.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            imageView2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            imageView1.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            imageView1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            
            informationAboutPlaylistLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            informationAboutPlaylistLabel.topAnchor.constraint(equalTo: playlistTypeLabel.bottomAnchor, constant: 10),
            informationAboutPlaylistLabel.trailingAnchor.constraint(equalTo: imageView1.leadingAnchor, constant: -5),
            informationAboutPlaylistLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
}
