//
//  ILikeCollectionViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 25.11.2023.
//

import UIKit

class ILikeCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "ILikeCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    private func configure() {
        backgroundColor = .yellow
    }
}
