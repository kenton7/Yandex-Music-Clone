//
//  PlayerVIews.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 13.10.2023.
//

import UIKit
import AVFoundation
import MarqueeLabel

protocol IPlayer {
    var playlistNameLabel: UILabel { get }
    var whereIsPlayingLabel: UILabel { get }
    var whereIsPlayingButton: UIButton { get }
    var songListButton: UIButton { get }
    var downArrowButton: UIButton { get }
    var songStartTimeLabel: UILabel { get }
    var songFinishTimeLabel: UILabel { get }
    var playPauseButton: UIButton { get }
    var albumImage: UIImageView { get }
    var songNameLabel: UILabel { get }
    //var songAuthorLabel: UILabel { get }
    var slider: UISlider { get }
    var likeButton: UIButton { get }
    var dislikeButton: UIButton { get }
    var repeatButton: UIButton { get }
    var songTextButton: UIButton { get }
    var settingsButton: UIButton { get }
    var timerButton: UIButton { get }
    var shuffleButton: UIButton { get }
    var shareButton: UIButton { get }
    var detailSongMenuButton: UIButton { get }
    var albumImageCollectionView: UICollectionView { get }
    var backButton: UIButton { get }
    var forwardButton: UIButton { get }
}

class PlayerVIews: MainViews, IPlayer {
    
    var albumImageCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let itemWidth = UIScreen.main.bounds.width - 10
        let itemHeight = UIScreen.main.bounds.height - 10
        layout.itemSize = CGSize(width: itemWidth, height: 270)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(SongsCollectionViewCell.self, forCellWithReuseIdentifier: SongsCollectionViewCell.cellID)
        return collectionView
    }()
    
    lazy var bigRepeatButtonImageView: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(systemName: "repeat.1")
        view.tintColor = .white
        return view
    }()
    
    private let playlistNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0
        return stackView
    }()
    
    private let rightButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        return stackView
    }()
    
    private let whereIsPlayingStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 10
        return view
    }()
    
    let songInfoStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let controlButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let bottomButtonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 35), forImageIn: .normal)
        button.tintColor = .white
        return button
    }()
    
    var forwardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 35), forImageIn: .normal)
        button.setImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    var playlistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Плейлист «Мне нравится»"
        label.font = UIFont(name: "YandexSansText-Medium", size: 12)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    var whereIsPlayingLabel: UILabel = {
        let label = UILabel()
        label.text = "играет AirPods Pro (Ilya)"
        label.textColor = UIColor(red: 245/255, green: 209/255, blue: 100/255, alpha: 1)
        label.font = UIFont(name: "YandexSansText-Medium", size: 12)
        label.textAlignment = .center
        return label
    }()
    
    var whereIsPlayingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "airpodspro"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 20), forImageIn: .normal)
        button.tintColor = UIColor(red: 245/255, green: 209/255, blue: 100/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var songListButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 20), forImageIn: .normal)
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var downArrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 20), forImageIn: .normal)
        return button
    }()
    
    var songStartTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont(name: "YandexSansText-Medium", size: 12)
        label.text = "0:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var songFinishTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont(name: "YandexSansText-Medium", size: 12)
        label.text = "0:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var playPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        //высота картинки из SF Symbol
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 60), forImageIn: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    
    var albumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var songNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "YandexSansText-Medium", size: 17)
        label.text = "Имя трека"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var songAuthorLabel: MarqueeLabel = {
        let label = MarqueeLabel()
        label.frame = CGRect(x: 0, y: 0, width: 65, height: 30)
        label.textColor = .lightGray
        label.font = UIFont(name: "YandexSansText-Medium", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Автор трека"
        label.numberOfLines = 1
        label.type = .continuous
        label.fadeLength = 5.0
        label.leadingBuffer = 1.0
        label.trailingBuffer = 20.0
        label.animationCurve = .linear
        label.speed = .duration(10.0)
        return label
    }()
    
    var slider: UISlider = {
        let songSlider = UISlider()
        songSlider.minimumValue = 0
        songSlider.thumbTintColor = .white
        songSlider.minimumTrackTintColor = .white
        songSlider.maximumTrackTintColor = .gray
        songSlider.tintColor = .white
        songSlider.translatesAutoresizingMaskIntoConstraints = false
        songSlider.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
        return songSlider
    }()
    
    var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        //высота картинки из SF Symbol
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 20), forImageIn: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        return button
    }()
    
    var dislikeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart.slash"), for: .normal)
        //высота картинки из SF Symbol
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 20), forImageIn: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        return button
    }()
    
    var repeatButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "repeat"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 20), forImageIn: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        return button
    }()
    
    var songTextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "text.aligncenter"), for: .normal)
        //высота картинки из SF Symbol
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 20), forImageIn: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .gray
        return button
    }()
    
    var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        //высота картинки из SF Symbol
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 20), forImageIn: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .gray
        return button
    }()
    
    var timerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "timer"), for: .normal)
        //высота картинки из SF Symbol
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 20), forImageIn: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .gray
        return button
    }()
    
    var shuffleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "shuffle"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 20), forImageIn: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        return button
    }()
    
    var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 20), forImageIn: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        return button
    }()
    
    var detailSongMenuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 20), forImageIn: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        return button
    }()
    
    private lazy var viewForEqualSpacing: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var videoshot: UIView = {
       let view = UIView()
        //view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    
    lazy var artistImage: UIImageView = {
       let view = UIImageView()
        view.frame = CGRect(x: 30, y: 0, width: 50, height: 50)
        view.layer.cornerRadius = view.frame.width / 2
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "Lx24")
        return view
    }()
    
    lazy var artistImage2: UIImageView = {
        let view = UIImageView()
         view.frame = CGRect(x: 30, y: 0, width: 50, height: 50)
         view.layer.cornerRadius = view.frame.width / 2
         view.clipsToBounds = true
         view.translatesAutoresizingMaskIntoConstraints = false
         view.contentMode = .scaleAspectFill
         view.image = UIImage(named: "Lx24")
         return view
    }()
    
    lazy var moreThanTwoArtists: UILabel = {
       let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 20, height: 30)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 12)
        label.text = "+1"
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureViews() {
        
        let tabBarController = TabBarController()
        
        print(tabBarController.selectedIndex)
        
        addSubview(albumImageCollectionView)
        addSubview(downArrowButton)
        addSubview(playlistNameStackView)
        addSubview(songListButton)
        addSubview(whereIsPlayingStackView)
        addSubview(whereIsPlayingButton)
        addSubview(songInfoStackView)
        addSubview(rightButtonsStackView)
        addSubview(slider)
        addSubview(songStartTimeLabel)
        addSubview(songFinishTimeLabel)
        addSubview(controlButtonsStackView)
        addSubview(dislikeButton)
        addSubview(likeButton)
        addSubview(bottomButtonStackView)
        addSubview(viewForEqualSpacing)
        addSubview(artistImage)
        addSubview(artistImage2)
        addSubview(moreThanTwoArtists)
        //addSubview(videoshot)
        //insertSubview(videoshot, at: 0)
        
        whereIsPlayingStackView.addArrangedSubview(playlistNameLabel)
        whereIsPlayingStackView.addArrangedSubview(whereIsPlayingLabel)
        songInfoStackView.addArrangedSubview(songNameLabel)
        songInfoStackView.addArrangedSubview(songAuthorLabel)
        rightButtonsStackView.addArrangedSubview(shareButton)
        rightButtonsStackView.addArrangedSubview(detailSongMenuButton)
        controlButtonsStackView.addArrangedSubview(backButton)
        controlButtonsStackView.addArrangedSubview(playPauseButton)
        controlButtonsStackView.addArrangedSubview(forwardButton)
        bottomButtonStackView.addArrangedSubview(repeatButton)
        bottomButtonStackView.addArrangedSubview(settingsButton)
        bottomButtonStackView.addArrangedSubview(songTextButton)
        bottomButtonStackView.addArrangedSubview(timerButton)
        bottomButtonStackView.addArrangedSubview(shuffleButton)
        
        viewForEqualSpacing.addSubview(controlButtonsStackView)
        
//        let screenSize = UIScreen.main.bounds.size
//        let cellHeight = floor(screenSize.height * 0.6)
//        let cellWidth = floor(screenSize.width * 0.6)
//        let insetY = (bounds.height - cellHeight) / 2.0
//        let insetX = (bounds.width - cellWidth) / 2.0
//        
//        albumImageCollectionView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        NSLayoutConstraint.activate([
            downArrowButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            downArrowButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            
            songListButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            songListButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            
            whereIsPlayingStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            whereIsPlayingStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            albumImageCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            albumImageCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            albumImageCollectionView.topAnchor.constraint(equalTo: whereIsPlayingStackView.safeAreaLayoutGuide.bottomAnchor, constant: 50),
            albumImageCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35),
            
            
            whereIsPlayingButton.trailingAnchor.constraint(equalTo: songListButton.leadingAnchor, constant: -10),
            whereIsPlayingButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            
            artistImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            artistImage.topAnchor.constraint(equalTo: albumImageCollectionView.bottomAnchor, constant: 20),
            artistImage.heightAnchor.constraint(equalToConstant: 50),
            artistImage.widthAnchor.constraint(equalToConstant: 50),
            
            artistImage2.leadingAnchor.constraint(equalTo: artistImage.trailingAnchor, constant: -20),
            artistImage2.topAnchor.constraint(equalTo: artistImage.topAnchor),
            artistImage2.heightAnchor.constraint(equalToConstant: 50),
            artistImage2.widthAnchor.constraint(equalToConstant: 50),
            
            moreThanTwoArtists.leadingAnchor.constraint(equalTo: artistImage2.trailingAnchor, constant: -20),
            moreThanTwoArtists.bottomAnchor.constraint(equalTo: artistImage2.bottomAnchor),
            moreThanTwoArtists.heightAnchor.constraint(equalToConstant: 20),
            moreThanTwoArtists.widthAnchor.constraint(equalToConstant: 30),
            
            
            //songInfoStackView.leadingAnchor.constraint(equalTo: artistImage.trailingAnchor, constant: 20),
            //songInfoStackView.topAnchor.constraint(equalTo: albumImageCollectionView.bottomAnchor, constant: 20),
            songInfoStackView.heightAnchor.constraint(equalToConstant: 40),
            songInfoStackView.centerYAnchor.constraint(equalTo: artistImage.centerYAnchor),
            songInfoStackView.trailingAnchor.constraint(equalTo: rightButtonsStackView.leadingAnchor, constant: -10),
            //songAuthorLabel.widthAnchor.constraint(equalToConstant: songInfoStackView.bounds.width),
            
            rightButtonsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            rightButtonsStackView.centerYAnchor.constraint(equalTo: songInfoStackView.centerYAnchor),
            rightButtonsStackView.heightAnchor.constraint(equalToConstant: 20),
            rightButtonsStackView.widthAnchor.constraint(equalToConstant: 70),
            
            
            slider.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            slider.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            slider.topAnchor.constraint(equalTo: songInfoStackView.bottomAnchor, constant: 40),
            
            songStartTimeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            songStartTimeLabel.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 5),
            songFinishTimeLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            songFinishTimeLabel.centerYAnchor.constraint(equalTo: songStartTimeLabel.centerYAnchor),
            
            controlButtonsStackView.centerXAnchor.constraint(equalTo: viewForEqualSpacing.centerXAnchor),
            controlButtonsStackView.centerYAnchor.constraint(equalTo: viewForEqualSpacing.centerYAnchor),
            
            dislikeButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            dislikeButton.centerYAnchor.constraint(equalTo: controlButtonsStackView.centerYAnchor),
            likeButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            likeButton.centerYAnchor.constraint(equalTo: controlButtonsStackView.centerYAnchor),
            
            bottomButtonStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            bottomButtonStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            bottomButtonStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            bottomButtonStackView.heightAnchor.constraint(equalToConstant: 40),
            
            viewForEqualSpacing.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            viewForEqualSpacing.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            viewForEqualSpacing.topAnchor.constraint(equalTo: songStartTimeLabel.bottomAnchor, constant: 10),
            viewForEqualSpacing.bottomAnchor.constraint(equalTo: bottomButtonStackView.topAnchor, constant: -10),
            
//            videoshot.trailingAnchor.constraint(equalTo: trailingAnchor),
//            videoshot.leadingAnchor.constraint(equalTo: leadingAnchor),
//            videoshot.topAnchor.constraint(equalTo: topAnchor),
//            videoshot.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
