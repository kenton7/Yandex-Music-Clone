//
//  FavouriteArtistsTableViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 25.11.2023.
//

import UIKit

class FavouriteArtistsTableViewCell: UITableViewCell {
    
    static let cellID = "FavouriteArtistsTableViewCell"
    
    private let favouriteArtistsImages: [UIImage] = [
        UIImage(named: "ThirtySecondsToMars")!,
        UIImage(named: "ТаСторона")!,
        UIImage(named: "OxxxymironFavourite")!,
        UIImage(named: "Lx24")!,
        UIImage(named: "Nickelback")!,
        UIImage(named: "LocDog")!,
        UIImage(named: "Лёша Свик")!,
        UIImage(named: "Muse")!
    ]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        collectionView.register(FavouriteArtistsCollectionViewCell.self, forCellWithReuseIdentifier: FavouriteArtistsCollectionViewCell.cellID)
        return collectionView
    }()
    
    private lazy var favouriteArtistsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Любимые исполнители"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .black
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.isUserInteractionEnabled = false
        
        addSubview(collectionView)
        addSubview(favouriteArtistsLabel)
        
        NSLayoutConstraint.activate([
            
            favouriteArtistsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: favouriteArtistsLabel.bottomAnchor, constant: 20),
            collectionView.heightAnchor.constraint(equalToConstant: 130)
        ])
    }

}

extension FavouriteArtistsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouriteArtistsCollectionViewCell.cellID, for: indexPath) as! FavouriteArtistsCollectionViewCell
        cell.artistsImages.image = favouriteArtistsImages[indexPath.item]
        cell.artistLabel.text = cell.artsts[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 200)
    }
}
