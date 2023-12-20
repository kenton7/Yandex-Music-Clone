//
//  MoreTableViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 07.12.2023.
//

import UIKit

class MoreTableViewCell: UITableViewCell {
    
    static let cellID = "MoreTableViewCell"
    
    private let types = [
        "Больше открытий",
        "по жанру",
        "под настроение",
        "под занятие"
    ]
    
    private let myWaveTypes = [
        "Поп",
        "Русская поп-музыка",
        "Русский рэп",
        "Русская эстрада",
        "Рэп и хип-хоп",
        "Эстрада",
    ]
    
    private let colors: [UIColor] = [
        .systemRed,
        .systemYellow,
        .systemRed,
        .systemPink,
        .systemPink,
        .systemGreen
    ]
    
    private lazy var moreFindingsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Больше открытий"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var moreFindingsGenreCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(MoreFindingsGenreCollectionViewCell.self, forCellWithReuseIdentifier: MoreFindingsGenreCollectionViewCell.cellID)
        return collectionView
    }()
    
    lazy var moreFindingsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 20, height: 55)
        layout.minimumLineSpacing = 20
        //layout.estimatedItemSize = CGSize(width: frame.size.width, height: 50)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(MoreFindingsCollectionView.self, forCellWithReuseIdentifier: MoreFindingsCollectionView.cellID)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.isUserInteractionEnabled = false
        backgroundColor = .black
        layer.cornerRadius = 25
        
        //addSubview(moreFindingsLabel)
        addSubview(moreFindingsGenreCollectionView)
        addSubview(moreFindingsCollectionView)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        NSLayoutConstraint.activate([
            moreFindingsGenreCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            moreFindingsGenreCollectionView.heightAnchor.constraint(equalToConstant: 50),
            moreFindingsGenreCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            moreFindingsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            moreFindingsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            moreFindingsCollectionView.heightAnchor.constraint(equalToConstant: 70),
            moreFindingsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            moreFindingsCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
//            moreFindingsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            moreFindingsLabel.centerYAnchor.constraint(equalTo: moreFindingsGenreCollectionView.centerYAnchor)
        ])
    }

}

extension MoreTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == moreFindingsGenreCollectionView {
            return types.count
        } else {
            return myWaveTypes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == moreFindingsGenreCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoreFindingsGenreCollectionViewCell.cellID, for: indexPath) as! MoreFindingsGenreCollectionViewCell
            
            cell.typeLabel.text = types[indexPath.item]
    
            if indexPath.item == 0 {
                cell.typeLabel.textColor = .white
                cell.typeLabel.font = UIFont(name: "YandexSansText-Medium", size: 16)
                cell.isUserInteractionEnabled = false
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoreFindingsCollectionView.cellID, for: indexPath) as! MoreFindingsCollectionView
            
            var index = indexPath.item
            if index > myWaveTypes.count - 1 {
                index -= myWaveTypes.count
            }
            cell.myWaveTypesLabel.text = "▶ \(myWaveTypes[index % myWaveTypes.count])"
            cell.backgroundColor = colors[index % colors.count]
            
            return cell
        }
    }
    
    /// Код, чтобы после скролла view отображалась по центру
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 20
        layout.itemSize = CGSize(width: width, height: 55)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        moreFindingsCollectionView.collectionViewLayout = layout
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let contentWidth = scrollView.contentSize.width
        
        if offsetX > contentWidth - scrollView.frame.size.width {
            moreFindingsCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    

}
