//
//  NeuroMusicTableViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 06.11.2023.
//

import UIKit

class NeuroMusicTableViewCell: UITableViewCell {

    private let typesOfNeuroMusic = ["Спокойствие", "Бодрость", "Вдохновение"]
    private let colors: [UIColor] = [.systemCyan, .systemPurple, .systemOrange]
    
    static let cellID = "NeuroMusicTableViewCell"
    
    private lazy var neuroMusicImageView: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "neuroMusic")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.layer.cornerRadius = 10
        collectionView.clipsToBounds = true
        collectionView.dataSource = self
        collectionView.register(NeuroMusicCollectionViewCell.self, forCellWithReuseIdentifier: NeuroMusicCollectionViewCell.cellID)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.isUserInteractionEnabled = false
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        backgroundColor = .black
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(neuroMusicImageView)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 50),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            neuroMusicImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            neuroMusicImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            neuroMusicImageView.topAnchor.constraint(equalTo: topAnchor, constant: -30),
            neuroMusicImageView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
}

extension NeuroMusicTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typesOfNeuroMusic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NeuroMusicCollectionViewCell.cellID, for: indexPath) as! NeuroMusicCollectionViewCell
       
        var index = indexPath.item
        if index > typesOfNeuroMusic.count - 1 {
            index -= typesOfNeuroMusic.count
        }
        
        cell.neuroMusicTitleLabel.text = typesOfNeuroMusic[index % typesOfNeuroMusic.count]
        cell.backgroundColor = colors[index % colors.count]
        cell.playImageView.backgroundColor = colors[index % colors.count]
        return cell
    }
    
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
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.size.width - 20, height: 50)
    }
    
    /// Код, чтобы после скролла view отображалась по центру
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width, height: 50)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let contentWidth = scrollView.contentSize.width
        
        if offsetX > contentWidth - scrollView.frame.size.width {
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}
