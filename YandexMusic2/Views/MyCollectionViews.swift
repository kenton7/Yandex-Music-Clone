//
//  SettingsViews.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 15.10.2023.
//

import UIKit
class MyCollectionViews: MiniPlayerView {
    
    
    //при редизайне здесь должно быть tableView с 3 секциями
    //в первой - раздел "Мне нравится" - в нем CollectionView, внутри collectionView - tableView с 3 рядами
    //во второй - "Еще у вас в коллекции"
    //в третьей - Любимые исполнители
    
    lazy var myWaveCollectionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Моя волна по разделу\n▶ Коллекция", for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.layer.cornerRadius = 20
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
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(MyCollectiontableViewCell.self, forCellReuseIdentifier: MyCollectiontableViewCell.cellID)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        backgroundColor = .black
        addSubview(myWaveCollectionButton)
        addSubview(tableView)

        
        NSLayoutConstraint.activate([
            myWaveCollectionButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            myWaveCollectionButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            myWaveCollectionButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            myWaveCollectionButton.heightAnchor.constraint(equalToConstant: 70),
            
            tableView.topAnchor.constraint(equalTo: myWaveCollectionButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
        ])
    }
    
    override func layoutSubviews() {
        //super.layoutSubviews()
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
