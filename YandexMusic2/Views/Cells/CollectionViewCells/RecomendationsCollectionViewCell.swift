//
//  RecomendationsCollectionViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 06.12.2023.
//

import UIKit

class RecomendationsCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "RecomendationsCollectionViewCell"
    
    lazy var forYouLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Для вас"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    lazy var artistsLabel: UILabel = {
        let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "Денис Rider, NILETTO"
         label.font = .boldSystemFont(ofSize: 12)
         label.textColor = .lightGray
         return label
    }()
    
    lazy var imageView1InForYouLabel: UIImageView = {
        let view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        view.layer.cornerRadius = view.frame.width / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.image = UIImage(named: "OxxxymironFavourite")
        return view
    }()
    
    lazy var imageView2InForYouLabel: UIImageView = {
        let view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        view.layer.cornerRadius = view.frame.width / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "Лёша Свик")
        view.clipsToBounds = true
        return view
    }()
    
//    private lazy var trandsLabel: UILabel = {
//        let label = UILabel()
//         label.translatesAutoresizingMaskIntoConstraints = false
//         label.text = "Тренды"
//         label.font = .boldSystemFont(ofSize: 20)
//         label.textColor = .white
//         return label
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configure() {
        addSubview(forYouLabel)
        addSubview(artistsLabel)
        addSubview(imageView1InForYouLabel)
        addSubview(imageView2InForYouLabel)
       //addSubview(trandsLabel)
        
        backgroundColor = .clear
        layer.cornerRadius = 30
        
        NSLayoutConstraint.activate([
            imageView1InForYouLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            imageView1InForYouLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView1InForYouLabel.heightAnchor.constraint(equalToConstant: 50),
            imageView1InForYouLabel.widthAnchor.constraint(equalToConstant: 50),
            imageView2InForYouLabel.leadingAnchor.constraint(equalTo: imageView1InForYouLabel.trailingAnchor, constant: -20),
            imageView2InForYouLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            forYouLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            forYouLabel.leadingAnchor.constraint(equalTo: imageView2InForYouLabel.trailingAnchor, constant: 6),
            imageView2InForYouLabel.heightAnchor.constraint(equalToConstant:  50),
            imageView2InForYouLabel.widthAnchor.constraint(equalToConstant: 50),
            artistsLabel.leadingAnchor.constraint(equalTo: imageView2InForYouLabel.trailingAnchor, constant: 6),
            artistsLabel.topAnchor.constraint(equalTo: forYouLabel.bottomAnchor, constant: 4),
            artistsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        
    }
    
    
}
