//
//  InterestingNowCollectionViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 30.10.2023.
//

import UIKit

class InStyleArtistsCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "InStyleArtistsCollectionViewCell"
    
    
    lazy var artistImage: UIImageView = {
        let view = UIImageView()
        view.frame = CGRect(x: 10, y: 10, width: 30, height: 30)
        view.image = UIImage(named: "NILETTO")
        view.layer.cornerRadius = view.frame.width / 2
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
//    lazy var interestingNowImages: UIImageView = {
//       let view = UIImageView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.cornerRadius = 10
//        view.clipsToBounds = true
//        view.contentMode = .scaleAspectFill
//        return view
//    }()
//    
//    lazy var typeOfRecomendation: UILabel = {
//       let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: "YandexSansText-Medium", size: 14)
//        label.textColor = .systemYellow
//        return label
//    }()
//    
//    lazy var interestringTitle: UILabel = {
//        let label = UILabel()
//         label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: "YandexSansText-Medium", size: 16)
//        label.textColor = .white
//         return label
//    }()
//    
//    lazy var interestingDescription: UILabel = {
//        let label = UILabel()
//         label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: "YandexSansText-Medium", size: 16)
//        label.textColor = .lightGray
//        label.numberOfLines = 0
//         return label
//    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
//        addSubview(interestingNowImages)
//        addSubview(typeOfRecomendation)
//        addSubview(interestringTitle)
//        addSubview(interestingDescription)
        contentView.addSubview(artistName)
        contentView.addSubview(artistImage)
        layer.cornerRadius = 25
        
        backgroundColor = .clear
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = #colorLiteral(red: 0.07843136042, green: 0.07843136042, blue: 0.07843136042, alpha: 1)
        selectedBackgroundView.layer.cornerRadius = 25
        selectedBackgroundView.clipsToBounds = true
        self.selectedBackgroundView = selectedBackgroundView
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            
            // Ограничения для artistImage
            artistImage.widthAnchor.constraint(equalToConstant: 30),
            artistImage.heightAnchor.constraint(equalTo: artistImage.widthAnchor),
            artistImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            artistImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            // Ограничения для artistName
            artistName.leadingAnchor.constraint(equalTo: artistImage.trailingAnchor, constant: 6),
            artistName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            artistName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            // Ограничения для contentView
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            
//            interestingNowImages.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
//            interestingNowImages.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
//            interestingNowImages.topAnchor.constraint(equalTo: topAnchor, constant: 10),
//            interestingNowImages.heightAnchor.constraint(equalToConstant: 250),
//            
//            typeOfRecomendation.topAnchor.constraint(equalTo: interestingNowImages.bottomAnchor, constant: 5),
//            typeOfRecomendation.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
//            typeOfRecomendation.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
//            
//            
//            interestringTitle.topAnchor.constraint(equalTo: typeOfRecomendation.bottomAnchor, constant: 5),
//            interestringTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
//            interestringTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
//            
//            interestingDescription.topAnchor.constraint(equalTo: interestringTitle.bottomAnchor, constant: 5),
//            interestingDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
//            interestingDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        // Make any additional adjustments to the cell's frame
        newFrame.size = size
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
}
