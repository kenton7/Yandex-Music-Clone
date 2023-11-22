//
//  ILikeCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 15.10.2023.
//

import UIKit

class ILikeCell: UITableViewCell {
    
    static let cellID = "ILikeCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "YandexSansText-Medium", size: 15)
        return label
    }()
    
    let numberOfTrackLabel: UILabel = {
       let label = UILabel()
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "YandexSansText-Medium", size: 12)
        return label
    }()
    
    let titleImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "iLikeImage")
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let stackViewForILikeRow: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.alignment = .leading
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        addSubview(titleImage)
        addSubview(stackViewForILikeRow)
        stackViewForILikeRow.addArrangedSubview(titleLabel)
        stackViewForILikeRow.addArrangedSubview(numberOfTrackLabel)
        backgroundColor = .clear
        accessoryType = .disclosureIndicator
        tintColor = .white
        
        NSLayoutConstraint.activate([
            
            stackViewForILikeRow.leadingAnchor.constraint(equalTo: titleImage.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            stackViewForILikeRow.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            stackViewForILikeRow.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleImage.heightAnchor.constraint(equalToConstant: 90),
            titleImage.widthAnchor.constraint(equalToConstant: 90),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
