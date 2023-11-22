//
//  SongsCollectionViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 13.10.2023.
//

import UIKit

class SongsCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "SongsCollectionViewCell"
    
    var songImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(songImage)
        contentView.layer.cornerRadius = 20
        NSLayoutConstraint.activate([
            songImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            songImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            songImage.heightAnchor.constraint(equalToConstant: 270),
            songImage.widthAnchor.constraint(equalToConstant: 270)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 20
    }
}
