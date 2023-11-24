//
//  SongModel.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 13.10.2023.
//

import Foundation
import UIKit
import AVFoundation
import MediaPlayer

struct SongModel: Equatable {
    var songName: String
    var albumImage: UIImage
    var songAuthor: String
    var fileURL: URL
    var trackID: Int
    var hasVideoshot: Bool
    var videoshotPath: URL?
    var isFavourite: Bool
    
    static func getSongs() -> [SongModel] {
        let song1 = SongModel(songName: "Загоны", albumImage: UIImage(named: "Лёша Свик - Загоны")!, songAuthor: "Лёша Свик", fileURL: URL(fileURLWithPath: Bundle.main.path(forResource: "Лёша Свик - Загоны", ofType: "mp3")!), trackID: 0, hasVideoshot: false, videoshotPath: nil, isFavourite: true)
        let song2 = SongModel(songName: "Стрелы", albumImage: UIImage(named: "Markul, Тося Чайкина - Стрелы")!, songAuthor: "Markul, Тося Чайкина", fileURL: URL(fileURLWithPath: Bundle.main.path(forResource: "Markul, Тося Чайкина - Стрелы", ofType: "mp3")!), trackID: 1, hasVideoshot: true, videoshotPath: Bundle.main.url(forResource: "Markul_Тося Чайкина-Стрелы_Сниппет", withExtension: "mp4"), isFavourite: true)
        let song3 = SongModel(songName: "The Handler", albumImage: UIImage(named: "Muse - The Handler")!, songAuthor: "Muse", fileURL: URL(fileURLWithPath: Bundle.main.path(forResource: "Muse - The Handler", ofType: "mp3")!), trackID: 2, hasVideoshot: false, videoshotPath: nil, isFavourite: true)
        let song4 = SongModel(songName: "Save Your Tears", albumImage: UIImage(named: "The Weeknd - Save Your Tears")!, songAuthor: "The Weeknd", fileURL: URL(fileURLWithPath: Bundle.main.path(forResource: "The Weeknd - Save Your Tears", ofType: "mp3")!), trackID: 3, hasVideoshot: false, videoshotPath: nil, isFavourite: true)
        let song5 = SongModel(songName: "Прощание", albumImage: UIImage(named: "Три дня дождя, MONA - Прощание")!, songAuthor: "Три дня дождя, MONA", fileURL: URL(fileURLWithPath: Bundle.main.path(forResource: "Три дня дождя, MONA - Прощание", ofType: "mp3")!), trackID: 4, hasVideoshot: false, videoshotPath: nil, isFavourite: true)
        let song6 = SongModel(songName: "Не вспоминай", albumImage: UIImage(named: "NILETTO, Олег Майами & Лёша Свик - Не Вспоминай")!, songAuthor: "NILETTO, Олег Майами, Лёша Свик", fileURL: URL(fileURLWithPath: Bundle.main.path(forResource: "NILETTO, Олег Майами & Лёша Свик - Не Вспоминай", ofType: "mp3")!), trackID: 5, hasVideoshot: true, videoshotPath: Bundle.main.url(forResource: "Не вспоминай - сниппет", withExtension: "mp4"), isFavourite: true)
        let song7 = SongModel(songName: "Агент", albumImage: UIImage(named: "Oxxxymiron - Агент")!, songAuthor: "Oxxxymiron", fileURL: URL(fileURLWithPath: Bundle.main.path(forResource: "Oxxxymiron - Агент", ofType: "mp3")!), trackID: 6, hasVideoshot: false, videoshotPath: nil, isFavourite: true)
        return [song1, song2, song3, song4, song5, song6, song7]
    }
}

class AudioPlayer {
    
    var playerShared = AVAudioPlayer()
    var player: AVAudioPlayer?
    static let shared = AudioPlayer()
    private var songs: [SongModel] = [] // Массив песен
    private var currentIndex: Int = 0 // Индекс текущей песни
    var currentMinutes: Int {
        return currentTime / 60
    }
    var currentSeconds: Int {
        return currentTime - currentMinutes * 60
    }
    var remainingMinutes: Int {
        return duration / 60
    }
    var remainingSeconds: Int {
        return duration - remainingMinutes * 60
    }
    
    var duration: Int {
        return Int((player?.duration ?? 0) - (player?.currentTime ?? 0))
    }
    
    var currentTime: Int {
        return Int(player?.currentTime ?? 0)
    }
    
    var currentTrack: SongModel?
    
    func play(song: SongModel) {
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.allowAirPlay, .allowBluetooth, .allowBluetoothA2DP, .interruptSpokenAudioAndMixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch(let error) {
            print(error.localizedDescription)
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: currentTrack!.fileURL)
            player?.play()
        } catch let error {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
    
    func setupPlayer(track: SongModel) {
        guard let url = Bundle.main.url(forResource: "\(track.songAuthor) - \(track.songName)", withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.prepareToPlay()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func setTrack(track: SongModel) {
        // Устанавливаем текущий трек
        currentTrack = track

        do {
            // Создаем новый AVAudioPlayer с URL текущего трека
            player = try AVAudioPlayer(contentsOf: track.fileURL)
            // Дополнительные настройки аудиоплеера, если необходимо
            //player?.prepareToPlay()
        } catch let error {
            print("Error setting track: \(error.localizedDescription)")
        }
    }
    
    func pause(song: SongModel) {
        player?.pause()
    }
    
    func playNext() {
        currentIndex = (currentIndex + 1) % songs.count
        play(song: songs[currentIndex])
    }
    
    func playPrevious() {
        currentIndex = (currentIndex - 1 + songs.count) % songs.count
        play(song: songs[currentIndex])
    }
}

