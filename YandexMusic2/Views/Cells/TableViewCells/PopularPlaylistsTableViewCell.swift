//
//  PopularPlaylistsTableViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 05.11.2023.
//

import UIKit

class PopularPlaylistsTableViewCell: UITableViewCell {
    
    static let cellID = "PopularPlaylistsTableViewCell"
    
    private let popularPlaylistsArrray: [UIImage] = [
        UIImage(named: "Hits")!,
        UIImage(named: "AutumnNew")!,
        UIImage(named: "New")!,
        UIImage(named: "NewHits")!,
        UIImage(named: "NewRussianPop")!,
        UIImage(named: "TopRecongizes")!,
        UIImage(named: "Superhits")!,
        UIImage(named: "InHeart")!,
        UIImage(named: "EternalHits")!,
        UIImage(named: "100RussianHits")!,
    ]
    
    private let playlistNames: [String] = [
        "Хиты FM",
        "Осенние новинки",
        "Громкие новинки месяца",
        "Новые хиты",
        "Новые хиты русской поп-музыки",
        "Топ распознаваний",
        "100 суперхитов",
        "В сердечке",
        "Вечные хиты",
        "100 хитов русской поп-музыки"
    ]
    
    private let likesCount = [528_525, 112_670, 519_374, 224_864, 50_340, 113_349, 399_695, 195_948, 687_697, 229_132]
    
    private lazy var popularPlaylistsLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Популярные плейлисты"
        label.textColor = .white
        label.font = UIFont(name: "YandexSansText-Medium", size: 18)
        return label
    }()
    
    private lazy var seeMoreButton: UIButton = {
       let button = UIButton()
        button.setTitle("Смотреть всё", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PopularPlaylistsCollectionViewCell.self, forCellWithReuseIdentifier: PopularPlaylistsCollectionViewCell.cellID)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
     configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .clear
        contentView.isUserInteractionEnabled = true
        selectionStyle = .none
        
        addSubview(collectionView)
        addSubview(popularPlaylistsLabel)
        addSubview(seeMoreButton)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 300),
            //collectionView.bottomAnchor.constraint(equalTo: seeMoreButton.topAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: popularPlaylistsLabel.bottomAnchor, constant: -25),
            
            popularPlaylistsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            seeMoreButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            seeMoreButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 5)
        ])
    }

}

extension PopularPlaylistsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularPlaylistsArrray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularPlaylistsCollectionViewCell.cellID, for: indexPath) as! PopularPlaylistsCollectionViewCell
        cell.playlistImage.image = popularPlaylistsArrray[indexPath.item]
        cell.playListOrSongNameLabel.text = playlistNames[indexPath.item]
        cell.likesCount.text = "\(likesCount[indexPath.item])"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
    
    
}
