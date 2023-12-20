//
//  MetInWaveCollectionViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 19.12.2023.
//

import UIKit

class MetInWaveCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "MetInWaveCollectionViewCell"
    
    let artistsImages: [UIImage] = [
        UIImage(named: "D&S")!,
        UIImage(named: "Аллегрова")!,
        UIImage(named: "Chapman")!,
        UIImage(named: "KVPV")!,
        UIImage(named: "ILEXA")!,
        UIImage(named: "Niki Four")!,
        UIImage(named: "Craig David")!,
        UIImage(named: "Fisun")!
    ]
    
    let artistNames = [
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
    
    lazy var artistImage: UIImageView = {
       let view = UIImageView()
        view.frame = CGRect(x: 10, y: 20, width: 100, height: 100)
        view.layer.cornerRadius = view.frame.width / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var artistName: UILabel = {
       let label = UILabel()
        label.text = "Artist"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(artistImage)
        contentView.addSubview(artistName)
        backgroundColor = .clear
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        NSLayoutConstraint.activate([
            
            artistImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            artistImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            artistImage.heightAnchor.constraint(equalToConstant: 100),
            artistImage.widthAnchor.constraint(equalToConstant: 100),
            artistName.centerXAnchor.constraint(equalTo: artistImage.centerXAnchor),
            artistName.topAnchor.constraint(equalTo: artistImage.bottomAnchor, constant: 10)
        ])
    }
    
}
