//
//  FavouriteArtistsCollectionViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 25.11.2023.
//

import UIKit

class FavouriteArtistsCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "FavouriteArtistsCollectionViewCell"
    
    lazy var artistsImages: UIImageView = {
       let view = UIImageView()
        view.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        view.layer.cornerRadius = view.frame.width / 2
        view.backgroundColor = .green
        return view
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
    }
    
}
