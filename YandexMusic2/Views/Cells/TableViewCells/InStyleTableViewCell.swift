//
//  InterestingNowTableViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 30.10.2023.
//

import UIKit

class InStyleTableViewCell: UITableViewCell {
    
    static let cellID = "InStyleTableViewCell"
    
    var selectedIndex: IndexPath?
    var previousSelectedIndexPath = IndexPath()
    
    private let inStyleArtistsNames = [
        "NILETTO",
        "Kamazz",
        "Три дня дождя",
        "ONEIL",
        "Лёша Свик"
    ]
    
    private let inStyleArtistsImages: [UIImage] = [
        UIImage(named: "NILETTO")!,
        UIImage(named: "Kamazz")!,
        UIImage(named: "Три дня дождя")!,
        UIImage(named: "Oneil")!,
        UIImage(named: "Лёша Свик")!
    ]
    
    private let collectionImages: [UIImage] = [
        UIImage(named: "Sayonara боль")!,
        UIImage(named: "Кредо")!,
        UIImage(named: "Dabro")!,
        UIImage(named: "Ramil'")!,
        UIImage(named: "Celine")!,
        UIImage(named: "Dream")!,
        UIImage(named: "Dava")!,
        UIImage(named: "NewReleaseZivert")!
    ]
    
    private let collectionArtists = [
        "Элджей",
        "GAYAZOV$ BROTHER$",
        "Dabro",
        "Ramil'",
        "The Limba",
        "EDWARD BIL",
        "DAVA",
        "Zivert"
    ]
    
    private let collectionSongNames = [
        "Sayonara bоль",
        "Кредо",
        "Юность. Deluxe Edition",
        "Молодой",
        "Celine",
        "Dream",
        "КОРОЛЬ",
        "В МИРЕ ВЕСЁЛЫХ"
    ]
    
//    private let images: [UIImage] = [
//        UIImage(named: "Markul_NewSingle")!,
//        UIImage(named: "100SuperHits")!,
//        UIImage(named: "Clips")!,
//        UIImage(named: "RainThreeDays")!,
//        UIImage(named: "RockNew")!,
//        UIImage(named: "Zivert")!,
//        UIImage(named: "TheMostLiked")!
//    ]
//    
//    private let types = [
//        "Сингл", "Плейлист", "Видеоклипы", "Альбом", "Плейлист", "Альбом", "Плейлист"
//    ]
//    
//    private let titles = [
//        "Крепкие панчи и цепляющий хук", "100 суперхитов", "Новинки клипов", "«Три дня дождя» о жизни сквозь бессилие", "Громкие новинки: рок", "Zivert переизобретает себя", "В сердечке"
//    ]
//    
//    private let descriptions = [
//        "Markul о своих ориентирах, достижениях и целях", "Лучшие песни за последние несколько лет", "Мари Краймбрери, Люся Чеботина, aikko и другие", "Неприглядный анализ отношений и самого себя", "тринадцать карат и мина, Лали, TRITIA и другие", "Неожиданные эксперименты на новой пластинке", "Самые залайканные треки за всю историю Музыки"
//    ]

    
    private lazy var interestingNowLabel: UILabel = {
        let label = UILabel()
        label.text = "В стиле"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "YandexSansText-Medium", size: 16)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private lazy var inStyleArtistsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(InStyleArtistsCollectionViewCell.self, forCellWithReuseIdentifier: InStyleArtistsCollectionViewCell.cellID)
        return collectionView
    }()
    
    private lazy var inStyleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 180, height: 180)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        collectionView.register(InStyleCollectionViewCell.self, forCellWithReuseIdentifier: InStyleCollectionViewCell.cellID)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        contentView.isUserInteractionEnabled = false
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configure() {
        
        addSubview(inStyleArtistsCollectionView)
        addSubview(interestingNowLabel)
        addSubview(inStyleCollectionView)
        
        NSLayoutConstraint.activate([
            
            inStyleArtistsCollectionView.leadingAnchor.constraint(equalTo: interestingNowLabel.trailingAnchor, constant: 10),
            inStyleArtistsCollectionView.heightAnchor.constraint(equalToConstant: 50),
            inStyleArtistsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            interestingNowLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            interestingNowLabel.centerYAnchor.constraint(equalTo: inStyleArtistsCollectionView.centerYAnchor),
            
            inStyleCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            inStyleCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            inStyleCollectionView.topAnchor.constraint(equalTo: inStyleArtistsCollectionView.bottomAnchor, constant: 10),
            inStyleCollectionView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}

extension InStyleTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == inStyleArtistsCollectionView {
            return inStyleArtistsNames.count
        } else {
            return collectionImages.count
        }
        
        //return images.count * 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == inStyleArtistsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InStyleArtistsCollectionViewCell.cellID, for: indexPath) as! InStyleArtistsCollectionViewCell
            
            cell.artistImage.image = inStyleArtistsImages[indexPath.item]
            cell.artistName.text = inStyleArtistsNames[indexPath.item]
            
            if indexPath.item == 0 {
                cell.backgroundColor = #colorLiteral(red: 0.07843136042, green: 0.07843136042, blue: 0.07843136042, alpha: 1)
                //selectedIndex = indexPath.item
            } else {
                cell.backgroundColor = .clear
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InStyleCollectionViewCell.cellID, for: indexPath) as! InStyleCollectionViewCell
            
            cell.songImageView.image = collectionImages[indexPath.item]
            cell.artistName.text = collectionArtists[indexPath.item]
            cell.songName.text = collectionSongNames[indexPath.item]
            return cell
        }
        
        
//        var index = indexPath.item
//        if index > images.count - 1 {
//            index -= images.count
//        }
//        
//        cell.interestingNowImages.image = images[index % images.count]
//        cell.typeOfRecomendation.text = types[index % types.count].uppercased()
//        cell.interestringTitle.text = titles[index % titles.count]
//        cell.interestingDescription.text = descriptions[index % descriptions.count]
        
        //cell.interestingNowImages.image = images[indexPath.item]
        //cell.typeOfRecomendation.text = types[indexPath.item].uppercased()
        //cell.interestringTitle.text = titles[indexPath.item]
        //cell.interestingDescription.text = descriptions[indexPath.item]
        //return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == inStyleArtistsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InStyleArtistsCollectionViewCell.cellID, for: indexPath) as! InStyleArtistsCollectionViewCell
            
            if indexPath.item == 0 {
                cell.selectedBackgroundView?.backgroundColor = #colorLiteral(red: 0.07843136042, green: 0.07843136042, blue: 0.07843136042, alpha: 1)
                //collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == inStyleArtistsCollectionView {
            let cell = collectionView.cellForItem(at: indexPath) as! InStyleArtistsCollectionViewCell
            //cell.backgroundColor = #colorLiteral(red: 0.07843136042, green: 0.07843136042, blue: 0.07843136042, alpha: 1)
            
                if let previousSelectedIndexPath = selectedIndex {
                    collectionView.deselectItem(at: previousSelectedIndexPath, animated: true)
                }
                selectedIndex = indexPath
            
            cell.selectedBackgroundView?.backgroundColor = #colorLiteral(red: 0.07843136042, green: 0.07843136042, blue: 0.07843136042, alpha: 1)
                //cell.backgroundColor = #colorLiteral(red: 0.07843136042, green: 0.07843136042, blue: 0.07843136042, alpha: 1)
        } else {
            print("inStyleCollectionView \(indexPath.item)")
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        return CGSize(width: 150, height: 50)
//    }
    
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        var offset = collectionView.contentOffset
//        let width = collectionView.contentSize.width
//        if offset.x < width / 4 {
//            offset.x += width / 2
//            collectionView.setContentOffset(offset, animated: false)
//        } else if offset.x > width / 4 * 3 {
//            offset.x -= width / 2
//            collectionView.setContentOffset(offset, animated: false)
//        }
//    }
    
    
    /// Код, чтобы после скролла view отображалась по центру
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        let width = UIScreen.main.bounds.width
//        layout.itemSize = CGSize(width: width, height: 154)
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        layout.scrollDirection = .horizontal
//        inStyleCollectionView.collectionViewLayout = layout
//    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetX = scrollView.contentOffset.x
//        let contentWidth = scrollView.contentSize.width
//        
//        if offsetX > contentWidth - scrollView.frame.size.width {
//            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
//        }
//    }
}
