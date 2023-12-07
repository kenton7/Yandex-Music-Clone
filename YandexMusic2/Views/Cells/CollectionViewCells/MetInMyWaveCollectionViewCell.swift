//
//  MetInMyWaveCollectionViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 07.12.2023.
//

import UIKit

class MetInMyWaveCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "MetInMyWaveCollectionViewCell"
    
    lazy var artistImage: UIImageView = {
       let view = UIImageView()
        view.frame = CGRect(x: 10, y: 20, width: 100, height: 100)
        view.layer.cornerRadius = view.frame.width / 2
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var artistName: UILabel = {
       let label = UILabel()
        label.text = "Artist"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(artistImage)
        contentView.addSubview(artistName)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        NSLayoutConstraint.activate([
            artistName.centerXAnchor.constraint(equalTo: artistImage.centerXAnchor),
            artistName.topAnchor.constraint(equalTo: artistImage.bottomAnchor, constant: 10)
        ])
    }
}
