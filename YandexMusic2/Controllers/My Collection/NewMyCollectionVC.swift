//
//  NewMyCollectionVC.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 25.11.2023.
//

import UIKit

final class NewMyCollectionVC: UIViewController {
    
    private let newMyCollectionViews = NewMyCollectionViews()
    private var handleStartPlayingXAnchor = NSLayoutConstraint()
    private var handleStartPlayingYAnchor = NSLayoutConstraint()
    private var selectTrackInTableViewXAnchor = NSLayoutConstraint()
    private var selectTrackInTableViewYAnchor = NSLayoutConstraint()
    var selectedIndexPath: IndexPath?
    
    override func loadView() {
        super.loadView()
        view = newMyCollectionViews
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Коллекция"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(searchButtonPressed))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        navigationItem.setLeftBarButtonItems([
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: #selector(profileButtonPressed)),
        ], animated: true)
        navigationItem.leftBarButtonItems?.forEach { $0.tintColor = .white }
        
        newMyCollectionViews.tableView.delegate = self
        newMyCollectionViews.tableView.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(miniPlayerPressed))
        newMyCollectionViews.miniPlayer.addGestureRecognizer(tap)
        newMyCollectionViews.sliderOnMiniPlayer.maximumValue = Float(AudioPlayer.shared.duration)
        newMyCollectionViews.playPauseButtonMiniPlayer.addTarget(self, action: #selector(playPausePressed), for: .touchUpInside)
        
        tabBarController?.tabBar.isTranslucent = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.string(forKey: "songName") == nil && UserDefaults.standard.string(forKey: "songAuthor") == nil {
            newMyCollectionViews.miniPlayer.isHidden = true
            newMyCollectionViews.sliderOnMiniPlayer.isHidden = true
            newMyCollectionViews.songName.isHidden = true
            newMyCollectionViews.songAuthor.isHidden = true
            newMyCollectionViews.likeButtonMiniPlayer.isHidden = true
            newMyCollectionViews.changeSourcePlayingMiniPlayer.isHidden = true
            newMyCollectionViews.playPauseButtonMiniPlayer.isHidden = true
        } else {
            newMyCollectionViews.miniPlayer.isHidden = false
            newMyCollectionViews.sliderOnMiniPlayer.isHidden = false
            newMyCollectionViews.songName.isHidden = false
            newMyCollectionViews.songAuthor.isHidden = false
            newMyCollectionViews.likeButtonMiniPlayer.isHidden = false
            newMyCollectionViews.changeSourcePlayingMiniPlayer.isHidden = false
            newMyCollectionViews.playPauseButtonMiniPlayer.isHidden = false
        }
        
        newMyCollectionViews.songName.text = UserDefaults.standard.string(forKey: "songName")
        newMyCollectionViews.songAuthor.text = UserDefaults.standard.string(forKey: "songAuthor")
        newMyCollectionViews.sliderOnMiniPlayer.maximumValue = UserDefaults.standard.float(forKey: "maximumValue")
        newMyCollectionViews.sliderOnMiniPlayer.value = UserDefaults.standard.float(forKey: "valueSlider")
        
        if AudioPlayer.shared.player?.isPlaying == true {
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
            newMyCollectionViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        } else {
            newMyCollectionViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        }
        
        view.layoutSubviews()
    }
    
    @objc private func playPausePressed() {
        
        //isPlayButtonPressed.toggle()
        
        if AudioPlayer.shared.player?.isPlaying == true {
            newMyCollectionViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
            AudioPlayer.shared.player?.pause()
        } else {
    
            let getNeededTrack = SongModel.getSongs().filter { $0.songAuthor == newMyCollectionViews.songAuthor.text && $0.songName == newMyCollectionViews.songName.text }.first
            let currentSliderValue = UserDefaults.standard.float(forKey: "valueSlider")
            AudioPlayer.shared.currentTrack = getNeededTrack
            AudioPlayer.shared.play(song: getNeededTrack!)
            AudioPlayer.shared.player?.currentTime = TimeInterval(newMyCollectionViews.sliderOnMiniPlayer.value)
            //mainViews.sliderOnMiniPlayer.value = UserDefaults.standard.float(forKey: "valueSlider")
            newMyCollectionViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            AudioPlayer.shared.player?.play()
        }
    }
    
    @objc private func updateTime() {
        newMyCollectionViews.sliderOnMiniPlayer.value = Float(AudioPlayer.shared.player?.currentTime ?? 0)
        if AudioPlayer.shared.player?.isPlaying == true {
            newMyCollectionViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        } else {
            newMyCollectionViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        }
    }
    
    @objc private func miniPlayerPressed() {
        let playerVC = PlayerVC()
        playerVC.modalPresentationStyle = .fullScreen
        present(playerVC, animated: true)
    }
    
    @objc private func myWaveCollectionPressed() {
        print("my wave collection pressed")
    }
    
    @objc private func searchButtonPressed() {
        print("pressed")
    }
    
    @objc private func profileButtonPressed() {
        print("Pressed")
    }

}

extension NewMyCollectionVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = MyCollectionWaveTableViewCell(style: .default, reuseIdentifier: MyCollectionWaveTableViewCell.cellID)
            cell.myWaveCollectionButton.addTarget(self, action: #selector(myWaveCollectionPressed), for: .touchUpInside)
            return cell
        case 1:
            let cell = ILikeTableViewCell(style: .default, reuseIdentifier: ILikeTableViewCell.cellID)
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            return cell
        case 2:
            let cell = MoreInYourCollectionTableViewCell(style: .default, reuseIdentifier: MoreInYourCollectionTableViewCell.cellID)
            return cell
        case 3:
            let cell = FavouriteArtistsTableViewCell(style: .default, reuseIdentifier: FavouriteArtistsTableViewCell.cellID)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 65
        case 1:
            return 250
        case 2:
            return 120
        case 3:
            return 130
        default:
            return UITableView.automaticDimension
        }
    }
}

extension NewMyCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SongModel.getSongs().count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ILikeCollectionViewCell.cellID, for: indexPath) as! ILikeCollectionViewCell
        
        //удаляем кастмное выделение, если оно уже установлено
        cell.subviews.forEach {
            if $0.tag == 100 {
                $0.removeFromSuperview()
            }
        }
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = #colorLiteral(red: 0.07843136042, green: 0.07843136042, blue: 0.07843136042, alpha: 1)
        
        cell.songName.text = SongModel.getSongs()[indexPath.item].songName
        cell.songAuthor.text = SongModel.getSongs()[indexPath.item].songAuthor
        cell.songImage.image = SongModel.getSongs()[indexPath.item].albumImage
        
        if cell.songName.text == AudioPlayer.shared.currentTrack?.songName && cell.songAuthor.text == AudioPlayer.shared.currentTrack?.songAuthor && AudioPlayer.shared.player?.isPlaying == true {
            cell.songImage.addSubview(newMyCollectionViews.trackPlayingAnimation)
            newMyCollectionViews.trackPlayingAnimation.isHidden = false
            selectTrackInTableViewXAnchor.isActive = false
            selectTrackInTableViewYAnchor.isActive = false
            cell.insertSubview(bgColorView, at: 0)
            bgColorView.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
            bgColorView.tag = 100
            
            // Сохраняем индекс текущей ячейки
            selectedIndexPath = indexPath
        }
        if indexPath.row == SongModel.getSongs().last?.trackID {
            cell.explicitImageView.isHidden = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = #colorLiteral(red: 0.07843136042, green: 0.07843136042, blue: 0.07843136042, alpha: 1)
        newMyCollectionViews.trackPlayingAnimation.isHidden = false
        
        let cell = collectionView.cellForItem(at: indexPath) as! ILikeCollectionViewCell
        cell.selectedBackgroundView = bgColorView
        cell.songImage.addSubview(newMyCollectionViews.trackPlayingAnimation)
        handleStartPlayingXAnchor = newMyCollectionViews.trackPlayingAnimation.centerXAnchor.constraint(equalTo: cell.songImage.centerXAnchor)
        handleStartPlayingXAnchor.isActive = true
        handleStartPlayingYAnchor = newMyCollectionViews.trackPlayingAnimation.centerYAnchor.constraint(equalTo: cell.songImage.centerYAnchor)
        handleStartPlayingYAnchor.isActive = true
        
        // Удаляем кастомное выделение из предыдущей выбранной ячейки
        if let selectedIndexPath = selectedIndexPath, let selectedCell = collectionView.cellForItem(at: selectedIndexPath) as? ILikeCollectionViewCell {
            
            selectedCell.subviews.forEach {
                if $0.tag == 100 {
                    $0.removeFromSuperview()
                }
            }
        }
        
        newMyCollectionViews.songAuthor.text = SongModel.getSongs()[indexPath.item].songAuthor
        newMyCollectionViews.songName.text = SongModel.getSongs()[indexPath.item].songName
        
        newMyCollectionViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        AudioPlayer.shared.currentTrack = SongModel.getSongs()[indexPath.item]
        AudioPlayer.shared.play(song: AudioPlayer.shared.currentTrack!)
        AudioPlayer.shared.player?.play()
        
        newMyCollectionViews.sliderOnMiniPlayer.maximumValue = Float(AudioPlayer.shared.duration)
        UserDefaults.standard.set(newMyCollectionViews.songAuthor.text, forKey: "songAuthor")
        UserDefaults.standard.set(newMyCollectionViews.songName.text, forKey: "songName")
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
}
