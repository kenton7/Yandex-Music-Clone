//
//  RecommendNewTableViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 07.12.2023.
//

import UIKit

class RecommendNewTableViewCell: UITableViewCell {
    
    static let cellID = "RecommendNewTableViewCell"
    
    private let recommendationsImages: [UIImage] = [
        UIImage(named: "Лёша Свик")!,
        UIImage(named: "Скриптонит")!,
        UIImage(named: "OxxxymironFavourite")!,
        UIImage(named: "NILETTO")!,
        UIImage(named: "Баста")!,
        UIImage(named: "Lx24")!,
        UIImage(named: "Илья Никко")!,
        UIImage(named: "T-killah")!,
        UIImage(named: "Краймбрери")!
    ]
    
    private let recommendationsSongNames = [
        "Замок из дождя",
        "YEAHH, Pt. 1",
        "Прекрасное Далёко",
        "Снова холодает",
        "Не забывай меня",
        "Бывшая (Чтоб ты стала пышная)",
        "Ранила",
        "Пустыня из золота",
        "Она опять разденется"
    ]
    
    private let recommendationSongImages: [UIImage] = [
        UIImage(named: "Замок из дождя")!,
        UIImage(named: "Yeahh. Pt. 1")!,
        UIImage(named: "Прекрасное далёко")!,
        UIImage(named: "Снова холодает")!,
        UIImage(named: "Не забывай меня")!,
        UIImage(named: "Бывшая")!,
        UIImage(named: "Ранила")!,
        UIImage(named: "Пустыня из золота")!,
        UIImage(named: "Она опять разденется")!
    ]
    
    private let recommendationNames = [
        "Лёша Свик",
        "Скриптонит",
        "Oxxxymiron",
        "NILETTO",
        "Баста",
        "Lx24",
        "Илья Никко",
        "T-killah",
        "Мари Краймбрери"
    ]
    
    private let dates = [
        "24 ноября 2023",
        "1 декабря 2023",
        "26 сентября 2023",
        "1 декабря 2023",
        "29 ноября 2023",
        "24 ноября 2023",
        "1 декабря 2023",
        "7 декабря 2023",
        "1 декабря 2023",
    ]
    
    lazy var recomendationsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(RecommendNewCollectionViewCell.self, forCellWithReuseIdentifier: RecommendNewCollectionViewCell.cellID)
        return collectionView
    }()
    
    private lazy var nameOfCell: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Рекомендуем новинки"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .black
        contentView.isUserInteractionEnabled = false
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configure() {
        addSubview(recomendationsCollectionView)
        addSubview(nameOfCell)
        
        NSLayoutConstraint.activate([
            
            nameOfCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameOfCell.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            
            recomendationsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            recomendationsCollectionView.topAnchor.constraint(equalTo: nameOfCell.bottomAnchor, constant: 10),
            recomendationsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            recomendationsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }

}

extension RecommendNewTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendationsSongNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendNewCollectionViewCell.cellID, for: indexPath) as! RecommendNewCollectionViewCell
        
        cell.artistImage.image = recommendationsImages[indexPath.item]
        cell.artistName.text = recommendationNames[indexPath.item]
        cell.songNameLabel.text = recommendationsSongNames[indexPath.item]
        cell.trackImageForView.image = recommendationSongImages[indexPath.item]
        cell.dateLabel.text = dates[indexPath.item]
        cell.viewForTrack.backgroundColor = .dominantColor(for: recommendationSongImages[indexPath.item])
        
        if indexPath.item == 1 {
            cell.typeOfRecommendation.text = "Альбом"
        } else {
            cell.typeOfRecommendation.text = "Сингл"
        }
        
        cell.backgroundColor = .clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.size.width - 20, height: 400)
    }
    
    /// Код, чтобы после скролла view отображалась по центру
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width, height: 154)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        recomendationsCollectionView.collectionViewLayout = layout
    }
    
}
