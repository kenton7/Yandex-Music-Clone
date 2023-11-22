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
    
    var selectedIndexPath: IndexPath?
            
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
        
        view.addSubview(tableView)
        setupMiniPlayer()
        targets()        
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        tableView.tableHeaderView = headerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Скрываем view navigation bar'a
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
        
        if UserDefaults.standard.string(forKey: "songName") == nil && UserDefaults.standard.string(forKey: "songAuthor") == nil {
            allMyTracksViews.miniPlayer.isHidden = true
            allMyTracksViews.sliderOnMiniPlayer.isHidden = true
            allMyTracksViews.songName.isHidden = true
            allMyTracksViews.songAuthor.isHidden = true
            allMyTracksViews.likeButtonMiniPlayer.isHidden = true
            allMyTracksViews.changeSourcePlayingMiniPlayer.isHidden = true
            allMyTracksViews.playPauseButtonMiniPlayer.isHidden = true
        } else {
            allMyTracksViews.miniPlayer.isHidden = false
            allMyTracksViews.sliderOnMiniPlayer.isHidden = false
            allMyTracksViews.songName.isHidden = false
            allMyTracksViews.songAuthor.isHidden = false
            allMyTracksViews.likeButtonMiniPlayer.isHidden = false
            allMyTracksViews.changeSourcePlayingMiniPlayer.isHidden = false
            allMyTracksViews.playPauseButtonMiniPlayer.isHidden = false
        }
        
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
        AudioPlayer.shared.play(song: AudioPlayer.shared.currentTrack!)
        
        if AudioPlayer.shared.player?.isPlaying == true {
            handleStartPlayingXAnchor.isActive = false
            handleStartPlayingYAnchor.isActive = false
            selectTrackInTableViewXAnchor = allMyTracksViews.trackPlayingAnimation.centerXAnchor.constraint(equalTo: cell.songImage.centerXAnchor)
            selectTrackInTableViewXAnchor.isActive = true
            selectTrackInTableViewYAnchor = allMyTracksViews.trackPlayingAnimation.centerYAnchor.constraint(equalTo: cell.songImage.centerYAnchor)
            selectTrackInTableViewYAnchor.isActive = true
            
            allMyTracksViews.miniPlayer.isHidden = false
            allMyTracksViews.sliderOnMiniPlayer.isHidden = false
            allMyTracksViews.songName.isHidden = false
            allMyTracksViews.songAuthor.isHidden = false
            allMyTracksViews.likeButtonMiniPlayer.isHidden = false
            allMyTracksViews.changeSourcePlayingMiniPlayer.isHidden = false
            allMyTracksViews.playPauseButtonMiniPlayer.isHidden = false
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

extension AllMyTracksVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = self.tableView.tableHeaderView as! StretchyTableHeaderView
        headerView.scrollViewDidScroll(scrollView: scrollView)
    }
}

private extension AllMyTracksVC {
    func setupMiniPlayer() {
        
        view.addSubview(allMyTracksViews.miniPlayer)
        view.addSubview(allMyTracksViews.likeButtonMiniPlayer)
        view.addSubview(allMyTracksViews.songName)
        view.addSubview(allMyTracksViews.songAuthor)
        view.addSubview(allMyTracksViews.changeSourcePlayingMiniPlayer)
        view.addSubview(allMyTracksViews.playPauseButtonMiniPlayer)
        view.addSubview(allMyTracksViews.sliderOnMiniPlayer)
        
        NSLayoutConstraint.activate([
            
            allMyTracksViews.miniPlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            allMyTracksViews.miniPlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            allMyTracksViews.miniPlayer.heightAnchor.constraint(equalToConstant: 40),
            allMyTracksViews.miniPlayer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            allMyTracksViews.likeButtonMiniPlayer.leadingAnchor.constraint(equalTo: allMyTracksViews.miniPlayer.leadingAnchor, constant: 10),
            allMyTracksViews.likeButtonMiniPlayer.topAnchor.constraint(equalTo: allMyTracksViews.miniPlayer.topAnchor, constant: 10),
            allMyTracksViews.likeButtonMiniPlayer.centerYAnchor.constraint(equalTo: allMyTracksViews.miniPlayer.centerYAnchor),
            
            allMyTracksViews.songName.leadingAnchor.constraint(equalTo: allMyTracksViews.likeButtonMiniPlayer.trailingAnchor, constant: 10),
            allMyTracksViews.songName.topAnchor.constraint(equalTo: allMyTracksViews.miniPlayer.topAnchor, constant: 5),
            allMyTracksViews.songAuthor.leadingAnchor.constraint(equalTo: allMyTracksViews.likeButtonMiniPlayer.trailingAnchor, constant: 10),
            allMyTracksViews.songAuthor.bottomAnchor.constraint(equalTo: allMyTracksViews.likeButtonMiniPlayer.bottomAnchor, constant: 5),
            
            allMyTracksViews.playPauseButtonMiniPlayer.trailingAnchor.constraint(equalTo: allMyTracksViews.miniPlayer.trailingAnchor, constant: -10),
            allMyTracksViews.playPauseButtonMiniPlayer.centerYAnchor.constraint(equalTo: allMyTracksViews.miniPlayer.centerYAnchor),
            
            allMyTracksViews.changeSourcePlayingMiniPlayer.trailingAnchor.constraint(equalTo: allMyTracksViews.playPauseButtonMiniPlayer.leadingAnchor, constant: -20),
            allMyTracksViews.changeSourcePlayingMiniPlayer.centerYAnchor.constraint(equalTo: allMyTracksViews.miniPlayer.centerYAnchor),
            
            allMyTracksViews.sliderOnMiniPlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -2),
            allMyTracksViews.sliderOnMiniPlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 2),
            allMyTracksViews.sliderOnMiniPlayer.bottomAnchor.constraint(equalTo: allMyTracksViews.miniPlayer.topAnchor, constant: 0)
        ])
    }
    
    //MARK: - Targets for Buttons
    private func targets() {
        let miniPlayerTapGesture = UITapGestureRecognizer(target: self, action: #selector(miniPlayerPressed))
        allMyTracksViews.miniPlayer.addGestureRecognizer(miniPlayerTapGesture)
        
        allMyTracksViews.playPauseButtonMiniPlayer.addTarget(self, action: #selector(playOrPauseButtonPressed), for: .touchUpInside)
    }
    
    @objc private func miniPlayerPressed() {
        let playerVC = PlayerVC()
        playerVC.playerViews.sliderOnMiniPlayer.value = Float(AudioPlayer.shared.currentTime)
        playerVC.modalPresentationStyle = .fullScreen
        present(playerVC, animated: true)
    }
    
    @objc private func playOrPauseButtonPressed() {
        if AudioPlayer.shared.player?.isPlaying == true {
            AudioPlayer.shared.player?.pause()
            allMyTracksViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        } else {
            AudioPlayer.shared.player?.play()
            allMyTracksViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        }
    }
    
   @objc private func updateTime() {
        allMyTracksViews.sliderOnMiniPlayer.value = Float(AudioPlayer.shared.currentTime)
        UserDefaults.standard.set(allMyTracksViews.sliderOnMiniPlayer.value, forKey: "valueSlider")
    }
    
//    private func isPlaying() {
//        if AudioPlayer.shared.player.isPlaying {
//            allMyTracksViews.miniPlayer.isHidden = false
//            allMyTracksViews.likeButtonMiniPlayer.isHidden = false
//            allMyTracksViews.songName.isHidden = false
//            allMyTracksViews.songAuthor.isHidden = false
//            allMyTracksViews.changeSourcePlayingMiniPlayer.isHidden = false
//            allMyTracksViews.playPauseButtonMiniPlayer.isHidden = false
//            allMyTracksViews.sliderOnMiniPlayer.isHidden = false
//        }
//    }
}

extension Notification.Name {
    public static let sliderCurrentValue = Notification.Name(rawValue: "sliderCurrentValue")
    public static let miniPlayerSongAuthor = Notification.Name(rawValue: "miniPlayerSongAuthor")
    public static let miniPlayerSongName = Notification.Name(rawValue: "miniPlayerSongName")
}


