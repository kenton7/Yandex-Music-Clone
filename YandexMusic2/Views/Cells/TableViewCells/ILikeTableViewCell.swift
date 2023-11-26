//
//  ILikeTableViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 25.11.2023.
//

import UIKit
import Lottie

class ILikeTableViewCell: UITableViewCell {
    
    static let cellID = "ILikeTableViewCell"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
//        collectionView.delegate = self
//        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(ILikeCollectionViewCell.self, forCellWithReuseIdentifier: ILikeCollectionViewCell.cellID)
        return collectionView
    }()
    
    private lazy var iLikeLabel: UILabel = {
        let label = UILabel()
        label.text = "Мне нравится"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var trackCount: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "\(SongModel.getSongs().count) треков"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var allTracksIlikedButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Всё >", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = false
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .black
        selectionStyle = .none
        
        addSubview(collectionView)
        addSubview(iLikeLabel)
        addSubview(trackCount)
        addSubview(allTracksIlikedButton)
        
        NSLayoutConstraint.activate([
            
            trackCount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            iLikeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            iLikeLabel.bottomAnchor.constraint(equalTo: trackCount.topAnchor, constant: -10),
            
            allTracksIlikedButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            allTracksIlikedButton.topAnchor.constraint(equalTo: iLikeLabel.topAnchor),
            
            collectionView.topAnchor.constraint(equalTo: trackCount.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
    }
}


