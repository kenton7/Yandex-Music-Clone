//
//  AllMyTracksViews.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 10.11.2023.
//

import Foundation
import UIKit
import Lottie


class AllMyTracksViews: MiniPlayerView {
    
    lazy var trackPlayingAnimation: LottieAnimationView = {
        let animationView = LottieAnimationView()
        animationView.animation = LottieAnimation.named("TrackPlayingAnimation")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 2.5
        animationView.isHidden = true
        animationView.play()
        return animationView
    }()
    
    var headerView: HeaderView?
    
//    lazy var headerView = StretchyTableHeaderView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height * 0.5))
    
    //------
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: AllMyTracksLayout())
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
            //layout.minimumLineSpacing = 40 // расстояние между ячейками
        }
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        collectionView.contentInsetAdjustmentBehavior = .never // игнорировать safeArea
        collectionView.register(AllMyTracksCollectionViewCell.self, forCellWithReuseIdentifier: AllMyTracksCollectionViewCell.cellID)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 150, right: 0)
        //регаем Header у коллекшн вью
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.cellID)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        addSubview(trackPlayingAnimation)
        insertSubview(collectionView, at: 0)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
}
