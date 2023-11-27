//
//  MyCollectionWaveTableViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 25.11.2023.
//

import UIKit

class MyCollectionWaveTableViewCell: UITableViewCell {
    
    static let cellID = "MyCollectionWaveTableViewCell"
    
    lazy var myWaveCollectionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Моя волна по разделу\n▶ Коллекция", for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        layer.colors = [UIColor.systemPink.cgColor, UIColor.white.cgColor]
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.cornerRadius = 16
        myWaveCollectionButton.layer.insertSublayer(layer, at: 0)
        return layer
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //contentView.isUserInteractionEnabled = false
        backgroundColor = .black
        selectionStyle = .none
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(myWaveCollectionButton)
        
        NSLayoutConstraint.activate([
            myWaveCollectionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            myWaveCollectionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            myWaveCollectionButton.topAnchor.constraint(equalTo: topAnchor),
            myWaveCollectionButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = [UIColor.systemPink.cgColor, UIColor.white.cgColor]
        animation.toValue = [UIColor.white.cgColor, UIColor.systemPink.cgColor]
        animation.autoreverses = true
        animation.duration = 5.0
        animation.repeatCount = Float.infinity
        gradientLayer.frame = myWaveCollectionButton.bounds
        gradientLayer.add(animation, forKey: nil)
    }
    
}
