//
//  MoreFindingsCollectionView.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 07.12.2023.
//

import UIKit

class MoreFindingsCollectionView: UICollectionViewCell {
    
    static let cellID = "MoreFindingsCollectionView"
    
    private lazy var myWaveLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Моя волна"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    lazy var myWaveTypesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        
        addSubview(myWaveLabel)
        addSubview(myWaveTypesLabel)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        NSLayoutConstraint.activate([
            myWaveLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            myWaveLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            myWaveTypesLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            myWaveTypesLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
