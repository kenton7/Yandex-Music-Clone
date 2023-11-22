//
//  InterestingNowCollectionViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 30.10.2023.
//

import UIKit

class InterestingNowCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "InterestingNowCollectionViewCell"
    
    lazy var interestingNowImages: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var typeOfRecomendation: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "YandexSansText-Medium", size: 14)
        label.textColor = .systemYellow
        return label
    }()
    
    lazy var interestringTitle: UILabel = {
        let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "YandexSansText-Medium", size: 16)
        label.textColor = .white
         return label
    }()
    
    lazy var interestingDescription: UILabel = {
        let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "YandexSansText-Medium", size: 16)
        label.textColor = .lightGray
        label.numberOfLines = 0
         return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(interestingNowImages)
        addSubview(typeOfRecomendation)
        addSubview(interestringTitle)
        addSubview(interestingDescription)
                
        NSLayoutConstraint.activate([
            interestingNowImages.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            interestingNowImages.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            interestingNowImages.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            interestingNowImages.heightAnchor.constraint(equalToConstant: 250),
            
            typeOfRecomendation.topAnchor.constraint(equalTo: interestingNowImages.bottomAnchor, constant: 5),
            typeOfRecomendation.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            typeOfRecomendation.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            
            interestringTitle.topAnchor.constraint(equalTo: typeOfRecomendation.bottomAnchor, constant: 5),
            interestringTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            interestringTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            interestingDescription.topAnchor.constraint(equalTo: interestringTitle.bottomAnchor, constant: 5),
            interestingDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            interestingDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
