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
    
    static let shared = PlayerVC()
    let playerViews = PlayerVIews()
    let mainVC = MainVC()
    var isPlayPressed: Bool {
        if AudioPlayer.shared.player?.isPlaying == true {
            return true
        } else {
            return false
        }
    }
    
    private var currentTrackIndex: Int = 0 {
        didSet {
            playerViews.albumImageCollectionView.reloadData()
        }
    }
    
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
        
        //AudioPlayer.shared.setupPlayer(track: getNeededTrack!)
        //AudioPlayer.shared.setTrack(track: AudioPlayer.shared.currentTrack!)
        //audioPlayer = AudioPlayer.shared.player
//        guard let player = AudioPlayer.shared.player else {
//                print("Player is not set")
//                return
//            }
        
        
        view.backgroundColor = dominantColor(for: AudioPlayer.shared.currentTrack?.albumImage ?? SongModel.getSongs().randomElement()!.albumImage)
        playerViews.songNameLabel.text = currentTrack?.songName
        playerViews.songAuthorLabel.text = currentTrack?.songAuthor
        playerViews.slider.maximumValue = Float(AudioPlayer.shared.player?.duration ?? 0)
        //playerViews.slider.value = playerViews.sliderOnMiniPlayer.value
        playerViews.slider.value = UserDefaults.standard.float(forKey: "valueSlider")
        AudioPlayer.shared.currentTrack = currentTrack!
        
        currentTrackIndex = SongModel.getSongs().firstIndex(where: { $0 == getNeededTrack }) ?? 0
        
        print(getNumberOfArtistIn(track: AudioPlayer.shared.currentTrack!))
        
        if getNumberOfArtistIn(track: AudioPlayer.shared.currentTrack!) == 2 {
            playerViews.artistImage2.isHidden = false
            playerViews.moreThanTwoArtists.isHidden = true
            //playerViews.songInfoStackViewLeadingAnchor.constant = 20
            playerViews.songInfoStackView.leadingAnchor.constraint(equalTo: playerViews.artistImage2.trailingAnchor, constant: 20).isActive = true
        } else if getNumberOfArtistIn(track: AudioPlayer.shared.currentTrack!) == 1 {
            playerViews.artistImage2.isHidden = true
            playerViews.moreThanTwoArtists.isHidden = true
            playerViews.songInfoStackView.leadingAnchor.constraint(equalTo: playerViews.artistImage.trailingAnchor, constant: 20).isActive = true
        } else if getNumberOfArtistIn(track: AudioPlayer.shared.currentTrack!) > 2 {
            playerViews.moreThanTwoArtists.isHidden = false
            playerViews.songInfoStackView.leadingAnchor.constraint(equalTo: playerViews.moreThanTwoArtists.trailingAnchor, constant: 10).isActive = true
        }
                                
        playerViews.albumImageCollectionView.delegate = self
        playerViews.albumImageCollectionView.dataSource = self
        playerViews.playPauseButton.addTarget(self, action: #selector(playButtonPressed(_ :)), for: .touchUpInside)
        playerViews.downArrowButton.addTarget(self, action: #selector(closePlayerVCPressed), for: .touchUpInside)
        playerViews.repeatButton.addTarget(self, action: #selector(repeatButtonPressed), for: .touchUpInside)
        playerViews.slider.addTarget(self, action: #selector(rewindTrack), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if AudioPlayer.shared.player == nil {
            AudioPlayer.shared.setTrack(track: AudioPlayer.shared.currentTrack!)
            playerViews.slider.maximumValue = Float(AudioPlayer.shared.player?.duration ?? 0)
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
        }
        
        guard let player = AudioPlayer.shared.player else {
            print("Не удалось инициировать плеер")
            return
        }
                
        if player.isPlaying {
            playerViews.playPauseButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
        } else {
            playerViews.playPauseButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            updateSlider()
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
        
        if AudioPlayer.shared.currentTrack?.isFavourite == true {
            playerViews.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            playerViews.likeButton.tintColor = .white
        } else {
            playerViews.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            playerViews.likeButton.tintColor = .white
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                
        if AudioPlayer.shared.currentTrack?.hasVideoshot == true && AudioPlayer.shared.player?.isPlaying == true {
            
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
    
    private func getNumberOfArtistIn(track: SongModel) -> Int {
        
        let authors = track.songAuthor.components(separatedBy: ", ")
        
        if authors.count == 1 {
            playerViews.artistImage2.isHidden = true
            playerViews.artistImage.image = track.artistImage.first
        } else {
            playerViews.artistImage2.isHidden = false
            playerViews.artistImage.image = track.artistImage.first
            playerViews.artistImage2.image = track.artistImage[1]
        }
        
//        // Оцениваем ширину текста
//        let textSize = (playerViews.songAuthorLabel.text! as NSString).boundingRect(with: playerViews.songAuthorLabel.bounds.size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: playerViews.songAuthorLabel.font!], context: nil)
//        print(textSize)
//        print(playerViews.songAuthorLabel.bounds.width)
//        // Сравниваем ширину текста с шириной лейбла
//        if textSize.width > playerViews.songAuthorLabel.bounds.width {
//            print("here")
//              // Текст не умещается, применяем анимацию
//              animateText()
//          }
        
        return authors.count
    }
    
//    func animateText() {
//        // Используем UIView.animate для создания анимации
//        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .autoreverse], animations: {
//            // Устанавливаем новую позицию метки (в данном случае, сдвигаем ее вправо)
//            self.playerViews.songAuthorLabel.center.x += 100
//        }, completion: nil)
//    }
    
    func playVideoshot() {
        // Получаем URL-адрес ресурса видеошота
        guard let videoURL = AudioPlayer.shared.currentTrack?.videoshotPath else {
            print("Не удалось найти видеошот для этого трека")
            return
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat]) {
            self.playerViews.albumImageCollectionView.alpha = 0.5
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
        AudioPlayer.shared.player?.currentTime = TimeInterval(playerViews.slider.value)
    }
    
    @objc private func updateSlider() {

        guard let player = AudioPlayer.shared.player else {
            print("Не удалось инициировать плеер")
            return
        }
                
        playerViews.slider.value = Float(player.currentTime)
        UserDefaults.standard.set(playerViews.slider.value, forKey: "valueSlider")
        
        playerViews.songFinishTimeLabel.text = NSString(format: "%2d:%02d", AudioPlayer.shared.remainingMinutes, AudioPlayer.shared.remainingSeconds) as String
        playerViews.songStartTimeLabel.text = NSString(format: "%2d:%02d", AudioPlayer.shared.currentMinutes, AudioPlayer.shared.currentSeconds) as String
    }
    
    @objc private func closePlayerVCPressed() {
        dismiss(animated: true)
    }
    
    func updateTrack(_ track: SongModel?) {
        // Обновление трека без создания нового экземпляра
        currentTrack = track
    }
    
    @objc func playButtonPressed(_ sender: UIButton) {
        
        //isPlayPressed.toggle()
        
        if isPlayPressed == true {
            playerViews.playPauseButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            AudioPlayer.shared.player?.pause()
            
            playerViews.subviews.forEach {
                if $0.tag == 100 {
                    $0.removeFromSuperview()
                }
                playerViews.layoutIfNeeded()
            }
            playerViews.albumImageCollectionView.alpha = 1.0
            playerViews.albumImageCollectionView.isHidden = false
            playerViews.albumImageCollectionView.transform = CGAffineTransform.identity
        } else {
            playerViews.playPauseButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            AudioPlayer.shared.player?.play()
            playerViews.albumImageCollectionView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)

            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.playVideoshot()
                self.playerViews.albumImageCollectionView.alpha = 1.0
            }
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
    
    //Функция для получения доминирующего цвета картинки трека
    private func dominantColor(for image: UIImage) -> UIColor? {
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
        
        //cell.songImage.image = SongModel.getSongs()[indexPath.item].albumImage
        cell.songImage.image = SongModel.getSongs()[AudioPlayer.shared.currentTrack?.trackID ?? 0].albumImage
        
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
