//
//  MainViews.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 13.10.2023.
//

import UIKit
import Lottie

class MainViews: MiniPlayerView {
    
    private(set) var waveAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView()
        animationView.animation = LottieAnimation.named("MyWave")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
        return animationView
    }()
    
    var myWaveButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: "play.fill", withConfiguration: config), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    var myWaveLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Моя волна"
        label.font = UIFont(name: "YandexSansText-Medium", size: 30)
        return label
    }()
    
    private lazy var myWaveStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var forYouButtonInNavigationBar: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 70, height: 20)
        button.clipsToBounds = true
        button.setTitle("Для вас", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.tintColor = .white
        button.backgroundColor = .clear
        return button
    }()
    
    lazy var trandsButtonInNavigationBar: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 70, height: 20)
        button.setTitle("Тренды", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.tintColor = .white
        button.backgroundColor = .clear
        return button
    }()
    
    lazy var stackViewForNavigationBarButtons: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.backgroundColor = .black
        stackView.autoresizingMask = .flexibleHeight
        stackView.addArrangedSubview(forYouButtonInNavigationBar)
        stackView.addArrangedSubview(trandsButtonInNavigationBar)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        
        insertSubview(waveAnimationView, at: 0)
        insertSubview(myWaveStackView, at: 1)
        myWaveStackView.addArrangedSubview(myWaveButton)
        myWaveStackView.addArrangedSubview(myWaveLabel)
        
        NSLayoutConstraint.activate([
            waveAnimationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            waveAnimationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            waveAnimationView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.65),
            
            myWaveStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            myWaveStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            myWaveStackView.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
