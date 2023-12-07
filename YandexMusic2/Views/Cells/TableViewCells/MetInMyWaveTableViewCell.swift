//
//  ClipsTableViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 31.10.2023.
//

import UIKit
import WebKit
import youtube_ios_player_helper

class MetInMyWaveTableViewCell: UITableViewCell {
    
    static let cellID = "MetInMyWaveTableViewCell"
    
    private let artistsImages: [UIImage] = [
        UIImage(named: "D&S")!,
        UIImage(named: "Аллегрова")!,
        UIImage(named: "Chapman")!,
        UIImage(named: "KVPV")!,
        UIImage(named: "ILEXA")!,
        UIImage(named: "Niki Four")!,
        UIImage(named: "Craig David")!,
        UIImage(named: "Fisun")!
    ]
    
    private let artistNames = [
        "D&S",
        "Ирина Аллегрова",
        "Chapman",
        "KVPV",
        "ILEXA",
        "Niki Four",
        "Craig David",
        "Fisun"
    ]
    
    private lazy var metInMyWaveLabel: UILabel = {
        let label = UILabel()
        label.text = "Встретились в Моей волне"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "YandexSansText-Medium", size: 18)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var metInMyWaveCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MetInMyWaveCollectionViewCell.self, forCellWithReuseIdentifier: MetInMyWaveCollectionViewCell.cellID)
        return collectionView
    }()
    
//    lazy var playerView: YTPlayerView = {
//        let view = YTPlayerView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.isUserInteractionEnabled = true
//        view.backgroundColor = .black
//        return view
//    }()
    
//    lazy var webView: WKWebView = {
//        let view = WKWebView(frame: self.bounds)
//        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.backgroundColor = .clear
//        view.isOpaque = false
//        view.scrollView.isScrollEnabled = false
//        
//        return view
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        backgroundColor = .clear
        selectionStyle = .none
        contentView.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        //contentView.addSubview(playerView)
        //contentView.addSubview(clipTimeLabel)
        addSubview(metInMyWaveLabel)
        addSubview(metInMyWaveCollectionView)
        
        NSLayoutConstraint.activate([
            
//            playerView.topAnchor.constraint(equalTo: topAnchor),
//            playerView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            playerView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            playerView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            
//            clipTimeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            clipTimeLabel.bottomAnchor.constraint(equalTo: playerView.topAnchor, constant: -10)
            
            metInMyWaveCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            metInMyWaveCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            metInMyWaveCollectionView.topAnchor.constraint(equalTo: metInMyWaveLabel.bottomAnchor, constant: 10),
            metInMyWaveCollectionView.heightAnchor.constraint(equalToConstant: 150),
            
            metInMyWaveLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            metInMyWaveLabel.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
}

extension MetInMyWaveTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artistsImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MetInMyWaveCollectionViewCell.cellID, for: indexPath) as! MetInMyWaveCollectionViewCell
        cell.artistImage.image = artistsImages[indexPath.item]
        cell.artistName.text = artistNames[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}
