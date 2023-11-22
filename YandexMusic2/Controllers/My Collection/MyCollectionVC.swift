//
//  MyCollectionVC.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 13.10.2023.
//

import UIKit

class MyCollectionVC: UIViewController {
    
    private let myCollectionViews = MyCollectionViews()
    private let mainVC = MainVC()
    private var isPlayButtonPressed: Bool {
        if AudioPlayer.shared.player?.isPlaying == true {
            return true
        } else {
            return false
        }
    }
    
    override func loadView() {
        super.loadView()
        view = myCollectionViews
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(miniPlayerPressed))

        myCollectionViews.miniPlayer.addGestureRecognizer(tap)
        myCollectionViews.tableView.delegate = self
        myCollectionViews.tableView.dataSource = self
        myCollectionViews.sliderOnMiniPlayer.maximumValue = Float(AudioPlayer.shared.duration)
        myCollectionViews.myWaveCollectionButton.addTarget(self, action: #selector(myWaveCollectionPressed), for: .touchUpInside)
        myCollectionViews.playPauseButtonMiniPlayer.addTarget(self, action: #selector(playPausePressed), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.string(forKey: "songName") == nil && UserDefaults.standard.string(forKey: "songAuthor") == nil {
            myCollectionViews.miniPlayer.isHidden = true
            myCollectionViews.sliderOnMiniPlayer.isHidden = true
            myCollectionViews.songName.isHidden = true
            myCollectionViews.songAuthor.isHidden = true
            myCollectionViews.likeButtonMiniPlayer.isHidden = true
            myCollectionViews.changeSourcePlayingMiniPlayer.isHidden = true
            myCollectionViews.playPauseButtonMiniPlayer.isHidden = true
        } else {
            myCollectionViews.miniPlayer.isHidden = false
            myCollectionViews.sliderOnMiniPlayer.isHidden = false
            myCollectionViews.songName.isHidden = false
            myCollectionViews.songAuthor.isHidden = false
            myCollectionViews.likeButtonMiniPlayer.isHidden = false
            myCollectionViews.changeSourcePlayingMiniPlayer.isHidden = false
            myCollectionViews.playPauseButtonMiniPlayer.isHidden = false
        }
        
        myCollectionViews.songName.text = UserDefaults.standard.string(forKey: "songName")
        myCollectionViews.songAuthor.text = UserDefaults.standard.string(forKey: "songAuthor")
        myCollectionViews.sliderOnMiniPlayer.maximumValue = UserDefaults.standard.float(forKey: "maximumValue")
        myCollectionViews.sliderOnMiniPlayer.value = UserDefaults.standard.float(forKey: "valueSlider")
        
        if AudioPlayer.shared.player?.isPlaying == true {
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
            myCollectionViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        } else {
            myCollectionViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        }
        
        view.layoutSubviews()
    }
    
    @objc private func updateTime() {
        myCollectionViews.sliderOnMiniPlayer.value = Float(AudioPlayer.shared.player?.currentTime ?? 0)
        if AudioPlayer.shared.player?.isPlaying == true {
            myCollectionViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        } else {
            myCollectionViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        }
    }
    
    @objc private func playPausePressed() {
        
        //isPlayButtonPressed.toggle()
        
        if AudioPlayer.shared.player?.isPlaying == true {
            myCollectionViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
            AudioPlayer.shared.player?.pause()
        } else {
    
            let getNeededTrack = SongModel.getSongs().filter { $0.songAuthor == myCollectionViews.songAuthor.text && $0.songName == myCollectionViews.songName.text }.first
            let currentSliderValue = UserDefaults.standard.float(forKey: "valueSlider")
            print(currentSliderValue)
            AudioPlayer.shared.currentTrack = getNeededTrack
            AudioPlayer.shared.play(song: getNeededTrack!)
            AudioPlayer.shared.player?.currentTime = TimeInterval(myCollectionViews.sliderOnMiniPlayer.value)
            //mainViews.sliderOnMiniPlayer.value = UserDefaults.standard.float(forKey: "valueSlider")
            myCollectionViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            AudioPlayer.shared.player?.play()
        }
    }
    
    @objc private func myWaveCollectionPressed() {
        print("my wave collection pressed")
    }
    
    @objc private func miniPlayerPressed() {
        let playerVC = PlayerVC()
        playerVC.modalPresentationStyle = .fullScreen
        present(playerVC, animated: true)
    }
    
    @objc private func searchButtonPressed() {
        print("search pressed")
    }
    
    @objc private func profileButtonPressed() {
        print("profile pressed")
    }
    
    @objc private func settingsPressed() {
        print("settings pressed")
    }

}

extension MyCollectionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 8
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = ILikeCell(style: .default, reuseIdentifier: ILikeCell.cellID)
            cell.titleLabel.text = LabelTitles.allCases.first!.rawValue
            cell.numberOfTrackLabel.text = "\(SongModel.getSongs().count) треков"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyCollectionTableViewCell.cellID, for: indexPath) as! MyCollectionTableViewCell
            cell.titleLabel.text = LabelTitles.allCases[indexPath.row + 1].rawValue
            cell.picturesForRows.image = UIImage(systemName: ImagesForRows.allCases[indexPath.row].rawValue)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 90
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let allMyTracksVC = AllMyTracksVC()
            allMyTracksVC.modalPresentationStyle = .overCurrentContext
            navigationController?.pushViewController(allMyTracksVC, animated: true)
        default:
            break
        }
    }
}
