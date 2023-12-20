//
//  HeaderView.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 18.12.2023.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    static let cellID = "headerID"
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "iLikeImage"))
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 100, weight: .bold, scale: .large)
        button.layer.cornerRadius = button.frame.size.width / 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.circle.fill", withConfiguration: config), for: .normal)
        button.clipsToBounds = true
        button.tintColor = .systemYellow
        return button
    }()
    
    private lazy var playOrPauseLabelForButton: UILabel = {
        let label = UILabel()
        label.text = "Слушать"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var iLikeLabel: UILabel = {
        let label = UILabel()
        label.text = "Мне нравится"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = button.frame.size.width / 2
        let config = UIImage.SymbolConfiguration(pointSize: 60, weight: .light, scale: .large)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.down", withConfiguration: config), for: .normal)
        button.tintColor = .white
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var downloadLabel: UILabel = {
        let label = UILabel()
        label.text = "Скачать"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // custom code for layout
        addSubview(imageView)
        addSubview(downloadLabel)
        addSubview(downloadButton)
        addSubview(playButton)
        addSubview(playOrPauseLabelForButton)
        addSubview(iLikeLabel)
                
        backgroundColor = .red
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            
            iLikeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            iLikeLabel.bottomAnchor.constraint(equalTo: playButton.topAnchor, constant: -16),
            
            playOrPauseLabelForButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playOrPauseLabelForButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            playButton.bottomAnchor.constraint(equalTo: playOrPauseLabelForButton.topAnchor, constant: -20),
            playButton.widthAnchor.constraint(equalToConstant: 60),
            playButton.heightAnchor.constraint(equalToConstant: 60),
            playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            downloadLabel.centerYAnchor.constraint(equalTo: playOrPauseLabelForButton.centerYAnchor),
            downloadLabel.trailingAnchor.constraint(equalTo: playOrPauseLabelForButton.leadingAnchor, constant: -40),
            downloadButton.bottomAnchor.constraint(equalTo: downloadLabel.topAnchor, constant: -20),
            downloadButton.centerXAnchor.constraint(equalTo: downloadLabel.centerXAnchor),
            downloadButton.heightAnchor.constraint(equalToConstant: 60),
            downloadButton.widthAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
