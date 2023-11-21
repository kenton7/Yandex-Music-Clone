//
//  SelectionsCollectionViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 06.11.2023.
//

import UIKit

class SelectionsCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "SelectionsCollectionViewCell"
    
    lazy var imagePlaylist: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.image = UIImage(named: "Hits")
        return view
    }()
    
    lazy var titlePlaylistLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "YandexSansText-Medium", size: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
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
                contentView.addSubview(imagePlaylist)
        //addSubview(titlePlaylistLabel)
        
        NSLayoutConstraint.activate([
            imagePlaylist.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imagePlaylist.topAnchor.constraint(equalTo: contentView.topAnchor),
            imagePlaylist.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imagePlaylist.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
    }
    
}
