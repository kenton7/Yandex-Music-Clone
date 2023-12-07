//
//  NewMyCollectionVC.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 25.11.2023.
//

import UIKit

final class NewMyCollectionVC: UIViewController {
    
    private let newMyCollectionViews = NewMyCollectionViews()
    private var playingAnimationXAnchor = NSLayoutConstraint()
    private var playingAnimationYAnchor = NSLayoutConstraint()
    private var selectTrackInTableViewXAnchor = NSLayoutConstraint()
    private var selectTrackInTableViewYAnchor = NSLayoutConstraint()
    var selectedIndexPath: IndexPath?
    lazy var selectedTrackIndex: Int = AudioPlayer.shared.currentTrack?.trackID ?? 0
    
    private var isSongPlaying: Bool {
        if AudioPlayer.shared.player?.isPlaying == true {
            return true
        } else {
            return false
        }
    }
    
    private var isScrolledAndPlayed = false
    
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
        
        //guard let getNeededTrack = SongModel.getSongs().filter({ $0.songAuthor == newMyCollectionViews.songAuthor.text && $0.songName == newMyCollectionViews.songName.text }).first else { return }
        //AudioPlayer.shared.setTrack(track: getNeededTrack)
        
        
        newMyCollectionViews.tableView.delegate = self
        newMyCollectionViews.tableView.dataSource = self
        
        newMyCollectionViews.miniPlayerCollectionView.delegate = self
        newMyCollectionViews.miniPlayerCollectionView.dataSource = self
        
        //let tap = UITapGestureRecognizer(target: self, action: #selector(miniPlayerPressed))
        //newMyCollectionViews.miniPlayer.addGestureRecognizer(tap)
        newMyCollectionViews.sliderOnMiniPlayer.maximumValue = Float(AudioPlayer.shared.duration)
        newMyCollectionViews.playPauseButtonMiniPlayer.addTarget(self, action: #selector(playPausePressed), for: .touchUpInside)
        
        tabBarController?.tabBar.isTranslucent = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let cell = newMyCollectionViews.miniPlayerCollectionView.cellForItem(at: IndexPath(item: UserDefaults.standard.integer(forKey: "trackIndex"), section: 0)) as? MiniPlayerCollectionViewCell
        
        cell?.songName.text = UserDefaults.standard.string(forKey: "songName")
        cell?.songAuthor.text = UserDefaults.standard.string(forKey: "songAuthor")
        cell?.sliderOnMiniPlayer.maximumValue = UserDefaults.standard.float(forKey: "maximumValue")
        
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
    
    @objc private func playPausePressed() {
        
        //guard let selectedTrackIndex = selectedTrackIndex else { return }
        isScrolledAndPlayed.toggle()
        
        let cell = newMyCollectionViews.miniPlayerCollectionView.cellForItem(at: IndexPath(item: selectedTrackIndex, section: 0)) as? MiniPlayerCollectionViewCell
        
        if isSongPlaying == true {
            cell?.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
            AudioPlayer.shared.player?.pause()
        } else {
            print("here")
            cell?.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            AudioPlayer.shared.player?.play()
        }
    }
    
    @objc private func updateTime() {
        
        let cell = newMyCollectionViews.miniPlayerCollectionView.cellForItem(at: IndexPath(item: selectedTrackIndex, section: 0)) as? MiniPlayerCollectionViewCell
        cell?.songName.text = AudioPlayer.shared.currentTrack?.songName
        cell?.songAuthor.text = AudioPlayer.shared.currentTrack?.songAuthor
        cell?.trackImage.image = AudioPlayer.shared.currentTrack?.albumImage
        cell?.sliderOnMiniPlayer.value = Float(AudioPlayer.shared.currentTime)
        
        if AudioPlayer.shared.player?.isPlaying == true {
            cell?.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        }
        
        cell?.sliderOnMiniPlayer.value = Float(AudioPlayer.shared.player?.currentTime ?? 0)
        UserDefaults.standard.set(newMyCollectionViews.sliderOnMiniPlayer.value, forKey: "valueSlider")
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
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
}

extension NewMyCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SongModel.getSongs().count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == newMyCollectionViews.miniPlayerCollectionView {
            let frameSize = collectionView.frame.size
            return CGSize(width: frameSize.width - 10, height: frameSize.height)
        } else {
            return CGSize(width: view.frame.width, height: 60)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == newMyCollectionViews.miniPlayerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MiniPlayerCollectionViewCell.cellID, for: indexPath) as! MiniPlayerCollectionViewCell
            if cell.playPauseButtonMiniPlayer.allTargets.isEmpty {
                // Устанавливаем таргет только если его нет
                cell.playPauseButtonMiniPlayer.addTarget(self, action: #selector(playPausePressed), for: .touchUpInside)
            }
            return cell
        }

        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ILikeCollectionViewCell.cellID, for: indexPath) as! ILikeCollectionViewCell
            //удаляем кастмное выделение, если оно уже установлено
            cell.subviews.forEach {
                if $0.tag == 100 {
                    $0.removeFromSuperview()
                }
            }
            
            let customCellSelectionView = UIView()
            customCellSelectionView.backgroundColor = #colorLiteral(red: 0.07843136042, green: 0.07843136042, blue: 0.07843136042, alpha: 1)
            
            cell.songName.text = SongModel.getSongs()[indexPath.item].songName
            cell.songAuthor.text = SongModel.getSongs()[indexPath.item].songAuthor
            cell.songImage.image = SongModel.getSongs()[indexPath.item].albumImage
            
            if cell.songName.text == AudioPlayer.shared.currentTrack?.songName && cell.songAuthor.text == AudioPlayer.shared.currentTrack?.songAuthor && AudioPlayer.shared.player?.isPlaying == true {
                
                print("equal")
                cell.songImage.addSubview(newMyCollectionViews.trackPlayingAnimation)
                newMyCollectionViews.trackPlayingAnimation.centerXAnchor.constraint(equalTo: cell.songImage.centerXAnchor).isActive = true
                newMyCollectionViews.trackPlayingAnimation.centerYAnchor.constraint(equalTo: cell.songImage.centerYAnchor).isActive = true
                newMyCollectionViews.trackPlayingAnimation.isHidden = false
                selectTrackInTableViewXAnchor.isActive = false
                selectTrackInTableViewYAnchor.isActive = false
                cell.insertSubview(customCellSelectionView, at: 0)
                customCellSelectionView.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
                customCellSelectionView.tag = 100
                
                // Сохраняем индекс текущей ячейки
                selectedIndexPath = indexPath
            }
            if indexPath.row == SongModel.getSongs().last?.trackID {
                cell.explicitImageView.isHidden = false
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
                
        if let cell = cell as? MiniPlayerCollectionViewCell {
            print("indexPath \(indexPath.item)")
            //AudioPlayer.shared.setTrack(track: SongModel.getSongs()[indexPath.item])
            if AudioPlayer.shared.player?.isPlaying == true {
                print("playing")
                cell.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
                AudioPlayer.shared.player?.play()
            }
            cell.songName.text = SongModel.getSongs()[selectedTrackIndex].songName
            cell.songAuthor.text = SongModel.getSongs()[selectedTrackIndex].songAuthor
            cell.trackImage.image = SongModel.getSongs()[selectedTrackIndex].albumImage
            cell.sliderOnMiniPlayer.maximumValue = Float(AudioPlayer.shared.player?.duration ?? 0)
            UserDefaults.standard.set(cell.songName.text, forKey: "songName")
            UserDefaults.standard.set(cell.songAuthor.text, forKey: "songAuthor")
            selectedTrackIndex = indexPath.item
            UserDefaults.standard.set(selectedTrackIndex, forKey: "trackIndex")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let miniPlayerCell = newMyCollectionViews.miniPlayerCollectionView.cellForItem(at: IndexPath(item: selectedTrackIndex, section: 0)) as! MiniPlayerCollectionViewCell
        
        if collectionView == newMyCollectionViews.miniPlayerCollectionView {
            let newTrack = SongModel.getSongs()[indexPath.item]
            let player = PlayerVC()
            player.currentTrack = AudioPlayer.shared.currentTrack!
            //player.audioPlayer = AudioPlayer.shared.player
            player.modalPresentationStyle = .overFullScreen
            present(player, animated: true)
        } else {
            let bgColorView = UIView()
            bgColorView.backgroundColor = #colorLiteral(red: 0.07843136042, green: 0.07843136042, blue: 0.07843136042, alpha: 1)
            newMyCollectionViews.trackPlayingAnimation.isHidden = false
            
            let cell = collectionView.cellForItem(at: indexPath) as! ILikeCollectionViewCell
            cell.selectedBackgroundView = bgColorView
            cell.songImage.addSubview(newMyCollectionViews.trackPlayingAnimation)
            playingAnimationXAnchor = newMyCollectionViews.trackPlayingAnimation.centerXAnchor.constraint(equalTo: cell.songImage.centerXAnchor)
            playingAnimationXAnchor.isActive = true
            playingAnimationYAnchor = newMyCollectionViews.trackPlayingAnimation.centerYAnchor.constraint(equalTo: cell.songImage.centerYAnchor)
            playingAnimationYAnchor.isActive = true
            
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == newMyCollectionViews.miniPlayerCollectionView {
            return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        } else {
            return UIEdgeInsets()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let cell = newMyCollectionViews.miniPlayerCollectionView.cellForItem(at: IndexPath(item: selectedTrackIndex, section: 0)) as? MiniPlayerCollectionViewCell
        
        if isScrolledAndPlayed == true {
            AudioPlayer.shared.player?.play()
            cell?.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        }
    }
}
