//
//  MyLikedTracksCollectionViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 17.12.2023.
//

import UIKit

class MyLikedTracksCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "MyLikedTracksCollectionViewCell"
    
    lazy var tracksCount: UILabel = {
        let label = UILabel()
         label.text = "7 треков"
         label.font = UIFont(name: "YandexSansText-Medium", size: 15)
         label.textColor = .lightGray
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private lazy var favouriteTracksImageView: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "iLikeImage")
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var iLikeTracksLabel: UILabel = {
       let label = UILabel()
        label.text = "Мне нравится"
        label.font = UIFont(name: "YandexSansText-Medium", size: 15)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
       let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 6
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .clear
        
        addSubview(tracksCount)
        addSubview(favouriteTracksImageView)
        addSubview(iLikeTracksLabel)
        addSubview(stackView)
        stackView.addArrangedSubview(iLikeTracksLabel)
        stackView.addArrangedSubview(tracksCount)
        
        NSLayoutConstraint.activate([
            favouriteTracksImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            favouriteTracksImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            favouriteTracksImageView.heightAnchor.constraint(equalToConstant: 80),
            favouriteTracksImageView.widthAnchor.constraint(equalToConstant: 80),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: favouriteTracksImageView.trailingAnchor, constant: 10),
        ])
    }
    
}
