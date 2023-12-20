//
//  AllMyTracksVC.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 09.11.2023.
//

import UIKit
import Lottie

final class AllMyTracksVC: UIViewController {
    
    private lazy var headerView = StretchyTableHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.5))
    
    private lazy var allMyTracksViews = AllMyTracksViews()
    
    private var handleStartPlayingXAnchor = NSLayoutConstraint()
    private var handleStartPlayingYAnchor = NSLayoutConstraint()
    private var selectTrackInTableViewXAnchor = NSLayoutConstraint()
    private var selectTrackInTableViewYAnchor = NSLayoutConstraint()
    
    private var isScrolledAndPlayed = false
    var selectedIndexPath: IndexPath?
    
    private var isSongPlaying: Bool {
        if AudioPlayer.shared.player?.isPlaying == true {
            return true
        } else {
            return false
        }
    }
    
    private var selectedTrackIndex: Int?
            
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AllMyTracksTableViewCell.self, forCellReuseIdentifier: AllMyTracksTableViewCell.cellID)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 10
        tableView.clipsToBounds = true
        return tableView
    }()
    
    override func loadView() {
        super.loadView()
        
        view = allMyTracksViews
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
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
        navigationController?.navigationBar.shadowImage = UIImage()
        
        //view.addSubview(tableView)
        //setupMiniPlayer()
        targets()
        //tableView.frame = view.bounds
//        allMyTracksViews.tableView.delegate = self
//        allMyTracksViews.tableView.dataSource = self
//        allMyTracksViews.miniPlayerCollectionView.delegate = self
//        allMyTracksViews.miniPlayerCollectionView.dataSource = self
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 62 * 2, right: 0)
//        tableView.tableHeaderView = headerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Скрываем view navigation bar'a
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
        
        //allMyTracksViews.tableView.reloadData()
        
        allMyTracksViews.songName.text = UserDefaults.standard.string(forKey: "songName")
        allMyTracksViews.songAuthor.text = UserDefaults.standard.string(forKey: "songAuthor")
        allMyTracksViews.sliderOnMiniPlayer.maximumValue = UserDefaults.standard.float(forKey: "maximumValue")
        allMyTracksViews.sliderOnMiniPlayer.value = UserDefaults.standard.float(forKey: "valueSlider")
        
        if AudioPlayer.shared.player?.isPlaying == true {
            allMyTracksViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        } else {
            allMyTracksViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        }
    }
    
    @objc private func moreButtonInNavigationPressed() {
        print("more button pressed")
    }
    
    @objc private func searchPressed() {
        print("search pressed")
    }
    
    @objc private func playButtonPressed() {
        
        guard let selectedIndexPath = selectedTrackIndex else { return }
        isScrolledAndPlayed.toggle()
        
        let cell = allMyTracksViews.miniPlayerCollectionView.cellForItem(at: IndexPath(item: selectedIndexPath, section: 0)) as? MiniPlayerCollectionViewCell
        
        if isSongPlaying == true {
            cell?.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
            AudioPlayer.shared.player?.pause()
        } else {
            cell?.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            AudioPlayer.shared.player?.play()
        }
    }
}

extension AllMyTracksVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SongModel.getSongs().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllMyTracksTableViewCell.cellID, for: indexPath) as! AllMyTracksTableViewCell
        
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
            cell.songImage.addSubview(allMyTracksViews.trackPlayingAnimation)
            allMyTracksViews.trackPlayingAnimation.isHidden = false
            selectTrackInTableViewXAnchor.isActive = false
            selectTrackInTableViewYAnchor.isActive = false
            handleStartPlayingXAnchor = allMyTracksViews.trackPlayingAnimation.centerXAnchor.constraint(equalTo: cell.songImage.centerXAnchor)
            handleStartPlayingXAnchor.isActive = true
            handleStartPlayingYAnchor = allMyTracksViews.trackPlayingAnimation.centerYAnchor.constraint(equalTo: cell.songImage.centerYAnchor)
            handleStartPlayingYAnchor.isActive = true
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = #colorLiteral(red: 0.07843136042, green: 0.07843136042, blue: 0.07843136042, alpha: 1)
        allMyTracksViews.trackPlayingAnimation.isHidden = false

        let cell = tableView.cellForRow(at: indexPath) as! AllMyTracksTableViewCell
    
        cell.selectedBackgroundView = bgColorView
        cell.songImage.addSubview(allMyTracksViews.trackPlayingAnimation)
        
        if AudioPlayer.shared.currentTrack == SongModel.getSongs()[indexPath.row] {
            miniPlayerPressed()
        }
        
        // Удаляем кастомное выделение из предыдущей выбранной ячейки
        if let selectedIndexPath = selectedIndexPath, let selectedCell = tableView.cellForRow(at: selectedIndexPath) as? AllMyTracksTableViewCell {
            
            selectedCell.subviews.forEach {
                if $0.tag == 100 {
                    $0.removeFromSuperview()
                }
            }
        }
        
        allMyTracksViews.songAuthor.text = SongModel.getSongs()[indexPath.row].songAuthor
        allMyTracksViews.songName.text = SongModel.getSongs()[indexPath.row].songName
        
        allMyTracksViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        AudioPlayer.shared.currentTrack = SongModel.getSongs()[indexPath.row]
        //print(AudioPlayer.shared.currentTrack!)
        //AudioPlayer.shared.setupPlayer(track: AudioPlayer.shared.currentTrack!)
        AudioPlayer.shared.play(song: AudioPlayer.shared.currentTrack!)
        AudioPlayer.shared.player?.play()
        //AudioPlayer.shared.play(song: AudioPlayer.shared.currentTrack!)
        
        if AudioPlayer.shared.player?.isPlaying == true {
            handleStartPlayingXAnchor.isActive = false
            handleStartPlayingYAnchor.isActive = false
            selectTrackInTableViewXAnchor = allMyTracksViews.trackPlayingAnimation.centerXAnchor.constraint(equalTo: cell.songImage.centerXAnchor)
            selectTrackInTableViewXAnchor.isActive = true
            selectTrackInTableViewYAnchor = allMyTracksViews.trackPlayingAnimation.centerYAnchor.constraint(equalTo: cell.songImage.centerYAnchor)
            selectTrackInTableViewYAnchor.isActive = true
            
//            allMyTracksViews.miniPlayer.isHidden = false
//            allMyTracksViews.sliderOnMiniPlayer.isHidden = false
//            allMyTracksViews.songName.isHidden = false
//            allMyTracksViews.songAuthor.isHidden = false
//            allMyTracksViews.likeButtonMiniPlayer.isHidden = false
//            allMyTracksViews.changeSourcePlayingMiniPlayer.isHidden = false
//            allMyTracksViews.playPauseButtonMiniPlayer.isHidden = false
        } else {
            selectTrackInTableViewXAnchor = allMyTracksViews.trackPlayingAnimation.centerXAnchor.constraint(equalTo: cell.songImage.centerXAnchor)
            selectTrackInTableViewXAnchor.isActive = false
            selectTrackInTableViewYAnchor = allMyTracksViews.trackPlayingAnimation.centerYAnchor.constraint(equalTo: cell.songImage.centerYAnchor)
            selectTrackInTableViewYAnchor.isActive = false
            allMyTracksViews.trackPlayingAnimation.isHidden = true
        }
        
        allMyTracksViews.sliderOnMiniPlayer.maximumValue = Float(AudioPlayer.shared.duration)
        UserDefaults.standard.set(allMyTracksViews.sliderOnMiniPlayer.maximumValue, forKey: "maximumValue")
        UserDefaults.standard.set(allMyTracksViews.songAuthor.text, forKey: "songAuthor")
        UserDefaults.standard.set(allMyTracksViews.songName.text, forKey: "songName")
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
}

//MARK: - UIScrollViewDelegate
//extension AllMyTracksVC: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let headerView = allMyTracksViews.tableView.tableHeaderView as! StretchyTableHeaderView
//        headerView.scrollViewDidScroll(scrollView: scrollView)
//    }
//}

//MARK: - UICollectionView
extension AllMyTracksVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SongModel.getSongs().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MiniPlayerCollectionViewCell.cellID, for: indexPath) as! MiniPlayerCollectionViewCell
        if cell.playPauseButtonMiniPlayer.allTargets.isEmpty {
            // Устанавливаем таргет только если его нет
            cell.playPauseButtonMiniPlayer.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let cell = cell as? MiniPlayerCollectionViewCell {
            AudioPlayer.shared.setTrack(track: SongModel.getSongs()[indexPath.item])
            if AudioPlayer.shared.player?.isPlaying == true {
                print("hrer")
                AudioPlayer.shared.player?.play()
            } else {
                AudioPlayer.shared.setTrack(track: SongModel.getSongs()[indexPath.item])
                //AudioPlayer.shared.player?.play()
            }
            print(SongModel.getSongs()[indexPath.item].songName)
            cell.songName.text = SongModel.getSongs()[indexPath.item].songName
            cell.songAuthor.text = SongModel.getSongs()[indexPath.item].songAuthor
            cell.trackImage.image = SongModel.getSongs()[indexPath.item].albumImage
            cell.sliderOnMiniPlayer.maximumValue = Float(AudioPlayer.shared.player!.duration)
            UserDefaults.standard.set(cell.songName.text, forKey: "songName")
            UserDefaults.standard.set(cell.songAuthor.text, forKey: "songAuthor")
            selectedTrackIndex = indexPath.item
            UserDefaults.standard.set(selectedTrackIndex, forKey: "trackIndex")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newTrack = SongModel.getSongs()[indexPath.item]
        print(newTrack)
        let player = PlayerVC()
        player.currentTrack = newTrack
        //player.playerViews.artistImage.image = player.currentTrack?.artistImage
        //player.audioPlayer = AudioPlayer.shared.player
        player.modalPresentationStyle = .overFullScreen
        present(player, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 10, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let cell = allMyTracksViews.miniPlayerCollectionView.cellForItem(at: IndexPath(item: selectedTrackIndex ?? 0, section: 0)) as? MiniPlayerCollectionViewCell
        
        if isScrolledAndPlayed == true {
            AudioPlayer.shared.player?.play()
            cell?.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        }
    }
}
    
private extension AllMyTracksVC {
    //MARK: - Targets for Buttons
    private func targets() {
        let miniPlayerTapGesture = UITapGestureRecognizer(target: self, action: #selector(miniPlayerPressed))
        allMyTracksViews.miniPlayer.addGestureRecognizer(miniPlayerTapGesture)
        
        allMyTracksViews.playPauseButtonMiniPlayer.addTarget(self, action: #selector(playOrPauseButtonPressed), for: .touchUpInside)
    }
    
    @objc private func miniPlayerPressed() {
        let getNeededTrack = SongModel.getSongs().filter { $0.songAuthor == allMyTracksViews.songAuthor.text && $0.songName == allMyTracksViews.songName.text }.first
        
        //let player = PlayerVC.shared
        let player = PlayerVC()
        player.updateTrack(AudioPlayer.shared.currentTrack ?? getNeededTrack)
        //player.currentTrack = AudioPlayer.shared.currentTrack ?? getNeededTrack
        //player.audioPlayer = AudioPlayer.shared.player
        player.modalPresentationStyle = .overFullScreen
        present(player, animated: true)
    }
    
    @objc private func playOrPauseButtonPressed() {
        if AudioPlayer.shared.player?.isPlaying == true {
            allMyTracksViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
            AudioPlayer.shared.player?.pause()
        } else {
            let getNeededTrack = SongModel.getSongs().filter { $0.songAuthor == allMyTracksViews.songAuthor.text && $0.songName == allMyTracksViews.songName.text }.first
            let currentSliderValue = UserDefaults.standard.float(forKey: "valueSlider")
            AudioPlayer.shared.currentTrack = getNeededTrack
            AudioPlayer.shared.play(song: AudioPlayer.shared.currentTrack ?? getNeededTrack!)
            AudioPlayer.shared.player?.currentTime = TimeInterval(allMyTracksViews.sliderOnMiniPlayer.value)
            allMyTracksViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            AudioPlayer.shared.player?.play()
        }
    }
    
    @objc private func updateTime() {
        allMyTracksViews.sliderOnMiniPlayer.value = Float(AudioPlayer.shared.currentTime)
        UserDefaults.standard.set(allMyTracksViews.sliderOnMiniPlayer.value, forKey: "valueSlider")
    }
}

extension Notification.Name {
    public static let sliderCurrentValue = Notification.Name(rawValue: "sliderCurrentValue")
    public static let miniPlayerSongAuthor = Notification.Name(rawValue: "miniPlayerSongAuthor")
    public static let miniPlayerSongName = Notification.Name(rawValue: "miniPlayerSongName")
}


