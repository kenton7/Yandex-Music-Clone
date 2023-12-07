//
//  CollectForYouCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 07.12.2023.
//

import UIKit

class CollectForYouCell: UITableViewCell {

    static let cellID = "CollectForYouCell"
    
    private let images: [UIImage] = [UIImage(named: "Premier")!,
                                     UIImage(named: "Dejavu")!,
                                     UIImage(named: "Tainik")!,
                                     UIImage(named: "PlaylistOfTheDay")!
    ]
    
    private let playlistNames = ["Премьера", "Дежавю", "Тайник", "Плейлист дня"]
    
    private let descriptionPlaylist = [
        "Открывает вам главные новинки",
        "Знакомит с тем, что вы ещё не слушали",
        "Достаёт забытое из вашей коллекции",
        "Звучит по-вашему каждый день"
    ]
    
    lazy var collectForYouLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Собираем для вас"
        label.font = UIFont(name: "YandexSansText-Medium", size: 18)
        label.textColor = .white
        label.textAlignment = .center
        //label.isHidden = true
        return label
    }()
    
    lazy var forYouCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainChildCollectForYouCell.self, forCellWithReuseIdentifier: MainChildCollectForYouCell.cellID)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        selectionStyle = .none
        contentView.isUserInteractionEnabled = false
        
        insertSubview(forYouCollectionView, at: 1)
        insertSubview(collectForYouLabel, at: 1)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        NSLayoutConstraint.activate([
            forYouCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            forYouCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            forYouCollectionView.heightAnchor.constraint(equalToConstant: 350),
            forYouCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: -40),
            collectForYouLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectForYouLabel.topAnchor.constraint(equalTo: topAnchor)
        ])
        
    }
}

extension CollectForYouCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainChildCollectForYouCell.cellID, for: indexPath) as! MainChildCollectForYouCell
        cell.playlistImage.image = images[indexPath.item]
        cell.playlistNameLabel.text = playlistNames[indexPath.item]
        cell.descriptionLabel.text = descriptionPlaylist[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
    
}
