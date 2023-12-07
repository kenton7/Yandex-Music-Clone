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
    
    lazy var recomendationsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
//        collectionView.delegate = self
//        collectionView.dataSource = self
        collectionView.register(RecomendationsCollectionViewCell.self, forCellWithReuseIdentifier: RecomendationsCollectionViewCell.cellID)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
        backgroundColor = .clear
        insertSubview(tableView, at: 0)
        insertSubview(handleArea, at: 0)
        //insertSubview(recomendationsCollectionView, at: 0)
        handleArea.addSubview(controlImageOnHandleArea)
        //insertSubview(redView, at: 0)
        //addSubview(tableView)
        configure()
    }
    
    var handleAreaHeight = NSLayoutConstraint()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        sliderOnMiniPlayer.isHidden = true
        miniPlayer.isHidden = true
        likeButtonMiniPlayer.isHidden = true
        changeSourcePlayingMiniPlayer.isHidden = true
        playPauseButtonMiniPlayer.isHidden = true
        songName.isHidden = true
        songAuthor.isHidden = true
        
        NSLayoutConstraint.activate([
            
//            handleArea.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -frame.height / 2),
//            handleArea.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//            handleArea.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
//            handleArea.heightAnchor.constraint(equalToConstant: 200),
            
            handleArea.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            handleArea.trailingAnchor.constraint(equalTo: trailingAnchor),
            handleArea.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -20),
            
//            recomendationsCollectionView.topAnchor.constraint(equalTo: topAnchor),
//            recomendationsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            recomendationsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            recomendationsCollectionView.heightAnchor.constraint(equalToConstant: 100),
            //handleArea.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            //handleArea.heightAnchor.constraint(equalToConstant: 100),
            //handleArea.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: 10),
            
            controlImageOnHandleArea.centerXAnchor.constraint(equalTo: centerXAnchor),
            //controlImageOnHandleArea.centerYAnchor.constraint(equalTo: handleArea.centerYAnchor),
            controlImageOnHandleArea.bottomAnchor.constraint(equalTo: handleArea.bottomAnchor),
            //controlImageOnHandleArea.topAnchor.constraint(equalTo: handleArea.topAnchor, constant: 10),
            controlImageOnHandleArea.heightAnchor.constraint(equalToConstant: 30),
            controlImageOnHandleArea.widthAnchor.constraint(equalToConstant: 70),
            
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            //tableView.heightAnchor.constraint(equalToConstant: frame.height),
            tableView.topAnchor.constraint(equalTo: handleArea.bottomAnchor, constant: 0)
        ])
        
        handleAreaHeight = handleArea.heightAnchor.constraint(equalToConstant: 100)
        handleAreaHeight.isActive = true
    }
    
}
