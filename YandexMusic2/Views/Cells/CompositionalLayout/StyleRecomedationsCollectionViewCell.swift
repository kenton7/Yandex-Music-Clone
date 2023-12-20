//
//  StyleRecomedationsCollectionViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 17.12.2023.
//

import UIKit

class StyleRecomedationsCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "StyleRecomedationsCollectionViewCell"
    
    let collectionImages: [UIImage] = [
        UIImage(named: "Sayonara боль")!,
        UIImage(named: "Кредо")!,
        UIImage(named: "Dabro")!,
        UIImage(named: "Ramil'")!,
        UIImage(named: "Celine")!,
        UIImage(named: "Dream")!,
        UIImage(named: "Post Malone")!,
        UIImage(named: "NewReleaseZivert")!
    ]
    
    let collectionArtists = [
        "Элджей",
        "GAYAZOV$ BROTHER$",
        "Dabro",
        "Ramil'",
        "The Limba",
        "EDWARD BIL",
        "Post Malone",
        "Zivert"
    ]
    
    let collectionSongNames = [
        "Sayonara bоль",
        "Кредо",
        "Юность. Deluxe Edition",
        "Молодой",
        "Celine",
        "Dream",
        "Hollywood's Bleeding",
        "В МИРЕ ВЕСЁЛЫХ"
    ]
    
    lazy var songImageView: UIImageView = {
        let view = UIImageView()
        view.frame = CGRect(x: 10, y: 10, width: 180, height: 180)
        view.image = UIImage(named: "NILETTO")
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var songName: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Song name"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var artistName: UILabel = {
        let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "Artist"
         label.font = .systemFont(ofSize: 16)
         label.textColor = .lightGray
         label.textAlignment = .left
         return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(songImageView)
        addSubview(songName)
        addSubview(artistName)
        
        backgroundColor = .clear
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        NSLayoutConstraint.activate([
            songImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            songImageView.topAnchor.constraint(equalTo: topAnchor),
            songImageView.heightAnchor.constraint(equalToConstant: 180),
            songImageView.widthAnchor.constraint(equalToConstant: 180),
            
            songName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            songName.topAnchor.constraint(equalTo: songImageView.bottomAnchor, constant: 8),
            artistName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            artistName.topAnchor.constraint(equalTo: songName.bottomAnchor, constant: 8)
        ])
        
    }
}
