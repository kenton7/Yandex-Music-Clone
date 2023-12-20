//
//  MyWaveGenresCollectionViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 19.12.2023.
//

import UIKit

class MyWaveGenresCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "MyWaveGenresCollectionViewCell"
    
    let myWaveTypes = [
        "Поп",
        "Русская поп-музыка",
        "Русский рэп",
        "Русская эстрада",
        "Рэп и хип-хоп",
        "Эстрада",
    ]
    
    let colors: [UIColor] = [
        .systemRed,
        .systemYellow,
        .systemRed,
        .systemPink,
        .systemPink,
        .systemGreen
    ]
    
    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        layer.colors = [UIColor.systemPink.cgColor, UIColor.white.cgColor]
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.cornerRadius = 16
        stackView.layer.insertSublayer(layer, at: 0)
        return layer
    }()
    
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
    
    lazy var stackView: UIStackView = {
       let view = UIStackView()
        view.frame = CGRect(x: 0, y: 0, width: 150, height: 60)
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 0
        view.distribution = .fillProportionally
        view.addArrangedSubview(myWaveLabel)
        view.addArrangedSubview(myWaveTypesLabel)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        //layoutSubviews()
        backgroundColor = .clear
        
        //addSubview(myWaveLabel)
        //addSubview(myWaveTypesLabel)
        //myWaveTypesLabel.addSubview(myWaveLabel)
        addSubview(stackView)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        NSLayoutConstraint.activate([
//            myWaveLabel.centerXAnchor.constraint(equalTo: myWaveTypesLabel.centerXAnchor),
//            myWaveLabel.topAnchor.constraint(equalTo: myWaveTypesLabel.topAnchor, constant: 10),
//            
//            myWaveTypesLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            myWaveTypesLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
//            myWaveTypesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            myWaveTypesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            myWaveTypesLabel.heightAnchor.constraint(equalToConstant: 60)
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
//    override func layoutSubviews() {
//        let animation = CABasicAnimation(keyPath: "colors")
//        for color in colors {
//            animation.fromValue = [color.cgColor, UIColor.white.cgColor]
//            animation.toValue = [UIColor.white.cgColor, color.cgColor]
//        }
////        animation.fromValue = [UIColor.systemPink.cgColor, UIColor.white.cgColor]
////        animation.toValue = [UIColor.white.cgColor, UIColor.systemPink.cgColor]
//        animation.autoreverses = true
//        animation.duration = 5.0
//        animation.repeatCount = Float.infinity
//        gradientLayer.frame = self.bounds
//        gradientLayer.add(animation, forKey: nil)
//    }
    
}
