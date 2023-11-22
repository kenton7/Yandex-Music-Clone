//
//  AllMyTracksTableViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 09.11.2023.
//

import UIKit

class AllMyTracksTableViewCell: UITableViewCell {
    
    static let cellID = "AllMyTracksTableViewCell"
    
    lazy var songImage: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.backgroundColor = .red
        return view
    }()
    
    lazy var songName: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "YandexSansText-Medium", size: 15)
        label.textColor = .white
        label.text = "Название песни"
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    lazy var songAuthor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "YandexSansText-Medium", size: 13)
        label.textColor = .lightGray
        label.text = "Имя артиста"
        return label
    }()
    
    private lazy var stackViewForSongInfo: UIStackView = {
       let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        return view
    }()
    
    lazy var explicitImageView: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: "explicit")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.isHidden = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.isUserInteractionEnabled = false
        backgroundColor = .black
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(moreButton)
        addSubview(songImage)
        addSubview(songName)
        addSubview(songAuthor)
        addSubview(stackViewForSongInfo)
        addSubview(explicitImageView)
        
        stackViewForSongInfo.addArrangedSubview(songName)
        stackViewForSongInfo.addArrangedSubview(songAuthor)
        
        NSLayoutConstraint.activate([
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            moreButton.heightAnchor.constraint(equalToConstant: 50),
            moreButton.widthAnchor.constraint(equalToConstant: 50),
            moreButton.centerXAnchor.constraint(equalTo: stackViewForSongInfo.centerXAnchor),
            
            songImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            songImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            songImage.heightAnchor.constraint(equalToConstant: 50),
            songImage.widthAnchor.constraint(equalToConstant: 50),
            
            stackViewForSongInfo.leadingAnchor.constraint(equalTo: songImage.trailingAnchor, constant: 10),
            stackViewForSongInfo.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackViewForSongInfo.trailingAnchor.constraint(equalTo: moreButton.leadingAnchor, constant: -10),
            
            explicitImageView.trailingAnchor.constraint(equalTo: moreButton.leadingAnchor, constant: -5),
            explicitImageView.heightAnchor.constraint(equalToConstant: 15),
            explicitImageView.widthAnchor.constraint(equalToConstant: 15),
            explicitImageView.centerYAnchor.constraint(equalTo: stackViewForSongInfo.centerYAnchor)
        ])
    }

}
