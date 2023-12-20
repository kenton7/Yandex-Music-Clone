//
//  AllMyTracksCollectionViewController.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 18.12.2023.
//

import UIKit

fileprivate let headerID = "headerID"

class AllMyTracksCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let appearance = UINavigationBarAppearance()
    var headerView: HeaderView?
    var selectedIndexPath: IndexPath?
    private var handleStartPlayingXAnchor = NSLayoutConstraint()
    private var handleStartPlayingYAnchor = NSLayoutConstraint()
    private var selectTrackInTableViewXAnchor = NSLayoutConstraint()
    private var selectTrackInTableViewYAnchor = NSLayoutConstraint()
    private let miniPlayerView = MiniPlayerView()
    private var allMyTracksView = AllMyTracksViews()
    private var isScrolledAndPlayed = false
    lazy var selectedTrackIndex: Int = AudioPlayer.shared.currentTrack?.trackID ?? 0
    
    private var isSongPlaying: Bool {
        if AudioPlayer.shared.player?.isPlaying == true {
            return true
        } else {
            return false
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { // цвет статус бара
        return .lightContent
    }
    
    override func loadView() {
        super.loadView()
        view = allMyTracksView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.barTintColor = .clear
        navigationItem.setRightBarButtonItems([
            UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .done, target: self, action: #selector(moreButtonInNavigationPressed)),
            UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(searchPressed))
        ], animated: true)
        navigationItem.rightBarButtonItems?.forEach { $0.tintColor = .white }
        let backButton = UIBarButtonItem()
        backButton.tintColor = .white
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        allMyTracksView.collectionView.delegate = self
        allMyTracksView.collectionView.dataSource = self
        allMyTracksView.miniPlayerCollectionView.delegate = self
        allMyTracksView.miniPlayerCollectionView.dataSource = self
        //setupCollectionViewLayout()
        //setuoCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        
        let cell = allMyTracksView.miniPlayerCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? MiniPlayerCollectionViewCell
        
        cell?.songName.text = AudioPlayer.shared.currentTrack?.songName
        cell?.songAuthor.text = AudioPlayer.shared.currentTrack?.songAuthor
        cell?.sliderOnMiniPlayer.value = Float(AudioPlayer.shared.currentTime)
        cell?.sliderOnMiniPlayer.maximumValue = Float(AudioPlayer.shared.player?.duration ?? 0)
        cell?.trackImage.image = AudioPlayer.shared.currentTrack?.albumImage
        
        if AudioPlayer.shared.player?.isPlaying == true {
            print("playing")
            cell?.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        } else {
            print("fuck")
            cell?.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        }
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
        
        //newMyCollectionViews.miniPlayerCollectionView.scrollToItem(at: IndexPath(item: selectedTrackIndex, section: 0), at: .left, animated: false)
        view.layoutSubviews()
        
    }
    
    @objc private func moreButtonInNavigationPressed() {
        print("more button pressed")
    }
    
    @objc private func searchPressed() {
        print("search pressed")
    }
    
    @objc private func playPausePressed() {
        
        //guard let selectedTrackIndex = selectedTrackIndex else { return }
        isScrolledAndPlayed.toggle()
        
        let cell = allMyTracksView.miniPlayerCollectionView.cellForItem(at: IndexPath(item: selectedTrackIndex, section: 0)) as? MiniPlayerCollectionViewCell
        
        if isSongPlaying == true {
            cell?.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
            AudioPlayer.shared.player?.pause()
        } else {
            cell?.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            AudioPlayer.shared.player?.play()
        }
    }
    
    @objc private func updateTime() {
        
        let cell = allMyTracksView.miniPlayerCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? MiniPlayerCollectionViewCell
        cell?.songName.text = AudioPlayer.shared.currentTrack?.songName
        cell?.songAuthor.text = AudioPlayer.shared.currentTrack?.songAuthor
        cell?.trackImage.image = AudioPlayer.shared.currentTrack?.albumImage
        cell?.sliderOnMiniPlayer.value = Float(AudioPlayer.shared.currentTime)
        
        if AudioPlayer.shared.player?.isPlaying == true {
            cell?.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        } else {
            cell?.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        }
        
        cell?.sliderOnMiniPlayer.value = Float(AudioPlayer.shared.player?.currentTime ?? 0)
        UserDefaults.standard.set(AudioPlayer.shared.currentTime, forKey: "valueSlider")
    }
    
    //    fileprivate func setuoCollectionView() {
    //        collectionView.backgroundColor = .black
    //        collectionView.contentInsetAdjustmentBehavior = .never // игнорировать safeArea
    //        collectionView.register(AllMyTracksCollectionViewCell.self, forCellWithReuseIdentifier: AllMyTracksCollectionViewCell.cellID)
    //        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
    //
    //        //регаем Header у коллекшн вью
    //        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
    //    }
    //
    //    fileprivate func setupCollectionViewLayout() {
    //        //layout customization
    //        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
    //            layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    //            //layout.minimumLineSpacing = 40 // расстояние между ячейками
    //        }
    //    }
    
}
//MARK: - UICollectionView
extension AllMyTracksCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
        headerView = allMyTracksView.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as? HeaderView
        return headerView!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if collectionView == allMyTracksView.collectionView {
            return .init(width: view.frame.width, height: view.frame.height * 0.6)
        } else {
            return .init()
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SongModel.getSongs().count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == allMyTracksView.miniPlayerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MiniPlayerCollectionViewCell.cellID, for: indexPath) as! MiniPlayerCollectionViewCell
            if cell.playPauseButtonMiniPlayer.allTargets.isEmpty {
                // Устанавливаем таргет только если его нет
                cell.playPauseButtonMiniPlayer.addTarget(self, action: #selector(playPausePressed), for: .touchUpInside)
            }
            return cell
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllMyTracksCollectionViewCell.cellID, for: indexPath) as! AllMyTracksCollectionViewCell
            
            //удаляем кастмное выделение, если оно уже установлено
            cell.subviews.forEach {
                if $0.tag == 100 {
                    $0.removeFromSuperview()
                }
            }
            
            let bgColorView = UIView()
            bgColorView.backgroundColor = #colorLiteral(red: 0.07843136042, green: 0.07843136042, blue: 0.07843136042, alpha: 1)
            
            cell.songAuthor.text = SongModel.getSongs()[indexPath.row].songAuthor
            cell.songImage.image = SongModel.getSongs()[indexPath.row].albumImage
            cell.songName.text = SongModel.getSongs()[indexPath.row].songName
            
            if cell.songName.text == AudioPlayer.shared.currentTrack?.songName && cell.songAuthor.text == AudioPlayer.shared.currentTrack?.songAuthor && AudioPlayer.shared.player?.isPlaying == true {
                cell.songImage.addSubview(cell.trackPlayingAnimation)
                cell.trackPlayingAnimation.isHidden = false
                selectTrackInTableViewXAnchor.isActive = false
                selectTrackInTableViewYAnchor.isActive = false
                handleStartPlayingXAnchor = cell.trackPlayingAnimation.centerXAnchor.constraint(equalTo: cell.songImage.centerXAnchor)
                handleStartPlayingXAnchor.isActive = true
                handleStartPlayingYAnchor = cell.trackPlayingAnimation.centerYAnchor.constraint(equalTo: cell.songImage.centerYAnchor)
                handleStartPlayingYAnchor.isActive = true
                cell.insertSubview(bgColorView, at: 0)
                bgColorView.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
                bgColorView.tag = 100
                
                // Сохраняем индекс текущей ячейки
                selectedIndexPath = indexPath
            }
            if indexPath.item == SongModel.getSongs().last?.trackID {
                cell.explicitImageView.isHidden = false
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == allMyTracksView.miniPlayerCollectionView {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        } else {
            return .init(width: view.frame.width, height: 60)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        if collectionView == allMyTracksView.miniPlayerCollectionView {
            let newTrack = SongModel.getSongs()[indexPath.item]
            let player = PlayerVC()
            player.currentTrack = AudioPlayer.shared.currentTrack!
            //player.playerViews.artistImage.image = player.currentTrack?.artistImage.
            print(newTrack.artistImage)
            //player.audioPlayer = AudioPlayer.shared.player
            player.modalPresentationStyle = .overFullScreen
            present(player, animated: true)
        } else {
            let miniPlayerCell = allMyTracksView.miniPlayerCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as! MiniPlayerCollectionViewCell
            let bgColorView = UIView()
            bgColorView.backgroundColor = #colorLiteral(red: 0.07843136042, green: 0.07843136042, blue: 0.07843136042, alpha: 1)
            allMyTracksView.trackPlayingAnimation.isHidden = false
            
            let cell = collectionView.cellForItem(at: indexPath) as! AllMyTracksCollectionViewCell
            cell.selectedBackgroundView = bgColorView
            cell.songImage.addSubview(allMyTracksView.trackPlayingAnimation)
            handleStartPlayingXAnchor = allMyTracksView.trackPlayingAnimation.centerXAnchor.constraint(equalTo: cell.songImage.centerXAnchor)
            handleStartPlayingXAnchor.isActive = true
            handleStartPlayingYAnchor = allMyTracksView.trackPlayingAnimation.centerYAnchor.constraint(equalTo: cell.songImage.centerYAnchor)
            handleStartPlayingYAnchor.isActive = true
            
            // Удаляем кастомное выделение из предыдущей выбранной ячейки
            if let selectedIndexPath = selectedIndexPath, let selectedCell = collectionView.cellForItem(at: selectedIndexPath) as? ILikeCollectionViewCell {
                
                selectedCell.subviews.forEach {
                    if $0.tag == 100 {
                        $0.removeFromSuperview()
                    }
                }
            }
            
            miniPlayerCell.songName.text = SongModel.getSongs()[indexPath.item].songName
            miniPlayerCell.songAuthor.text = SongModel.getSongs()[indexPath.item].songAuthor
            miniPlayerCell.trackImage.image = SongModel.getSongs()[indexPath.item].albumImage
            
            allMyTracksView.songAuthor.text = SongModel.getSongs()[indexPath.item].songAuthor
            allMyTracksView.songName.text = SongModel.getSongs()[indexPath.item].songName
            
            allMyTracksView.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
            AudioPlayer.shared.currentTrack = SongModel.getSongs()[indexPath.item]
            AudioPlayer.shared.play(song: AudioPlayer.shared.currentTrack!)
            AudioPlayer.shared.player?.play()
            
            selectedTrackIndex = AudioPlayer.shared.currentTrack?.trackID ?? 0
            allMyTracksView.sliderOnMiniPlayer.maximumValue = Float(AudioPlayer.shared.duration)
            UserDefaults.standard.set(allMyTracksView.songAuthor.text, forKey: "songAuthor")
            UserDefaults.standard.set(allMyTracksView.songName.text, forKey: "songName")
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }
    }
}
