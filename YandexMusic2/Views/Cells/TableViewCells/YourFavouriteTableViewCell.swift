//
//  YourFavouriteTableViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 30.10.2023.
//

import UIKit

class YourFavouriteTableViewCell: UITableViewCell {
    
    static let cellID = "YourFavouriteTableViewCell"
    
    private lazy var yourFavouriteTracksLabel: UILabel = {
       let label = UILabel()
        label.text = "Ваши любимые треки"
        label.font = UIFont(name: "YandexSansText-Medium", size: 18)
        label.textColor = .white
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        contentView.layer.cornerRadius = 10
        backgroundColor = .clear
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        contentView.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        contentView.addSubview(yourFavouriteTracksLabel)
        contentView.addSubview(favouriteTracksImageView)
        contentView.addSubview(iLikeTracksLabel)
        
        NSLayoutConstraint.activate([
            favouriteTracksImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            favouriteTracksImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            //favouriteTracksImageView.topAnchor.constraint(equalTo: yourFavouriteTracksLabel.bottomAnchor, constant: 20),
            favouriteTracksImageView.heightAnchor.constraint(equalToConstant: 100),
            favouriteTracksImageView.widthAnchor.constraint(equalToConstant: 100),
            //favouriteTracksImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            
            iLikeTracksLabel.centerYAnchor.constraint(equalTo: favouriteTracksImageView.centerYAnchor),
            iLikeTracksLabel.leadingAnchor.constraint(equalTo: favouriteTracksImageView.trailingAnchor, constant: 10),
            
            yourFavouriteTracksLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
    }

}
