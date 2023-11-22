//
//  MainChildVC.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 30.10.2023.
//

import UIKit
import youtube_ios_player_helper

final class MainChildVC: UIViewController {
    
    let mainChildViews = MainChildViews()
    var panGestureRecognizer : UIPanGestureRecognizer! // жест для закрытия vc после свайпа вниз, когда скролл достиг верха экрана
    private var isTrackingPanLocation = false
    
    var oldContentOffset = CGPoint.zero
    let topConstraintRange = (CGFloat(0)..<CGFloat(140))
    
    private var videoIDs = [
        "XXYlFuWEuKI", "kkXXrRxmAyw", "S-ViSgHV864", "3dm_5qWWDV8"
    ]
    
    override func loadView() {
        super.loadView()
        view = mainChildViews
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.alpha = 1
        view.backgroundColor = .clear //проблема не прозрачного таб бара здесь - потому что черный цвет, с clear работает ок, но тогда видно контроллер, котороый под ним
        //mainChildViews.tableView.bounces = true
        //panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.panRecognized))
//        panGestureRecognizer.delegate = self
  //      mainChildViews.tableView.addGestureRecognizer(panGestureRecognizer)
        

        _ = Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(updateCellData), userInfo: nil, repeats: true)
        
        mainChildViews.tableView.delegate = self
        mainChildViews.tableView.dataSource = self
                
        tabBarController?.tabBar.isTranslucent = true
        tabBarController?.tabBar.backgroundImage = UIImage()
        tabBarController?.tabBar.shadowImage = UIImage()
        tabBarController?.tabBar.backgroundColor = UIColor.clear
        tabBarController?.tabBar.barTintColor = UIColor.clear
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.isUserInteractionEnabled = true
        //view.alpha = 1
        
        if UserDefaults.standard.string(forKey: "songName") == nil && UserDefaults.standard.string(forKey: "songAuthor") == nil {
            mainChildViews.miniPlayer.isHidden = true
            mainChildViews.sliderOnMiniPlayer.isHidden = true
            mainChildViews.songName.isHidden = true
            mainChildViews.songAuthor.isHidden = true
            mainChildViews.likeButtonMiniPlayer.isHidden = true
            mainChildViews.changeSourcePlayingMiniPlayer.isHidden = true
            mainChildViews.playPauseButtonMiniPlayer.isHidden = true
        } else {
            mainChildViews.miniPlayer.isHidden = false
            mainChildViews.sliderOnMiniPlayer.isHidden = false
            mainChildViews.songName.isHidden = false
            mainChildViews.songAuthor.isHidden = false
            mainChildViews.likeButtonMiniPlayer.isHidden = false
            mainChildViews.changeSourcePlayingMiniPlayer.isHidden = false
            mainChildViews.playPauseButtonMiniPlayer.isHidden = false
        }
        
        if AudioPlayer.shared.player?.isPlaying == true {
            mainChildViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)), for: .normal)
        } else {
            mainChildViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)), for: .normal)
        }
        
        mainChildViews.songName.text = UserDefaults.standard.string(forKey: "songName")
        mainChildViews.songAuthor.text = UserDefaults.standard.string(forKey: "songAuthor")
        mainChildViews.sliderOnMiniPlayer.maximumValue = UserDefaults.standard.float(forKey: "maximumValue")
        mainChildViews.sliderOnMiniPlayer.value = UserDefaults.standard.float(forKey: "valueSlider")
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.alpha = 1.0
        
    }
    
    @objc private func updateTime() {
        mainChildViews.sliderOnMiniPlayer.value = UserDefaults.standard.float(forKey: "valueSlider")
        UserDefaults.standard.set(mainChildViews.sliderOnMiniPlayer.value, forKey: "valueSlider")
    }
    
//    @objc private func panRecognized(recognizer: UIPanGestureRecognizer) {
//        if recognizer.state == .began && mainChildViews.tableView.contentOffset.y == 0 {
//            //ничего не делаем
//            recognizer.setTranslation(.zero, in: mainChildViews.tableView)
//            isTrackingPanLocation = true
//        } else if recognizer.state != .ended && recognizer.state != .cancelled && recognizer.state != .failed && isTrackingPanLocation {
//            let panOffset = recognizer.translation(in: mainChildViews.tableView)
//            let eligiblePanOffset = panOffset.y > 100
//            if eligiblePanOffset {
//                recognizer.isEnabled = false
//                recognizer.isEnabled = true
//                view.alpha = 0.5
//                self.willMove(toParent: nil)
//                self.beginAppearanceTransition(false, animated: true)
//                UIView.animate(withDuration: 0.3, animations: {
//                    self.view.alpha = 0.5
//                }, completion: { _ in
//                    guard let navigationController = self.navigationController else {
//                        return
//                    }
//                    self.view.removeFromSuperview()
//                    self.endAppearanceTransition()
//                    self.removeFromParent()
//                })
//                self.dismiss(animated: true, completion: nil)
//            }
//            
//            if panOffset.y < 0 {
//                isTrackingPanLocation = false
//            }
//        } else {
//            isTrackingPanLocation = false
//        }
//    }
    
    @objc private func updateCellData() {
        if let previousCell = mainChildViews.tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? ClipsTableViewCell {
            previousCell.playerView.stopVideo()
        }
        videoIDs[0] = videoIDs.randomElement()!
        mainChildViews.tableView.reloadSections(IndexSet(integer: 4), with: .left)
    }
    
}

extension MainChildVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = CollectForYouCell(style: .default, reuseIdentifier: CollectForYouCell.cellID)
            return cell
        case 1:
            let cell = YourFavouriteTableViewCell(style: .default, reuseIdentifier: YourFavouriteTableViewCell.cellID)
            return cell
        case 2:
            let cell = ListenedRecentlyTableViewCell(style: .default, reuseIdentifier: ListenedRecentlyTableViewCell.cellID)
            return cell
        case 3:
            let cell = InterestingNowTableViewCell(style: .default, reuseIdentifier: InterestingNowTableViewCell.cellID)
            return cell
        case 4:
            let cell = ClipsTableViewCell(style: .default, reuseIdentifier: ClipsTableViewCell.cellID)
            
            cell.playerView.load(withVideoId: videoIDs[0], playerVars: [
                "playsinline": 1,
                "mute": 1,
                "controls": 1,
                "allowFullscreen": 1,
                "autohide": 1,
                "showinfo": 0,
                "modestbranding": 1,
                "rel": 0,
                "loop": 1
            ])
            cell.playerView.delegate = self
            return cell
            
        case 5:
            let cell = NewReleasesTableViewCell(style: .default, reuseIdentifier: NewReleasesTableViewCell.cellID)
            return cell
            
        case 6:
            let cell = PopularPlaylistsTableViewCell(style: .default, reuseIdentifier: PopularPlaylistsTableViewCell.cellID)
            return cell
            
        case 7:
            let cell = ChartTableViewCell(style: .default, reuseIdentifier: ChartTableViewCell.cellID)
            return cell
            
        case 8:
            let cell = NeuroMusicTableViewCell(style: .default, reuseIdentifier: NeuroMusicTableViewCell.cellID)
            return cell
            
        case 9:
            let cell = SelectionsTableViewCell(style: .default, reuseIdentifier: SelectionsTableViewCell.cellID)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 300
        case 1:
            return 150
        case 2:
            return 300
        case 3:
            return 450
        case 4:
            return 250
        case 5:
            return 370
        case 6:
            return 350
        case 7:
            return 400
        case 8:
            return 180
        case 9:
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
            let numberOfColumns: CGFloat = 2
            let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Установите свои значения отступов
            
            let interItemSpacing = CGFloat(10) // Установите свои значения интервалов между ячейками
            
            let collectionViewWidth = tableView.frame.width - sectionInsets.left - sectionInsets.right
            let itemWidth = floor((collectionViewWidth + interItemSpacing) / numberOfColumns) - interItemSpacing
            
            let numberOfRows = ceil(CGFloat(11) / numberOfColumns)
            
            let totalHeight = (itemWidth * numberOfRows) + ((numberOfRows - 1) * interItemSpacing) + sectionInsets.top + sectionInsets.bottom
            
            return totalHeight
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            print("section 0")
        case 1:
            let allMyTracksVC = AllMyTracksVC()
//            allMyTracksVC.modalPresentationStyle = .overCurrentContext
//            present(allMyTracksVC, animated: true)
            navigationController?.isNavigationBarHidden = false
            navigationController?.pushViewController(allMyTracksVC, animated: true)
        default:
            break
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //mainChildViews.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        
        if scrollView.contentOffset.y < 0 {
            print(scrollView.contentOffset.y)
            self.dismiss(animated: true)
        }
    }
}

extension MainChildVC: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}
