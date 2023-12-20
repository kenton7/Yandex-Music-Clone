//
//  MainVC.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 13.10.2023.
//

import UIKit
import Lottie
import AVFoundation
import MediaPlayer
import NotificationCenter


enum ChildVCState {
    case large
    case mini
}

class MainVC: UIViewController {
    
    let navigationBarAppearance = UINavigationBarAppearance()
    private var panGestureEnabled = true

    let mainViews = MainViews()
    private let mainChildVC = MainChildVC()
    private var isMyWavePlaying: Bool {
        if AudioPlayer.shared.player?.isPlaying == true {
            return true
        } else {
            return false
        }
    }
    private var isSongPlaying: Bool {
        if AudioPlayer.shared.player?.isPlaying == true {
            return true
        } else {
            return false
        }
    }
    private var isScrolledAndPlayed = false
    private var animationView: LottieAnimationView?
    //var audioPlayer = AudioPlayer()
    var selectedSong: SongModel?
    
    var songs = SongModel.getSongs()
    
    //-------------
    var mainChild: MainChildVC!
    private var playerVC: PlayerVC?
    var audioPlayer: AVAudioPlayer?
    var visualEfectView: UIVisualEffectView!
    lazy var mainChildHeight: CGFloat = view.frame.size.height - 50
    let mainChildHanldeAreaHeight = 80
    
    var mainChildVisible = false
    var nextState: ChildVCState {
        return mainChildVisible ? .mini : .large
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted: CGFloat = 0
    
    private var childViewHeight = NSLayoutConstraint()
    private var childViewBottom = NSLayoutConstraint()
    
    private var mainChildViewBottomAnchor = NSLayoutConstraint()
    private var childHeight = NSLayoutConstraint()
    
    var tapGestureRecognizer: UITapGestureRecognizer!
    var panGestureRecognizer: UIPanGestureRecognizer!
    
    private var selectedTrackIndex: Int?
    
    var childInitialState: ChildVCState = .mini
        var childInitialFrame: CGRect = .zero
        
    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Logo")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override func loadView() {
        super.loadView()
        mainViews.frame = view.bounds
        view = mainViews
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.backgroundColor = .black
        self.definesPresentationContext = true
        //navigationItem.title = "Яндекс Музыка"
        self.navigationItem.titleView = logoImage
        //navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "YandexSansText-Medium", size: 18)!]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle.fill"), style: .done, target: self, action: #selector(profileButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(searchButtonPressed))
        navigationItem.rightBarButtonItem?.tintColor = .white

        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        tabBarController?.tabBar.isTranslucent = true
        
        setupChild()
        mainViews.miniPlayerCollectionView.delegate = self
        mainViews.miniPlayerCollectionView.dataSource = self
        mainViews.forYouButtonInNavigationBar.addTarget(self, action: #selector(forYouInNavigationBarPressed), for: .touchUpInside)
        mainViews.trandsButtonInNavigationBar.addTarget(self, action: #selector(trendsInNavigationBarPressed), for: .touchUpInside)
        
        //TODO: - При первой загрузке нет плеера и после return код не выполняется
        
        
        
        guard let getNeededTrack = SongModel.getSongs().filter({ $0.songAuthor == mainViews.songAuthor.text && $0.songName == mainViews.songName.text }).first else {
            AudioPlayer.shared.currentTrack = SongModel.getSongs().randomElement()
            return
        }
        //---- здесь код перестает выполняться
        AudioPlayer.shared.currentTrack = getNeededTrack
        
        AudioPlayer.shared.setTrack(track: getNeededTrack)
        
        mainViews.myWaveButton.addTarget(self, action: #selector(myWavePressed), for: .touchUpInside)

        
//        if AudioPlayer.shared.player?.isPlaying == true {
//            mainViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)), for: .normal)
//        } else {
//            mainViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)), for: .normal)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let cell = mainViews.miniPlayerCollectionView.cellForItem(at: IndexPath(item: UserDefaults.standard.integer(forKey: "trackIndex"), section: 0)) as? MiniPlayerCollectionViewCell
        
        //cell?.songName.text = UserDefaults.standard.string(forKey: "songName")
        cell?.songName.text = AudioPlayer.shared.currentTrack?.songName
        cell?.songAuthor.text = AudioPlayer.shared.currentTrack?.songAuthor
        //cell?.songAuthor.text = UserDefaults.standard.string(forKey: "songAuthor")
        cell?.sliderOnMiniPlayer.value = Float(AudioPlayer.shared.currentTime)
        cell?.sliderOnMiniPlayer.maximumValue = Float(AudioPlayer.shared.player?.duration ?? 0)
        
        if AudioPlayer.shared.player?.isPlaying == true {
            print("playing")
            cell?.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        } else {
            print("not playing")
            cell?.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        }
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func forYouInNavigationBarPressed() {
        
        mainViews.forYouButtonInNavigationBar.layer.backgroundColor = UIColor.darkGray.cgColor
        mainViews.forYouButtonInNavigationBar.layer.cornerRadius = 17
        mainViews.trandsButtonInNavigationBar.layer.backgroundColor = UIColor.clear.cgColor
        mainViews.trandsButtonInNavigationBar.layer.cornerRadius = 17
        print("Для вас")

    }
    
    @objc func trendsInNavigationBarPressed() {
        print("Тренды")
        mainViews.forYouButtonInNavigationBar.layer.backgroundColor = UIColor.clear.cgColor
        mainViews.forYouButtonInNavigationBar.layer.cornerRadius = 17
        
        mainViews.trandsButtonInNavigationBar.layer.backgroundColor = UIColor.darkGray.cgColor
        mainViews.trandsButtonInNavigationBar.layer.cornerRadius = 17
    }

    private func setupChild() {
        visualEfectView = UIVisualEffectView()
        visualEfectView.frame = view.frame
        view.insertSubview(visualEfectView, at: 2)
        
        mainChild = MainChildVC()
        addChild(mainChild)
        view.insertSubview(mainChild.view, at: 3)
        mainChild.didMove(toParent: self)
        //mainChild.view.frame = CGRect(x: 0, y: view.frame.height - view.frame.height * 0.3, width: view.frame.width, height: view.bounds.height * 0.3)
        mainChild.view.frame = CGRect(x: 0, y: Int(self.view.bounds.height - self.view.bounds.height * 0.4), width: Int(self.view.frame.size.width), height: Int(self.view.bounds.height * 0.4))
        mainChild.view.clipsToBounds = true
        mainChild.mainChildViews.childCollectionView.contentOffset.y = 0
        
        //tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainVC.handleMainChildTap(recognizer:)))
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(MainVC.handleMainChildPan(recognizer:)))
        //panGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
//    @objc private func handleMainChildTap(recognizer: UITapGestureRecognizer) {
//        switch recognizer.state {
//        case .ended:
//            let location = recognizer.location(in: self.view)
//            if mainChild.view.frame.contains(location) {
//               // animateTransitionIfNeeded(state: nextState, duration: 0.9)
//                returnChildToInitialState()
//            }
//            //animateTransitionIfNeeded(state: nextState, duration: 0.9)
//        default:
//            break
//        }
//    }
    
    @objc private func handleMainChildPan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            //start animation
            startInteractiveTransition(state: nextState, duration: 0.9)
            print("began")
        case .changed:
            //update transition
            //let translation = recognizer.translation(in: mainChild.mainChildViews.handleArea)
            let translation = recognizer.translation(in: self.view)
            var fractionComplete = translation.y / self.mainChild.view.bounds.height //* 0.3
            fractionComplete = mainChildVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            //continue transition
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    
    func animateTransitionIfNeeded(state: ChildVCState, duration: TimeInterval) {
        
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .large:
                   // self.mainChild.view.frame = self.view.bounds
//                    self.mainChild.mainChildViews.childCollectionView.cellForItem(at: IndexPath(item: 0, section: 0))?.isHidden = true
//                    self.mainChild.mainChildViews.childCollectionView.cellForItem(at: IndexPath(item: 1, section: 0))?.isHidden = true
                    self.mainChild.view.frame = CGRect(x: 0, y: 0, width: Int(self.view.frame.size.width), height: Int(self.view.bounds.size.height))

                    self.navigationItem.titleView = self.mainViews.stackViewForNavigationBarButtons
                    self.navigationController?.navigationBar.barTintColor = .black
                    self.navigationController?.navigationBar.backgroundColor = .clear
                    self.navigationController?.navigationBar.isTranslucent = false
                    self.mainChild.mainChildViews.childCollectionView.contentOffset.y = 90
                    self.view.layoutIfNeeded()
                case .mini:
//                    self.mainChild.mainChildViews.childCollectionView.cellForItem(at: IndexPath(item: 0, section: 0))?.isHidden = false
//                    self.mainChild.mainChildViews.childCollectionView.cellForItem(at: IndexPath(item: 1, section: 0))?.isHidden = false
//                    self.mainChild.view.frame = CGRect(x: 0, y: Int(self.view.bounds.maxY - self.view.bounds.height * 0.25), width: Int(self.view.frame.size.width), height: Int(self.view.bounds.height * 0.25))
                    self.mainChild.view.frame = CGRect(x: 0, y: Int(self.view.frame.maxY - self.view.frame.height * 0.3), width: Int(self.view.bounds.width), height: Int(self.view.bounds.size.height * 0.3))
                    self.view.layoutIfNeeded()
                    self.mainChild.mainChildViews.childCollectionView.contentOffset.y = 0
//                    self.navigationBarAppearance.configureWithOpaqueBackground()
//                    self.navigationBarAppearance.backgroundColor = .clear
                    self.navigationController?.navigationBar.barTintColor = .clear
                    self.navigationController?.navigationBar.backgroundColor = .clear
                    self.navigationController?.navigationBar.isTranslucent = true
                    self.navigationItem.titleView = self.logoImage
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.mainChildVisible = (state == .large)
                self.runningAnimations.removeAll()
            }
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .large:
                    self.mainChild.view.alpha = 1
                    self.mainChild.view.backgroundColor = .black
                    self.mainChild.view.isUserInteractionEnabled = true
                    self.mainChild.mainChildViews.tableView.isUserInteractionEnabled = true
                    self.mainChild.mainChildViews.childCollectionView.cellForItem(at: IndexPath(item: 0, section: 2))?.alpha = 1.0
                    self.mainChild.mainChildViews.childCollectionView.cellForItem(at: IndexPath(item: 0, section: 1))?.alpha = 1.0
                case .mini:
                    let cell = self.mainChild.mainChildViews.childCollectionView.cellForItem(at: IndexPath(item: 0, section: 1))
                    cell?.alpha = 0.5
                    self.mainChild.mainChildViews.childCollectionView.cellForItem(at: IndexPath(item: 0, section: 2))?.alpha = 0.5
                    self.mainChild.view.backgroundColor = .clear
                    self.mainChild.view.layer.cornerRadius = 0
                    self.mainChild.mainChildViews.tableView.isUserInteractionEnabled = false
                }
            }
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .large:
                    self.visualEfectView.effect = UIBlurEffect(style: .dark)
                    self.visualEfectView.frame = self.view.bounds
                case .mini:
                    self.visualEfectView.effect = nil
                    self.mainChild.mainChildViews.childCollectionView.backgroundColor = .clear
                }
            }
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
        }
    }
    
    private func startInteractiveTransition(state: ChildVCState, duration: TimeInterval) {
                
        if runningAnimations.isEmpty {
            // run animation
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation() //причина краша тут
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    private func updateInteractiveTransition(fractionCompleted: CGFloat) {
                
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    private func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
    @objc private func playButtonPressed() {
        
        guard let selectedIndexPath = selectedTrackIndex else { return }
        isScrolledAndPlayed.toggle()
        
        let cell = mainViews.miniPlayerCollectionView.cellForItem(at: IndexPath(item: selectedIndexPath, section: 0)) as? MiniPlayerCollectionViewCell
        
        if AudioPlayer.shared.player!.isPlaying {
            cell?.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
            AudioPlayer.shared.player?.pause()
        } else {
            cell?.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            AudioPlayer.shared.player?.play()
        }
    }
    
    
    @objc private func myWavePressed() {
        //isMyWavePlaying.toggle()
        
        UserDefaults.standard.set(0.0, forKey: "valueSlider")
        
        selectedSong = songs[Int.random(in: 0..<songs.count)]
        if isMyWavePlaying {
            mainViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
            mainViews.myWaveButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
            mainViews.waveAnimationView.animationSpeed = 1.5
            mainViews.songAuthor.text = selectedSong?.songAuthor
            mainViews.songName.text = selectedSong?.songName
            AudioPlayer.shared.play(song: selectedSong!)
            AudioPlayer.shared.currentTrack = selectedSong
            AudioPlayer.shared.currentTrack?.albumImage = selectedSong!.albumImage
            mainViews.sliderOnMiniPlayer.maximumValue = Float(AudioPlayer.shared.duration)
            
//            mainViews.miniPlayer.isHidden = false
//            mainViews.sliderOnMiniPlayer.isHidden = false
//            mainViews.songName.isHidden = false
//            mainViews.songAuthor.isHidden = false
//            mainViews.likeButtonMiniPlayer.isHidden = false
//            mainViews.changeSourcePlayingMiniPlayer.isHidden = false
//            mainViews.playPauseButtonMiniPlayer.isHidden = false
            
            UserDefaults.standard.set(MiniPlayerView.shared.sliderOnMiniPlayer.maximumValue, forKey: "maximumValue")
            UserDefaults.standard.set(selectedSong?.songAuthor, forKey: "songAuthor")
            UserDefaults.standard.set(selectedSong?.songName, forKey: "songName")
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        } else {
            //isSongPlaying.toggle()
            mainViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
            mainViews.myWaveButton.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .bold, scale: .large)), for: .normal)
            mainViews.waveAnimationView.animationSpeed = 0.5
            //audioPlayer.pause(song: selectedSong!)
            audioPlayer?.pause()
        }
    }
    
    @objc func updateTime() {
        //mainViews.sliderOnMiniPlayer.value = UserDefaults.standard.float(forKey: "valueSlider")
        guard let selectedIndexPath = selectedTrackIndex else { return }
        let cell = mainViews.miniPlayerCollectionView.cellForItem(at: IndexPath(item: selectedIndexPath, section: 0)) as? MiniPlayerCollectionViewCell
        
        if AudioPlayer.shared.player?.isPlaying == true {
            cell?.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        } else {
            cell?.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        }
        
        cell?.songName.text = AudioPlayer.shared.currentTrack?.songName
        cell?.songAuthor.text = AudioPlayer.shared.currentTrack?.songAuthor
        cell?.trackImage.image = AudioPlayer.shared.currentTrack?.albumImage
        cell?.sliderOnMiniPlayer.value = Float(AudioPlayer.shared.currentTime)
        //mainViews.sliderOnMiniPlayer.value = Float(AudioPlayer.shared.currentTime)
        UserDefaults.standard.set(AudioPlayer.shared.currentTime, forKey: "valueSlider")        
    }
    
    @objc private func searchButtonPressed() {
        print("pressed")
    }
    
    @objc private func profileButtonPressed() {
        print("pressed")
    }
    
    func returnChildToInitialState() {
        mainChildVisible = false // .mini - это исходное состояние
        animateTransitionIfNeeded(state: .mini, duration: 0.9)
    }
}



////MARK: - UIGestureRecognizerDelegate
//extension MainVC: UIGestureRecognizerDelegate {
//    // Отменяем жесты, если точка касания находится в пределах дочернего контроллера
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        let touchLocation = touch.location(in: self.view)
//
//        // Проверяем, не находится ли касание на дочернем контроллере
//        let isTouchOnChildViewController = mainChild.view.frame.contains(touchLocation)
//
//        // Получаем смещение по вертикали
//        let contentOffsetY = mainChild.mainChildViews.childCollectionView.contentOffset.y
//        print("offset=\(contentOffsetY)")
//
////        if isTouchOnChildViewController && contentOffsetY >= -97 {
////            // Если касание на дочернем контроллере и скролл не достиг верхней границы, разрешаем жесты
////            return false
////        }
//
//        // Если дочерний контроллер находится в large и скролл достиг верхней границы, вызываем метод возврата в исходное состояние
////        if mainChildVisible && contentOffsetY < 0 /*-97.66666666666667 */{
////            print(contentOffsetY)
////            print("CLOSE!")
////            returnChildToInitialState()
////        }
//
//        // Возвращаем true, если касание не на дочернем контроллере или разрешаем жесты, если нет
//        return true
//    }
//
//}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        let player = PlayerVC()
        
        if let currentTrack = AudioPlayer.shared.currentTrack {
            player.currentTrack = currentTrack
        }
        player.modalPresentationStyle = .overFullScreen
        present(player, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let cell = mainViews.miniPlayerCollectionView.cellForItem(at: IndexPath(item: selectedTrackIndex ?? 0, section: 0)) as? MiniPlayerCollectionViewCell
        
        if isScrolledAndPlayed == true {
            AudioPlayer.shared.player?.play()
            cell?.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        }
    }
}

