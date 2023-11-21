//
//  NewReleasesTableViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 02.11.2023.
//

import UIKit

class NewReleasesTableViewCell: UITableViewCell {
    
    static let cellID = "NewReleasesTableViewCell"
    
    private let dataImages: [UIImage] = [
        UIImage(named: "NewReleaseNiletto&Svik")!,
        UIImage(named: "NewReleaseZivert")!,
        UIImage(named: "NewReleaseINNA")!,
        UIImage(named: "NewReleaseLOne")!,
        UIImage(named: "NewReleaseArtikAsti")!,
        UIImage(named: "ThreeDaysRain")!,
        UIImage(named: "NewReleaseMaruv")!,
        UIImage(named: "NewReleaseMinelli")!,
        UIImage(named: "NewReleaseNebenzao")!,
        UIImage(named: "NewReleaseOniel")!
    ]
    
    private let playlistNames = ["Зеркала", "В МИРЕ ВЕСЁЛЫХ", "Dance Alone", "Постправда", "Вселенная", "melancholia", "Love Songs", "No Tears", "Love Story", "Take Control"
    ]
    
    private let songAuthors = [
        "Лёша Свик, NILETTO", "Zivert", "INNA", "L'One", "Artik & Asti", "Три дня дождя", "Maruv", "Minelli", "Nebezao, NOLA", "ONIEL, KANVISE, Aize"
    ]
    
    private let typeOfRelease = [
        "сингл", "", "сингл", "сингл", "сингл", "", "", "сингл", "сингл", "сингл"
    ]

    
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
        collectionView.register(NewReleasesCollectionViewCell.self, forCellWithReuseIdentifier: NewReleasesCollectionViewCell.cellID)
        return collectionView
    }()
    
    private lazy var newReleasesLabel: UILabel = {
        let label = UILabel()
        label.text = "Новые релизы"
        label.font = UIFont(name: "YandexSansText-Medium", size: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var seeMoreButton: UIButton = {
       let button = UIButton()
        button.setTitle("Смотреть всё", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        contentView.isUserInteractionEnabled = false
        selectionStyle = .none
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(collectionView)
        addSubview(newReleasesLabel)
        addSubview(seeMoreButton)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 330),
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: -25),
            
            newReleasesLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            seeMoreButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            seeMoreButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 5)
        ])
    }

}

extension NewReleasesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataImages.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewReleasesCollectionViewCell.cellID, for: indexPath) as! NewReleasesCollectionViewCell
        cell.playlistImage.image = dataImages[indexPath.item]
        cell.playListOrSongNameLabel.text = playlistNames[indexPath.item]
        cell.songAuthorName.text = songAuthors[indexPath.item]
        cell.typeOfReleaseLabel.text = typeOfRelease[indexPath.item] == "" ? "\(typeOfRelease[indexPath.item] + "2023")" : "\(typeOfRelease[indexPath.item] + " • 2023")"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
    
    
}
