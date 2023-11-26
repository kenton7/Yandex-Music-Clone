//
//  MiniPlayerView.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 11.11.2023.
//

import UIKit

class MiniPlayerView: UIView {
    
    static let shared = MiniPlayerView()
    
    lazy var miniPlayer: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        //blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurView)
        blurView.frame = view.bounds
        return view
    }()
    
    lazy var sliderOnMiniPlayer: UISlider = {
        let songSlider = UISlider()
        songSlider.minimumValue = 0
        songSlider.setThumbImage(UIImage(), for: .normal)
        songSlider.minimumTrackTintColor = UIColor(red: 245/255, green: 209/255, blue: 100/255, alpha: 1)
        songSlider.maximumTrackTintColor = .darkGray
        songSlider.translatesAutoresizingMaskIntoConstraints = false
        songSlider.isUserInteractionEnabled = false
        songSlider.value = UserDefaults.standard.float(forKey: "valueSlider")
        songSlider.maximumValue = UserDefaults.standard.float(forKey: "maximumValue")
        return songSlider
    }()
    
    lazy var songAuthor: UILabel = {
        let label = UILabel()
        label.text = UserDefaults.standard.string(forKey: "trackArtist")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont(name: "YandexSansText-Medium", size: 12)
        label.text = UserDefaults.standard.string(forKey: "songAuthor")
        return label
    }()
    
    lazy var songName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = UserDefaults.standard.string(forKey: "songName")
        return label
    }()
    
    lazy var likeButtonMiniPlayer: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: "heart.fill", withConfiguration: config), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemYellow
        return button
    }()
    
    lazy var changeSourcePlayingMiniPlayer: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: "airpodsmax", withConfiguration: config), for: .normal)
        button.tintColor = .systemYellow
        return button
    }()
    
    lazy var playPauseButtonMiniPlayer: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold, scale: .large)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.fill", withConfiguration: config), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    lazy var miniPlayerCollectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        //layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.layer.cornerRadius = 8
        collectionView.register(MiniPlayerCollectionViewCell.self, forCellWithReuseIdentifier: MiniPlayerCollectionViewCell.cellID)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
                
        //addSubview(miniPlayer)
        //addSubview(likeButtonMiniPlayer)
        //addSubview(songName)
        //addSubview(songAuthor)
        //addSubview(changeSourcePlayingMiniPlayer)
        //addSubview(playPauseButtonMiniPlayer)
        //addSubview(sliderOnMiniPlayer)
        
        insertSubview(miniPlayer, at: 1)
        miniPlayer.addSubview(miniPlayerCollectionView)
        //insertSubview(likeButtonMiniPlayer, at: 1)
        
        
        NSLayoutConstraint.activate([
            
            miniPlayer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            miniPlayer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            miniPlayer.heightAnchor.constraint(equalToConstant: 65),
            miniPlayer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            miniPlayerCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            miniPlayerCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            miniPlayerCollectionView.centerYAnchor.constraint(equalTo: miniPlayer.centerYAnchor),
            miniPlayerCollectionView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func updateTime() {
        //mainViews.sliderOnMiniPlayer.value = UserDefaults.standard.float(forKey: "valueSlider")
        let cell = miniPlayerCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as! MiniPlayerCollectionViewCell
        cell.sliderOnMiniPlayer.value = Float(AudioPlayer.shared.currentTime)
        //mainViews.sliderOnMiniPlayer.value = Float(AudioPlayer.shared.currentTime)
        UserDefaults.standard.set(sliderOnMiniPlayer.value, forKey: "valueSlider")
    }
    
    @objc private func playButtonPressed() {

        if AudioPlayer.shared.player?.isPlaying == true {
            playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
            AudioPlayer.shared.player?.pause()
        } else {
            let getNeededTrack = SongModel.getSongs().filter { $0.songAuthor == songAuthor.text && $0.songName == songName.text }.first
            let currentSliderValue = UserDefaults.standard.float(forKey: "valueSlider")
            AudioPlayer.shared.currentTrack = getNeededTrack
            AudioPlayer.shared.play(song: AudioPlayer.shared.currentTrack ?? getNeededTrack!)
            AudioPlayer.shared.player?.currentTime = TimeInterval(sliderOnMiniPlayer.value)
            playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            AudioPlayer.shared.player?.play()
        }
    }
}

extension MiniPlayerView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SongModel.getSongs().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MiniPlayerCollectionViewCell.cellID, for: indexPath) as! MiniPlayerCollectionViewCell
        cell.playPauseButtonMiniPlayer.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        cell.trackImage.image = AudioPlayer.shared.currentTrack?.albumImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let frameSize = collectionView.frame.size
        return CGSize(width: frameSize.width - 10, height: frameSize.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}
