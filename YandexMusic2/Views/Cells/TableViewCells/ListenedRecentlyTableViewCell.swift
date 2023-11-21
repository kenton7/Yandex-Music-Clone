//
//  ListenedRecentlyTableViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 30.10.2023.
//

import UIKit

class ListenedRecentlyTableViewCell: UITableViewCell {
    
    static let cellID = "ListenedRecentlyTableViewCell"
    
    private let images: [UIImage] = [
        UIImage(named: "Premier")!,
        UIImage(named: "iLikeImage")!,
        UIImage(named: "ThreeDaysRain")!,
        UIImage(named: "Hits")!,
        UIImage(named: "Oxxxymiron")!,
    ]
    
    private let playlistNames = ["Премьера", "Мне нравится", "melancholia", "Хиты", "Oxxxymiron"]
    private let songAuthors = ["", "", "Три дня дождя", "", ""]
    
    private lazy var listenedRecentlyLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы недавно слушали"
        label.font = UIFont(name: "YandexSansText-Medium", size: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        collectionView.register(ListenedRecentlyCollectionViewCell.self, forCellWithReuseIdentifier: ListenedRecentlyCollectionViewCell.cellID)
        return collectionView
    }()
    
    private lazy var trackImages: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        backgroundColor = .clear
        contentView.isUserInteractionEnabled = false
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        addSubview(collectionView)
        addSubview(listenedRecentlyLabel)
        addSubview(trackImages)
                
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 300),
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            listenedRecentlyLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

extension ListenedRecentlyTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListenedRecentlyCollectionViewCell.cellID, for: indexPath) as! ListenedRecentlyCollectionViewCell
        cell.playlistImage.image = images[indexPath.item]
        cell.playListOrSongNameLabel.text = playlistNames[indexPath.item]
        cell.songAuthorName.text = songAuthors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
    
}
