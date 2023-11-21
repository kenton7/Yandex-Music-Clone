//
//  SelectionsTableViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 06.11.2023.
//

import UIKit

class SelectionsTableViewCell: UITableViewCell {
    
    static let cellID = "SelectionsTableViewCell"
    
    private let playlistImages: [UIImage] = [
        UIImage(named: "MorningInTheCity")!,
        UIImage(named: "Autumn")!,
        UIImage(named: "Trend")!,
        UIImage(named: "NewClips")!,
        UIImage(named: "RedacrorsChoise")!,
        UIImage(named: "WorkDays")!,
        UIImage(named: "Exclusives")!,
        UIImage(named: "100Hits")!,
        UIImage(named: "NewHitsSelection")!,
        UIImage(named: "EternalHitsSelection")!,
        UIImage(named: "TimeMachine")!,
        //UIImage(named: "BackgroundMusic")!
    ]
    
    private let playlistTitles = ["Утро в городе", "Осенняя", "В тренде", "Новинки клипов", "Выбор редакции", "Будничная", "Эксклюзивы", "100 хитов", "Новые хиты", "Вечные хиты", "Машина времени",/* "Послушать фоном"*/]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.layer.cornerRadius = 10
        collectionView.clipsToBounds = true
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.register(SelectionsCollectionViewCell.self, forCellWithReuseIdentifier: SelectionsCollectionViewCell.cellID)
        return collectionView
    }()
    
    private lazy var selectionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Подборки"
        label.font = UIFont(name: "YandexSansText-Medium", size: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.isUserInteractionEnabled = false
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(collectionView)
        contentView.addSubview(selectionsLabel)
                
        NSLayoutConstraint.activate([
            selectionsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -10),
            selectionsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: selectionsLabel.bottomAnchor, constant: 10),
            collectionView.heightAnchor.constraint(equalTo: heightAnchor),
        ])
    }
    
}

extension SelectionsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlistImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectionsCollectionViewCell.cellID, for: indexPath) as! SelectionsCollectionViewCell
        cell.imagePlaylist.image = playlistImages[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2 // кол-во ячеек в строке
        let sectionInsets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        
        let interItemSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? .zero
        
        let width = collectionView.frame.width - CGFloat((numberOfColumns - 1)) * interItemSpacing - sectionInsets.left - sectionInsets.right
        
        let itemWidth = floor(width / numberOfColumns)
                    
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}
