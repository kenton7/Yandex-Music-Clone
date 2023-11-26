//
//  FavouriteArtistsCollectionViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 25.11.2023.
//

import UIKit

class FavouriteArtistsCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "FavouriteArtistsCollectionViewCell"
    
    lazy var artsts = [
        "Thirty Seconds To Mars",
        "Та Сторона",
        "Oxxxymiron",
        "Lx24",
        "Nickelback",
        "Loc Dog",
        "Лёша Свик",
        "Muse"
    ]
    
    lazy var artistsImages: UIImageView = {
       let view = UIImageView()
        view.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        view.layer.cornerRadius = view.frame.width / 2
        view.clipsToBounds = true
        view.backgroundColor = .green
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var artistLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Test"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
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
        addSubview(artistsImages)
        addSubview(artistLabel)
        
        NSLayoutConstraint.activate([
            artistLabel.topAnchor.constraint(equalTo: artistsImages.bottomAnchor, constant: 10),
            artistLabel.widthAnchor.constraint(equalToConstant: artistsImages.frame.width),
            artistLabel.centerXAnchor.constraint(equalTo: artistsImages.centerXAnchor),
        ])
    }
    
}
