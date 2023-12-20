//
//  AllMyTracksViews.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 09.11.2023.
//

import UIKit
import Lottie
import Foundation


class StretchyTableHeaderView: UIView {
    var animationViewHeight = NSLayoutConstraint()
    var animationViewBottom = NSLayoutConstraint()
    
    var containerView: UIView!
    
    var containerViewHeight = NSLayoutConstraint()
    
    lazy var heartsAnimation: LottieAnimationView = {
        let animationView = LottieAnimationView()
        animationView.animation = LottieAnimation.named("AllTracksAnimation.json")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFill
        animationView.backgroundColor = UIColor(red: 225/255, green: 158/255, blue: 140/255, alpha: 1)
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
        return animationView
    }()
    
    lazy var strechyHeaderImage: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "iLikeImage")
        return view
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 100, weight: .bold, scale: .large)
        button.layer.cornerRadius = button.frame.size.width / 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.circle.fill", withConfiguration: config), for: .normal)
        button.clipsToBounds = true
        button.tintColor = .systemYellow
        return button
    }()
    
    private lazy var playOrPauseLabelForButton: UILabel = {
        let label = UILabel()
        label.text = "Слушать"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var iLikeLabel: UILabel = {
        let label = UILabel()
        label.text = "Мне нравится"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = button.frame.size.width / 2
        let config = UIImage.SymbolConfiguration(pointSize: 60, weight: .light, scale: .large)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.down", withConfiguration: config), for: .normal)
        button.tintColor = .white
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var downloadLabel: UILabel = {
        let label = UILabel()
        label.text = "Скачать"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createViews()
        
        setViewConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createViews() {
        // Container View
        containerView = UIView()
        containerView.backgroundColor = .systemRed
        addSubview(containerView)
        addSubview(downloadLabel)
        addSubview(downloadButton)
        addSubview(playButton)
        addSubview(playOrPauseLabelForButton)
        addSubview(iLikeLabel)

        //containerView.addSubview(heartsAnimation)
        containerView.addSubview(strechyHeaderImage)
        containerView.addSubview(downloadLabel)
        containerView.addSubview(downloadButton)
        containerView.addSubview(playButton)
        containerView.addSubview(playOrPauseLabelForButton)
        containerView.addSubview(iLikeLabel)
    }
    
    func setViewConstraints() {
        // UIView Constraints
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            self.heightAnchor.constraint(equalTo: containerView.heightAnchor),
            
            iLikeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            iLikeLabel.bottomAnchor.constraint(equalTo: playButton.topAnchor, constant: -16),
            
            playOrPauseLabelForButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playOrPauseLabelForButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            playButton.bottomAnchor.constraint(equalTo: playOrPauseLabelForButton.topAnchor, constant: -20),
            playButton.widthAnchor.constraint(equalToConstant: 60),
            playButton.heightAnchor.constraint(equalToConstant: 60),
            playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            downloadLabel.centerYAnchor.constraint(equalTo: playOrPauseLabelForButton.centerYAnchor),
            downloadLabel.trailingAnchor.constraint(equalTo: playOrPauseLabelForButton.leadingAnchor, constant: -40),
            downloadButton.bottomAnchor.constraint(equalTo: downloadLabel.topAnchor, constant: -20),
            downloadButton.centerXAnchor.constraint(equalTo: downloadLabel.centerXAnchor),
            downloadButton.heightAnchor.constraint(equalToConstant: 60),
            downloadButton.widthAnchor.constraint(equalToConstant: 60),
        ])
        
        // Container View Constraints
        containerView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.widthAnchor.constraint(equalTo: heartsAnimation.widthAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: strechyHeaderImage.widthAnchor).isActive = true
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerViewHeight.isActive = true
        
        // Animation Constraints
        heartsAnimation.translatesAutoresizingMaskIntoConstraints = false
//        animationViewBottom = heartsAnimation.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
//        animationViewBottom.isActive = true
//        animationViewHeight = heartsAnimation.heightAnchor.constraint(equalTo: containerView.heightAnchor)
//        animationViewHeight.isActive = true
        
        //---
        strechyHeaderImage.translatesAutoresizingMaskIntoConstraints = false
        animationViewBottom = strechyHeaderImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        animationViewBottom.isActive = true
        animationViewHeight = strechyHeaderImage.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        animationViewHeight.isActive = true
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        //containerView.clipsToBounds = offsetY <= 0
        animationViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        animationViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}


