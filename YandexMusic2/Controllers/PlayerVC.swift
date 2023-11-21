//
//  PlayerVC.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 13.10.2023.
//

import UIKit
import AVFoundation
import AVKit
import MediaPlayer
import CoreImage

//protocol TrackInfoDelegate: AnyObject {
//    func playTrack(track: Track)
//}

class PlayerVC: UIViewController {
    
    let playerViews = PlayerVIews()
    let mainVC = MainVC()
//    var isPlayPressed: Bool {
//        if AudioPlayer.shared.player?.isPlaying == true {
//            return true
//        } else {
//            return false
//        }
//    }
    var isPlayPressed = false
    private var isRepeatActivated = UserDefaults.standard.bool(forKey: "isRepeatActivated")
    
    var playerCalled: (() -> Void)?
    //var songs: [SongModel] = [] // Массив песен
    var selectedSong: SongModel? // Выбранная песня
    var songs = SongModel.getSongs()
    
    var audioPlayer: AVAudioPlayer?
    var videoShotPlayer: AVPlayer!
    var currentTrack: SongModel?
    var playerController = AVPlayerViewController()
    var animator: UIViewPropertyAnimator?
    
    override func loadView() {
        super.loadView()
        view = playerViews
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeDownHandler))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        
        playerViews.miniPlayer.isHidden = true
        playerViews.sliderOnMiniPlayer.isHidden = true
        playerViews.changeSourcePlayingMiniPlayer.isHidden = true
        playerViews.songName.isHidden = true
        playerViews.songAuthor.isHidden = true
        playerViews.likeButtonMiniPlayer.isHidden = true
        playerViews.playPauseButtonMiniPlayer.isHidden = true
        
        let getNeededTrack = SongModel.getSongs().filter { $0.songAuthor == playerViews.songAuthor.text && $0.songName == playerViews.songName.text }.first
        
        AudioPlayer.shared.setTrack(track: AudioPlayer.shared.currentTrack!)
        print(audioPlayer?.isPlaying)
        //audioPlayer = AudioPlayer.shared.player
//        guard let player = AudioPlayer.shared.player else {
//                print("Player is not set")
//                return
//            }
        
        
        view.backgroundColor = dominantColor(for: getNeededTrack?.albumImage ?? SongModel.getSongs().randomElement()!.albumImage)
        playerViews.songNameLabel.text = AudioPlayer.shared.currentTrack?.songName
        playerViews.songAuthorLabel.text = AudioPlayer.shared.currentTrack?.songAuthor
        playerViews.slider.maximumValue = Float(audioPlayer?.duration ?? 0)
        playerViews.slider.value = playerViews.sliderOnMiniPlayer.value
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
                
        playerViews.albumImageCollectionView.delegate = self
        playerViews.albumImageCollectionView.dataSource = self
        playerViews.playPauseButton.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        playerViews.downArrowButton.addTarget(self, action: #selector(closePlayerVCPressed), for: .touchUpInside)
        playerViews.repeatButton.addTarget(self, action: #selector(repeatButtonPressed), for: .touchUpInside)
        playerViews.slider.addTarget(self, action: #selector(rewindTrack), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        //guard let audioPlayer = self.audioPlayer else { return }
        
        print(audioPlayer?.isPlaying)
        
        if let audioPlayer = AudioPlayer.shared.player {
            if audioPlayer.isPlaying {
                playerViews.playPauseButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            } else {
                playerViews.playPauseButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            }
        }
        
        if isRepeatActivated {
            AudioPlayer.shared.player?.numberOfLoops = -1
            playerViews.repeatButton.setImage(UIImage(systemName: "repeat.1"), for: .normal)
            playerViews.repeatButton.tintColor = .white
        } else {
            AudioPlayer.shared.player?.numberOfLoops = 0
            playerViews.repeatButton.setImage(UIImage(systemName: "repeat"), for: .normal)
            playerViews.repeatButton.tintColor = .lightGray
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                
        if AudioPlayer.shared.currentTrack?.hasVideoshot == true && audioPlayer?.isPlaying == true {
            
            // Запускаем анимацию изменения прозрачности цвета с повторением и автовозвратом
            UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat], animations: {
                self.playerViews.albumImageCollectionView.alpha = 0.5 // Прозрачность 0.5 означает подсветку
            }, completion: { (finished) in
                // Дополнительные действия по завершении анимации (по усмотрению)
                print("finished")
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.playVideoshot()
                self.playerViews.albumImageCollectionView.alpha = 1.0
            }
        } else {
            playerViews.subviews.forEach {
                if $0.tag == 100 {
                    $0.removeFromSuperview()
                }
                playerViews.layoutIfNeeded()
            }
            playerViews.albumImageCollectionView.alpha = 1.0
            playerViews.albumImageCollectionView.isHidden = false
        }
    }
    
    
    func playVideoshot() {
        // Получаем URL-адрес ресурса видеошота
        guard let videoURL = AudioPlayer.shared.currentTrack?.videoshotPath else {
            print("Не удалось найти видеошот для этого трека")
            return
        }
        videoShotPlayer = AVPlayer(url: videoURL)
        playerController.player = videoShotPlayer
        playerController.showsPlaybackControls = false
        // Устанавливаем масштабирование видеошота до размеров экрана
        playerController.videoGravity = .resizeAspectFill
        addChild(playerController)
        playerViews.insertSubview(playerController.view, at: 0)
        playerController.view.tag = 100
        playerController.allowsPictureInPicturePlayback = false
        playerViews.albumImageCollectionView.isHidden = true
        playerController.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height) // например, вычитаем 100 от высоты
        playerController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        playerController.didMove(toParent: self)
        
        // Добавляем слушатель уведомления о завершении воспроизведения
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: videoShotPlayer.currentItem)
        
        // Начинаем воспроизведение видео
        videoShotPlayer.isMuted = true
        videoShotPlayer.play()
        
        // Добавляем слушатели уведомлений для управления видеошотом при изменении состояния приложения
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc func applicationWillResignActive() {
        // При сворачивании приложения продолжаем воспроизведение видеошота
        videoShotPlayer.play()
    }
    
    @objc func applicationDidBecomeActive() {
        // При возвращении в приложение возобновляем воспроизведение видеошота
        videoShotPlayer.play()
    }
    
    // Метод, вызываемый при завершении воспроизведения
    @objc private func playerDidFinishPlaying() {
        // Перемотаем видео в начало и начнем воспроизведение снова
        videoShotPlayer.seek(to: CMTime.zero)
        videoShotPlayer.isMuted = true
        videoShotPlayer.play()
    }
    
    @objc private func swipeDownHandler() {
        dismiss(animated: true)
    }
    
    @objc private func rewindTrack() {
        audioPlayer?.currentTime = TimeInterval(playerViews.slider.value)
    }
    
    @objc private func updateSlider() {
        
        var currentTime: Int {
            return Int(audioPlayer?.currentTime ?? 0)
        }
        
        var currentMinutes: Int {
            return currentTime / 60
        }
        
        var currentSeconds: Int {
            return currentTime - currentMinutes * 60
        }
        
        var duration: Int {
            return Int(audioPlayer?.duration ?? 0 - (audioPlayer?.currentTime ?? 0))
        }
        
        var remainingMinutes: Int {
            return duration / 60
        }
        
        var remainingSeconds: Int {
            return duration - remainingMinutes * 60
        }
        
        
        playerViews.slider.value = Float(audioPlayer?.currentTime ?? 0)
        UserDefaults.standard.set(playerViews.slider.value, forKey: "valueSlider")
        
        playerViews.songFinishTimeLabel.text = NSString(format: "%2d:%02d", remainingMinutes, remainingSeconds) as String
        
        playerViews.songStartTimeLabel.text = NSString(format: "%2d:%02d", currentMinutes, currentSeconds) as String
        //----
        //playerViews.songFinishTimeLabel.text = NSString(format: "%2d:%02d", AudioPlayer.shared.remainingMinutes, AudioPlayer.shared.remainingSeconds) as String
        
        //playerViews.songStartTimeLabel.text = NSString(format: "%2d:%02d", AudioPlayer.shared.currentMinutes, AudioPlayer.shared.currentSeconds) as String
        
        if audioPlayer?.isPlaying == true {

            playerViews.playPauseButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        } else {
            playerViews.playPauseButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        }
    }
    
    @objc private func closePlayerVCPressed() {
        dismiss(animated: true)
    }
    
    func updateTrack(_ track: SongModel?) {
        // Обновление трека без создания нового экземпляра
        currentTrack = track
        // Другие необходимые обновления, если есть
    }
    
    @objc func playButtonPressed() {
        
        print(audioPlayer?.isPlaying)
        //isPlayPressed.toggle()
        //isPlayPressed.toggle()
        playerViews.playPauseButton.isSelected.toggle()
        
        if playerViews.playPauseButton.isSelected {
            audioPlayer?.play()
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
            playerViews.playPauseButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .selected) // кнопка нажата (трек играет)
            UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat]) {
                self.playerViews.albumImageCollectionView.alpha = 0.5
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.playVideoshot()
                self.playerViews.albumImageCollectionView.alpha = 1.0
            }
        } else {
            playerViews.playPauseButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal) // трек на паузе
            audioPlayer?.pause()
            playerViews.subviews.forEach {
                if $0.tag == 100 {
                    $0.removeFromSuperview()
                }
                playerViews.layoutIfNeeded()
            }
            playerViews.albumImageCollectionView.alpha = 1.0
            playerViews.albumImageCollectionView.isHidden = false
        }
    }
    
    @objc private func repeatButtonPressed() {
        
        isRepeatActivated.toggle()
        UserDefaults.standard.set(isRepeatActivated, forKey: "isRepeatActivated")
        
        if isRepeatActivated {
            AudioPlayer.shared.player?.numberOfLoops = -1
            view.addSubview(playerViews.bigRepeatButtonImageView)
            playerViews.bigRepeatButtonImageView.frame = CGRect(x: view.center.x, y: view.center.y, width: view.frame.width / 2, height: view.frame.height * 0.2)
            playerViews.bigRepeatButtonImageView.center = CGPoint(x: view.center.x, y: view.center.y)
            if playerViews.repeatButton.transform == .identity {
                UIView.animate(withDuration: 0.5) {
                    self.playerViews.bigRepeatButtonImageView.transform = CGAffineTransform(scaleX: 2, y: 2)
                    self.playerViews.repeatButton.setImage(UIImage(systemName: "repeat.1"), for: .normal)
                    self.playerViews.repeatButton.tintColor = .white
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        self.playerViews.bigRepeatButtonImageView.removeFromSuperview()
                    }
                    self.playerViews.bigRepeatButtonImageView.transform = .identity
                }
            }
        } else {
            AudioPlayer.shared.player?.numberOfLoops = 0
            playerViews.repeatButton.setImage(UIImage(systemName: "repeat"), for: .normal)
            playerViews.repeatButton.tintColor = .lightGray
        }
    }
    
    func enlargeImage(for imageView: UIImageView) {
        imageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }
    
    //Функция для получения доминирующего цвета картинки трека
    func dominantColor(for image: UIImage) -> UIColor? {
        /*
         Эта строка создает объект CIImage из входного изображения (image).
         Если изображение не может быть преобразовано в CIImage, функция возвращает nil.
         */
        guard let ciImage = CIImage(image: image) else { return nil }
        let extent = ciImage.extent // используется для определения размеров и расположения изображения ciImage
        let filter = CIFilter(name: "CIAreaAverage") // Здесь создается фильтр CIAreaAverage, который позволяет вычислить средний цвет на изображении.
        filter?.setValue(ciImage, forKey: kCIInputImageKey) // filter?.setValue(ciImage, forKey: kCIInputImageKey): Мы устанавливаем ciImage как входное изображение для фильтра CIAreaAverage
        if let outputImage = filter?.outputImage { // Здесь мы проверяем, удалось ли получить выходное изображение из фильтра CIAreaAverage.
            let context = CIContext() // Мы создаем объект CIContext, который позволит нам работать с изображениями в Core Image.
            let rect = CGRect(x: 0, y: 0, width: 1, height: 1) // Здесь мы создаем маленький прямоугольник размером 1x1 пиксель.
            //Этот прямоугольник будет представлять пиксель, и его цвет будет средним цветом всего изображения.
            if let cgImage = context.createCGImage(outputImage, from: rect) { // Мы используем CIContext, чтобы создать CGImage (изображение Core Graphics) из выходного изображения фильтра в пределах маленького прямоугольника. Это даст нам изображение размером 1x1 пиксель.
                let pixelData = cgImage.dataProvider?.data // Мы получаем данные пикселя этого изображения
                let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData) // Мы получаем указатель на данные пикселя, которые представляют собой значения красного, зеленого и синего каналов цвета.
                let red = CGFloat(data[0]) / 255.0
                let green = CGFloat(data[1]) / 255.0
                let blue = CGFloat(data[2]) / 255.0
                return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
            }
        }
        
        return nil
    }
}

extension PlayerVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SongsCollectionViewCell.cellID, for: indexPath) as! SongsCollectionViewCell
        //let song = songs[indexPath.row]
        //cell.songImage.image = songs[selectedSong?.trackID ?? indexPath.row].albumImage
        cell.songImage.image = AudioPlayer.shared.currentTrack?.albumImage
        
        if ((AudioPlayer.shared.player?.isPlaying) != nil) {
            UIView.animate(withDuration: 0.3) {
                cell.songImage.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                cell.songImage.clipsToBounds = true
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                cell.songImage.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
        return cell
    }
    
    //размер ячейки
    //    func collectionView(_ collectionView: UICollectionView,
    //                        layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        let frameSize = collectionView.frame.size
    //        return CGSize(width: frameSize.width - 10, height: frameSize.height - 10)
    //    }
    
    
    /// Код, чтобы после скролла view отображалась по центру
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width, height: 270)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        playerViews.albumImageCollectionView.collectionViewLayout = layout
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //        for cell in playerVC.albumImageCollectionView.visibleCells as! [SongsCollectionViewCell]    {
        //            let indexPath = playerVC.albumImageCollectionView.indexPath(for: cell as SongsCollectionViewCell)
        //            cell.songImage.image = songs[indexPath!.row].albumImage
        //            print(indexPath?.row)
        //}
    }
    
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        
        //Получаем индекс после скролла
        //        let visibleIndex = Int(targetContentOffset.pointee.x / playerVC.albumImageCollectionView.frame.width)
        //        print(visibleIndex)
        //        trackIndex = visibleIndex
        //view.backgroundColor = UIColor(patternImage: songs[visibleIndex].albumImage)
        
    }
}
