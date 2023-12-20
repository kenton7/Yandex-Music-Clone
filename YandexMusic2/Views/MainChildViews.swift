//
//  MainChildViews.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 30.10.2023.
//

import UIKit

class MainChildViews: MiniPlayerView {
        
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(ForYouOrTrendsTableViewCell.self, forCellReuseIdentifier: ForYouOrTrendsTableViewCell.cellID)
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 600
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 150, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.isUserInteractionEnabled = false
        return tableView
    }()
    
    lazy var handleArea: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var controlImageOnHandleArea: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "chevron.compact.up")
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
        return view
    }()
    
//    lazy var recomendationsCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.backgroundColor = .clear
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.showsVerticalScrollIndicator = false
////        collectionView.delegate = self
////        collectionView.dataSource = self
//        collectionView.register(RecomendationsCollectionViewCell.self, forCellWithReuseIdentifier: RecomendationsCollectionViewCell.cellID)
//        return collectionView
//    }()
    
    lazy var childCollectionView: UICollectionView = {
       let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(RecomendationsCollectionViewCell.self, forCellWithReuseIdentifier: RecomendationsCollectionViewCell.cellID)
        collectionView.register(MyLikedTracksCollectionViewCell.self, forCellWithReuseIdentifier: MyLikedTracksCollectionViewCell.cellID)
        collectionView.register(RecommendationsNewCollectionViewCell.self, forCellWithReuseIdentifier: RecommendationsNewCollectionViewCell.cellID)
        collectionView.register(HeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSupplementaryView.cellID)
        collectionView.register(StyleCollectionViewCell.self, forCellWithReuseIdentifier: StyleCollectionViewCell.cellID)
        //collectionView.register(StyleCollectionViewCell.self, forSupplementaryViewOfKind: "textElementKind", withReuseIdentifier: StyleCollectionViewCell.cellID)
        //collectionView.register(EmptyCollectionViewCell.self, forCellWithReuseIdentifier: EmptyCollectionViewCell.cellID)
        collectionView.register(StyleRecomedationsCollectionViewCell.self, forCellWithReuseIdentifier: StyleRecomedationsCollectionViewCell.cellID)
        collectionView.register(MoreOpenedInMyWaveCollectionViewCell.self, forCellWithReuseIdentifier: MoreOpenedInMyWaveCollectionViewCell.cellID)
        collectionView.register(MyWaveGenresCollectionViewCell.self, forCellWithReuseIdentifier: MyWaveGenresCollectionViewCell.cellID)
        collectionView.register(MetInWaveCollectionViewCell.self, forCellWithReuseIdentifier: MetInWaveCollectionViewCell.cellID)
        collectionView.register(CollectForYouCollectionViewCell.self, forCellWithReuseIdentifier: CollectForYouCollectionViewCell.cellID)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
        backgroundColor = .clear
        //insertSubview(tableView, at: 0)
        
        insertSubview(childCollectionView, at: 0)
        //insertSubview(handleArea, at: 0)
        //insertSubview(recomendationsCollectionView, at: 0)
        //handleArea.addSubview(controlImageOnHandleArea)
        //insertSubview(redView, at: 0)
        //addSubview(tableView)
        configure()
    }
    
    var handleAreaHeight = NSLayoutConstraint()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        NSLayoutConstraint.activate([
            
//            handleArea.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -frame.height / 2),
//            handleArea.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//            handleArea.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
//            handleArea.heightAnchor.constraint(equalToConstant: 200),
            
//            handleArea.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
//            handleArea.trailingAnchor.constraint(equalTo: trailingAnchor),
//            handleArea.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -20),
            
//            controlImageOnHandleArea.centerXAnchor.constraint(equalTo: centerXAnchor),
//            //controlImageOnHandleArea.centerYAnchor.constraint(equalTo: handleArea.centerYAnchor),
//            controlImageOnHandleArea.bottomAnchor.constraint(equalTo: handleArea.bottomAnchor),
//            //controlImageOnHandleArea.topAnchor.constraint(equalTo: handleArea.topAnchor, constant: 10),
//            controlImageOnHandleArea.heightAnchor.constraint(equalToConstant: 30),
//            controlImageOnHandleArea.widthAnchor.constraint(equalToConstant: 70),
            
//            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
//            tableView.topAnchor.constraint(equalTo: topAnchor)
            
            childCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            childCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            childCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            childCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        ])
    }
}

