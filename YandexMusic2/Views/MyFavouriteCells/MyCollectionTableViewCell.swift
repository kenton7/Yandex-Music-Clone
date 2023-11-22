//
//  MyCollectionTableViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 15.10.2023.
//

import UIKit

enum LabelTitles: String, CaseIterable {
    case iLike = "Мне нравится"
    case tracks = "Треки"
    case albums = "Альбомы"
    case authors = "Исполнители"
    case playlists = "Плейлисты"
    case audiobooks = "Аудиокниги"
    case podcasts = "Подкасты"
    case forChildred = "Детям"
    case downloadedTracks = "Скачанные треки"
}

enum ImagesForRows: String, CaseIterable {
    case tracks = "music.note"
    case albums = "record.circle"
    case authors = "music.mic"
    case playlists = "list.triangle"
    case audiobooks = "books.vertical"
    case podcasts = "mic"
    case forChildren = "teddybear"
    case downloadedTracks = "arrow.down"
}

class MyCollectionTableViewCell: UITableViewCell {
    
    static let cellID = "MyCollectionTableViewCell"
    
    let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.right"))

    let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "YandexSansText-Medium", size: 15)
        label.textAlignment = .left
        return label
    }()
    
    let picturesForRows: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.tintColor = .lightGray
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.cornerRadius = 20
        selectionStyle = .none
        backgroundColor = .clear
        tintColor = .white
        //Используем стрелку вправо из SF Symbols, чтобы поменять ее цвет
        let image = UIImage(systemName: "chevron.right")
        let accessory  = UIImageView(frame:CGRect(x: 0, y: 0, width:(image?.size.width)!, height:(image?.size.height)!))
        accessory.image = image
        accessory.tintColor = UIColor.lightGray
        accessoryView = accessory
        configureViews()
    }
    
    private func configureViews() {
        addSubview(titleLabel)
        addSubview(picturesForRows)
        
        NSLayoutConstraint.activate([
            
            picturesForRows.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            picturesForRows.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            picturesForRows.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: picturesForRows.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: picturesForRows.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
