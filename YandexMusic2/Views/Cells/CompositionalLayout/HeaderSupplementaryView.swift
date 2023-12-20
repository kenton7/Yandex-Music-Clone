//
//  HeaderSupplementaryView.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 17.12.2023.
//

import UIKit

class HeaderSupplementaryView: UICollectionReusableView {
        
    static let cellID = "HeaderSupplementaryView"
    
    private let headerLabel: UILabel = {
       let label = UILabel()
        label.text = "header"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        addSubview(headerLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHeader(categoryName: String) {
        headerLabel.text = categoryName
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
    
}
