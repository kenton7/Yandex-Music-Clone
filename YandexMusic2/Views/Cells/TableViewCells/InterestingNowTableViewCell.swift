//
//  InterestingNowTableViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 30.10.2023.
//

import UIKit

class InterestingNowTableViewCell: UITableViewCell {
    
    static let cellID = "InterestingNowTableViewCell"
    
    private let images: [UIImage] = [
        UIImage(named: "Markul_NewSingle")!,
        UIImage(named: "100SuperHits")!,
        UIImage(named: "Clips")!,
        UIImage(named: "RainThreeDays")!,
        UIImage(named: "RockNew")!,
        UIImage(named: "Zivert")!,
        UIImage(named: "TheMostLiked")!
    ]
    
    private let types = [
        "Сингл", "Плейлист", "Видеоклипы", "Альбом", "Плейлист", "Альбом", "Плейлист"
    ]
    
    private let titles = [
        "Крепкие панчи и цепляющий хук", "100 суперхитов", "Новинки клипов", "«Три дня дождя» о жизни сквозь бессилие", "Громкие новинки: рок", "Zivert переизобретает себя", "В сердечке"
    ]
    
    private let descriptions = [
        "Markul о своих ориентирах, достижениях и целях", "Лучшие песни за последние несколько лет", "Мари Краймбрери, Люся Чеботина, aikko и другие", "Неприглядный анализ отношений и самого себя", "тринадцать карат и мина, Лали, TRITIA и другие", "Неожиданные эксперименты на новой пластинке", "Самые залайканные треки за всю историю Музыки"
    ]
    
    private lazy var interestingNowLabel: UILabel = {
        let label = UILabel()
        label.text = "Интересно сейчас"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "YandexSansText-Medium", size: 18)
        label.textColor = .white
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(InterestingNowCollectionViewCell.self, forCellWithReuseIdentifier: InterestingNowCollectionViewCell.cellID)
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
        
        addSubview(collectionView)
        addSubview(interestingNowLabel)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 400),
            
            interestingNowLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

extension InterestingNowTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count * 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestingNowCollectionViewCell.cellID, for: indexPath) as! InterestingNowCollectionViewCell
        
        var index = indexPath.item
        if index > images.count - 1 {
            index -= images.count
        }
        
        cell.interestingNowImages.image = images[index % images.count]
        cell.typeOfRecomendation.text = types[index % types.count].uppercased()
        cell.interestringTitle.text = titles[index % titles.count]
        cell.interestingDescription.text = descriptions[index % descriptions.count]
        
        //cell.interestingNowImages.image = images[indexPath.item]
        //cell.typeOfRecomendation.text = types[indexPath.item].uppercased()
        //cell.interestringTitle.text = titles[indexPath.item]
        //cell.interestingDescription.text = descriptions[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        var offset = collectionView.contentOffset
        let width = collectionView.contentSize.width
        if offset.x < width / 4 {
            offset.x += width / 2
            collectionView.setContentOffset(offset, animated: false)
        } else if offset.x > width / 4 * 3 {
            offset.x -= width / 2
            collectionView.setContentOffset(offset, animated: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.size.width, height: 350)
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
        collectionView.collectionViewLayout = layout
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetX = scrollView.contentOffset.x
//        let contentWidth = scrollView.contentSize.width
//        
//        if offsetX > contentWidth - scrollView.frame.size.width {
//            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
//        }
//    }
}
