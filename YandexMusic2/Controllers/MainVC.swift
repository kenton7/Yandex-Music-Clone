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
    //weak var delegate: MiniPlayerDelegate?
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
    
    lazy var handleArea: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = mainViews
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.definesPresentationContext = true
        navigationItem.title = "Яндекс Музыка"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "YandexSansText-Medium", size: 18)!]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle.fill"), style: .done, target: self, action: #selector(profileButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(searchButtonPressed))
        
        guard let getNeededTrack = SongModel.getSongs().filter({ $0.songAuthor == mainViews.songAuthor.text && $0.songName == mainViews.songName.text }).first else { return }
        
        AudioPlayer.shared.setTrack(track: getNeededTrack)
        audioPlayer = AudioPlayer.shared.player
        
        mainViews.myWaveButton.addTarget(self, action: #selector(myWavePressed), for: .touchUpInside)
        
        
        let tapOnMiniPlayerGesture = UITapGestureRecognizer(target: self, action: #selector(miniPlayerPressed))
        
        mainViews.miniPlayer.addGestureRecognizer(tapOnMiniPlayerGesture)
        mainViews.playPauseButtonMiniPlayer.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        //addSecondMainChildVC()
//        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(showChildMainVC))
//        swipeUpGesture.direction = .up
//        view.addGestureRecognizer(swipeUpGesture)
        
        if AudioPlayer.shared.player?.isPlaying == true {
            mainViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)), for: .normal)
        } else {
            mainViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)), for: .normal)
        }
        
        setupChild()
        
        view.insertSubview(handleArea, at: 1)
    }
    
    private func setupChild() {
        visualEfectView = UIVisualEffectView()
        visualEfectView.frame = view.frame
        view.addSubview(visualEfectView)
        view.insertSubview(visualEfectView, at: 2)
        
        mainChild = MainChildVC()
        addChild(mainChild)
        //view.addSubview(mainChild.view)
        view.insertSubview(mainChild.view, at: 2)
        mainChild.didMove(toParent: self)
        mainChild.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainChild.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainChild.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            mainChild.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        childViewHeight = mainChild.view.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.35)
        childViewHeight.isActive = true
        mainChild.view.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainVC.handleMainChildTap(recognizer:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(MainVC.handleMainChildPan(recognizer:)))
        
        mainChild.mainChildViews.handleArea.addGestureRecognizer(tapGestureRecognizer)
        mainChild.mainChildViews.handleArea.addGestureRecognizer(panGestureRecognizer)
    }
    
    
    @objc private func handleMainChildTap(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    @objc private func handleMainChildPan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            //start animation
            startInteractiveTransition(state: nextState, duration: 0.9)
            print("here")
        case .changed:
            //update transition
            let translation = recognizer.translation(in: mainChild.mainChildViews.handleArea)
            var fractionComplete = translation.y / self.mainChildHeight
            fractionComplete = mainChildVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            //continue transition
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    private func animateTransitionIfNeeded(state: ChildVCState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                self.childViewHeight.isActive = false
                self.childViewHeight = self.mainChild.view.heightAnchor.constraint(equalTo: self.view.heightAnchor)
                self.childViewHeight.isActive = true
                self.view.layoutIfNeeded()
                switch state {
                case .large:
                    self.mainChild.view.frame.origin.y = 0 //self.view.frame.height - self.view.frame.height + 90 //+ 40 //self.mainChildHeight
                case .mini:
                    self.mainChild.view.frame.origin.y = self.view.frame.height - self.view.frame.height * 0.35
                }
            }
            frameAnimator.addCompletion { _ in
                self.mainChildVisible = !self.mainChildVisible
                self.runningAnimations.removeAll()
            }
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .large:
                    self.mainChild.view.layer.cornerRadius = 12
                    //self.view.alpha = 0
                    self.mainChild.view.alpha = 1
                    self.mainChild.view.isUserInteractionEnabled = true
                    self.mainChild.mainChildViews.tableView.isUserInteractionEnabled = true
                    self.mainChild.mainChildViews.handleArea.backgroundColor = .clear
                    self.mainChildVC.mainChildViews.controlImageOnHandleArea.image = UIImage(systemName: "chevron.compact.down")
//                    self.childViewHeight.isActive = false
//                    self.childViewHeight = self.mainChild.view.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1.0)
//                    self.childViewHeight.isActive = true
//                    let cell = self.mainChild.mainChildViews.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MainChildVCCell
//                    cell.collectForYouLabel.textColor = .white
                    
                case .mini:
                    self.view.alpha = 1
                    self.mainChild.view.layer.cornerRadius = 0
                    self.mainChild.mainChildViews.tableView.isUserInteractionEnabled = false
                    self.mainChild.mainChildViews.handleArea.backgroundColor = .clear
                    //self.mainChildVC.mainChildViews.tableView.scrollsToTop
                }
            }
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
//            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
//                switch state {
//                case .expanded:
//                    self.visualEfectView.effect = UIBlurEffect(style: .dark)
//                    self.visualEfectView.frame = self.view.bounds
//                    self.mainChild.view.isUserInteractionEnabled = true
//                    self.mainChild.mainChildViews.tableView.isUserInteractionEnabled = true
//                    self.view.alpha = 0
//                    self.mainChild.view.alpha = 1
//                case .collapsed:
//                    self.view.alpha = 1
//                    self.visualEfectView.effect = nil
//                }
//            }
//            blurAnimator.startAnimation()
//            runningAnimations.append(blurAnimator)
        }
    }
    
    private func startInteractiveTransition(state: ChildVCState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            // run animation
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.string(forKey: "songName") == nil && UserDefaults.standard.string(forKey: "songAuthor") == nil {
            mainViews.miniPlayer.isHidden = true
            mainViews.sliderOnMiniPlayer.isHidden = true
            mainViews.songName.isHidden = true
            mainViews.songAuthor.isHidden = true
            mainViews.likeButtonMiniPlayer.isHidden = true
            mainViews.changeSourcePlayingMiniPlayer.isHidden = true
            mainViews.playPauseButtonMiniPlayer.isHidden = true
        } else {
            mainViews.miniPlayer.isHidden = false
            mainViews.sliderOnMiniPlayer.isHidden = false
            mainViews.songName.isHidden = false
            mainViews.songAuthor.isHidden = false
            mainViews.likeButtonMiniPlayer.isHidden = false
            mainViews.changeSourcePlayingMiniPlayer.isHidden = false
            mainViews.playPauseButtonMiniPlayer.isHidden = false
        }
        mainViews.songName.text = UserDefaults.standard.string(forKey: "songName")
        mainViews.songAuthor.text = UserDefaults.standard.string(forKey: "songAuthor")
        mainViews.sliderOnMiniPlayer.maximumValue = UserDefaults.standard.float(forKey: "maximumValue")
        //mainViews.sliderOnMiniPlayer.value = UserDefaults.standard.float(forKey: "valueSlider")
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        if AudioPlayer.shared.player?.isPlaying == true {
            print("here")
            mainViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        } else {
            mainViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
        }
    }
    
    @objc private func playButtonPressed() {
        
        //isSongPlaying.toggle()
        
        if audioPlayer?.isPlaying == true {
            mainViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
            audioPlayer?.pause()
        } else {
            let getNeededTrack = SongModel.getSongs().filter { $0.songAuthor == mainViews.songAuthor.text && $0.songName == mainViews.songName.text }.first
            let currentSliderValue = UserDefaults.standard.float(forKey: "valueSlider")
            audioPlayer?.currentTime = TimeInterval(mainViews.sliderOnMiniPlayer.value)
            mainViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            AudioPlayer().setTrack(track: getNeededTrack!)
            AudioPlayer.shared.player?.play()
            //audioPlayer?.play()
        }
        
//        if AudioPlayer.shared.player?.isPlaying == true {
//            mainViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
//            audioPlayer?.pause()
//        } else {
//            let getNeededTrack = SongModel.getSongs().filter { $0.songAuthor == mainViews.songAuthor.text && $0.songName == mainViews.songName.text }.first
//            let currentSliderValue = UserDefaults.standard.float(forKey: "valueSlider")
//            
//            //AudioPlayer.shared.currentTrack = getNeededTrack
//            //AudioPlayer.shared.play(song: getNeededTrack!)
//            AudioPlayer.shared.player?.currentTime = TimeInterval(mainViews.sliderOnMiniPlayer.value)
//            //mainViews.sliderOnMiniPlayer.value = UserDefaults.standard.float(forKey: "valueSlider")
//            mainViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)), for: .normal)
//            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
//            //AudioPlayer.shared.player?.play()
//            audioPlayer?.play()
//        }
    }
    
//    @objc private func miniPlayerPressed() {
////        let playerVC = PlayerVC()
//        let getNeededTrack = SongModel.getSongs().filter { $0.songAuthor == mainViews.songAuthor.text && $0.songName == mainViews.songName.text }.first
////                
////        playerVC.currentTrack = getNeededTrack
////        playerVC.modalPresentationStyle = .overFullScreen
////        present(playerVC, animated: true)
//
//        if let existingPlayerVC = playerVC {
//            existingPlayerVC.updateTrack(getNeededTrack)
//            existingPlayerVC.audioPlayer = self.audioPlayer
//            //existingPlayerVC.currentTrack = getNeededTrack
//            print("old")
//            existingPlayerVC.modalPresentationStyle = .overFullScreen
//            present(existingPlayerVC, animated: true)
//        } else {
//            let newPlayerVC = PlayerVC()
//            newPlayerVC.currentTrack = getNeededTrack
//            newPlayerVC.audioPlayer = self.audioPlayer
//            newPlayerVC.modalPresentationStyle = .overFullScreen
//            present(newPlayerVC, animated: true)
//            playerVC = newPlayerVC
//            print("new")
//        }
//    }
    @objc private func miniPlayerPressed() {
        let getNeededTrack = SongModel.getSongs().filter { $0.songAuthor == mainViews.songAuthor.text && $0.songName == mainViews.songName.text }.first

        if let existingPlayerVC = playerVC {
            existingPlayerVC.updateTrack(getNeededTrack)
            existingPlayerVC.audioPlayer = AudioPlayer.shared.player // Передайте текущий экземпляр AudioPlayer
            existingPlayerVC.currentTrack = getNeededTrack
            existingPlayerVC.modalPresentationStyle = .overFullScreen
            present(existingPlayerVC, animated: true)
        } else {
            let newPlayerVC = PlayerVC()
            newPlayerVC.currentTrack = getNeededTrack
            newPlayerVC.audioPlayer = AudioPlayer.shared.player // Передайте текущий экземпляр AudioPlayer
            newPlayerVC.modalPresentationStyle = .overFullScreen
            present(newPlayerVC, animated: true)
            playerVC = newPlayerVC
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
            
            mainViews.miniPlayer.isHidden = false
            mainViews.sliderOnMiniPlayer.isHidden = false
            mainViews.songName.isHidden = false
            mainViews.songAuthor.isHidden = false
            mainViews.likeButtonMiniPlayer.isHidden = false
            mainViews.changeSourcePlayingMiniPlayer.isHidden = false
            mainViews.playPauseButtonMiniPlayer.isHidden = false
            
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
        mainViews.sliderOnMiniPlayer.value = Float(AudioPlayer.shared.currentTime)
        UserDefaults.standard.set(mainViews.sliderOnMiniPlayer.value, forKey: "valueSlider")
    }
    
    @objc private func searchButtonPressed() {
        print("pressed")
    }
    
    @objc private func profileButtonPressed() {
        print("pressed")
    }
    
    @objc private func showChildMainVC() {
        
        
//        let child = MainChildVC()
//        self.navigationController?.addChild(child)
//        guard let navigationController = navigationController else {
//            return
//        }
//        child.view.frame = navigationController.view.bounds
//        child.beginAppearanceTransition(true, animated: true)
//        self.navigationController?.view.addSubview(child.view)
//        UIView.animate(withDuration: 0.3, animations: {
//            child.view.alpha = 1.0
//        }, completion: { _ in
//            guard let navigationController = self.navigationController else {
//                return
//            }
//            child.endAppearanceTransition()
//            child.didMove(toParent: navigationController)
//        })
        let mainChildVC = MainChildVC()
        mainChildVC.modalPresentationStyle = .overCurrentContext
        present(mainChildVC, animated: true)
    }
    
    
    private func addSecondMainChildVC() {
        addChild(mainChildVC)
        mainChildVC.view.isUserInteractionEnabled = true
        //view.insertSubview(mainChildVC.view, at: 0)
        mainChildVC.didMove(toParent: self)
        //navigationController?.pushViewController(mainChildVC, animated: true)
        
        
        NSLayoutConstraint.activate([
            mainChildVC.view.topAnchor.constraint(equalTo: mainViews.waveAnimationView.bottomAnchor, constant: -80),
            mainChildVC.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainChildVC.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            mainChildVC.view.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1.0)
        ])
    }
}

extension MainChildVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

