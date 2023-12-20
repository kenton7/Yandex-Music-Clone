//
//  StyleCollectionViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 17.12.2023.
//

import UIKit

class StyleCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "StyleCollectionViewCell"
    
    var selectedIndex: IndexPath?
    var previousSelectedIndexPath = IndexPath()
    
    let inStyleArtistsNames = [
        "NILETTO",
        "Kamazz",
        "Три дня дождя",
        "ONEIL",
        "Лёша Свик"
    ]
    
    let inStyleArtistsImages: [UIImage] = [
        UIImage(named: "NILETTO")!,
        UIImage(named: "Kamazz")!,
        UIImage(named: "Три дня дождя")!,
        UIImage(named: "Oneil")!,
        UIImage(named: "Лёша Свик")!
    ]
    
    lazy var interestingNowLabel: UILabel = {
        let label = UILabel()
        label.text = "В стиле"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "YandexSansText-Medium", size: 16)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var artistImage: UIImageView = {
        let view = UIImageView()
        view.frame = CGRect(x: 10, y: 10, width: 30, height: 30)
        view.image = UIImage(named: "NILETTO")
        view.layer.cornerRadius = view.frame.width / 2
        view.clipsToBounds = true
        //view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var artistName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "YandexSansText-Medium", size: 16)
        label.textColor = .white
        label.text = "Artist"
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    lazy var stackView: UIStackView = {
       let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 10
        view.addArrangedSubview(artistImage)
        view.addArrangedSubview(artistName)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //addSubview(interestingNowLabel)
        //addSubview(artistName)
        //addSubview(artistImage)
        backgroundColor = .clear
        addSubview(stackView)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        //contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //interestingNowLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            //interestingNowLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            //stackView.heightAnchor.constraint(equalToConstant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            artistImage.widthAnchor.constraint(equalToConstant: 30),
            artistImage.heightAnchor.constraint(equalToConstant: 30),
//            artistImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            artistImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // Ограничения для artistName
//            artistName.leadingAnchor.constraint(equalTo: artistImage.trailingAnchor, constant: 6),
//            artistName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            artistName.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // Ограничения для contentView
//            contentView.topAnchor.constraint(equalTo: topAnchor),
//            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
    }
    
}
