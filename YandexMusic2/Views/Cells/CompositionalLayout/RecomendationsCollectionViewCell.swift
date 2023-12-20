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
         label.text = "Oxxxymiron, NILETTO"
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
        view.image = UIImage(named: "Oxxxymiron")
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
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(forYouLabel)
        stackView.addArrangedSubview(artistsLabel)
        stackView.axis = .vertical
        return stackView
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
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configure() {
        addSubview(forYouLabel)
        addSubview(artistsLabel)
        addSubview(imageView1InForYouLabel)
        addSubview(imageView2InForYouLabel)
        addSubview(stackView)
        
        backgroundColor = .clear
        layer.cornerRadius = 30
        
        NSLayoutConstraint.activate([
            imageView1InForYouLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            imageView1InForYouLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView1InForYouLabel.heightAnchor.constraint(equalToConstant: 50),
            imageView1InForYouLabel.widthAnchor.constraint(equalToConstant: 50),
            imageView2InForYouLabel.leadingAnchor.constraint(equalTo: imageView1InForYouLabel.trailingAnchor, constant: -20),
            imageView2InForYouLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView2InForYouLabel.heightAnchor.constraint(equalToConstant:  50),
            imageView2InForYouLabel.widthAnchor.constraint(equalToConstant: 50),
            stackView.centerYAnchor.constraint(equalTo: imageView2InForYouLabel.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: imageView2InForYouLabel.trailingAnchor, constant: 6)
        ])
        
    }
    
    
}
