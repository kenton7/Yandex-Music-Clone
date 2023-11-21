//
//  ClipsTableViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 31.10.2023.
//

import UIKit
import WebKit
import youtube_ios_player_helper

class ClipsTableViewCell: UITableViewCell {
    
    static let cellID = "ClipsTableViewCell"
    
    private lazy var clipTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Время клипов"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "YandexSansText-Medium", size: 18)
        label.textColor = .white
        return label
    }()
    
    lazy var playerView: YTPlayerView = {
        let view = YTPlayerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = .black
        return view
    }()
    
    lazy var webView: WKWebView = {
        let view = WKWebView(frame: self.bounds)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = .clear
        view.isOpaque = false
        view.scrollView.isScrollEnabled = false
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        backgroundColor = .clear
        selectionStyle = .none
        contentView.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        contentView.addSubview(playerView)
        contentView.addSubview(clipTimeLabel)
        
        NSLayoutConstraint.activate([
            
            playerView.topAnchor.constraint(equalTo: topAnchor),
            playerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            playerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            clipTimeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            clipTimeLabel.bottomAnchor.constraint(equalTo: playerView.topAnchor, constant: -10)
        ])
    }
}
