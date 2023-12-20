//
//  RecommendationsNewCollectionViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 17.12.2023.
//

import UIKit

enum TypesOfRelease: String {
    case single = "СИНГЛ"
    case album = "АЛЬБОМ"
}

class RecommendationsNewCollectionViewCell: UICollectionViewCell {
 
    static let cellID = "RecommendationsNewCollectionViewCell"
    
    private lazy var nameOfCell: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Рекомендуем новинки"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    let recommendationsImages: [UIImage] = [
        UIImage(named: "Лёша Свик")!,
        UIImage(named: "Скриптонит")!,
        UIImage(named: "Hammali&Navai")!,
        UIImage(named: "NILETTO")!,
        UIImage(named: "Баста")!,
        UIImage(named: "Lx24")!,
        UIImage(named: "Илья Никко")!,
        UIImage(named: "T-killah")!,
        UIImage(named: "Краймбрери")!
    ]
    
    let recommendationsSongNames = [
        "Замок из дождя",
        "YEAHH, Pt. 1",
        "Снова 17",
        "Снова холодает",
        "Не забывай меня",
        "Бывшая (Чтоб ты стала пышная)",
        "Ранила",
        "Пустыня из золота",
        "Она опять разденется"
    ]
    
    let recommendationSongImages: [UIImage] = [
        UIImage(named: "Замок из дождя")!,
        UIImage(named: "Yeahh. Pt. 1")!,
        UIImage(named: "Снова 17")!,
        UIImage(named: "Снова холодает")!,
        UIImage(named: "Не забывай меня")!,
        UIImage(named: "Бывшая")!,
        UIImage(named: "Ранила")!,
        UIImage(named: "Пустыня из золота")!,
        UIImage(named: "Она опять разденется")!
    ]
    
     let recommendationNames = [
        "Лёша Свик",
        "Скриптонит",
        "HammAli & Navai",
        "NILETTO",
        "Баста",
        "Lx24",
        "Илья Никко",
        "T-killah",
        "Мари Краймбрери"
    ]
    
    let dates = [
        "24 ноября 2023",
        "1 декабря 2023",
        "8 декабря 2023",
        "1 декабря 2023",
        "29 ноября 2023",
        "24 ноября 2023",
        "1 декабря 2023",
        "7 декабря 2023",
        "1 декабря 2023",
    ]
    
    lazy var artistImage: UIImageView = {
        let view = UIImageView()
        view.frame = CGRect(x: 10, y: 10, width: 350, height: 350)
        view.center = self.center
        view.layer.cornerRadius = view.frame.width / 2
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var artistName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var viewForTrack: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: frame.size.width - 20, height: 50)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemCyan
        return view
    }()
    
    lazy var trackImageForView: UIImageView = {
        let view = UIImageView()
        view.frame = CGRect(x: 10, y: viewForTrack.bounds.midY / 2, width: 65, height: 65)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        //view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    lazy var typeOfRecommendation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "СИНГЛ"
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .white.withAlphaComponent(0.8)
        label.textAlignment = .left
        return label
    }()
    
    lazy var songNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "6 декабря 2023"
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .white.withAlphaComponent(0.8)
        label.textAlignment = .left
        return label
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        let image = UIImage(systemName: "play.circle.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        //addSubview(nameOfCell)
        addSubview(artistImage)
        addSubview(artistName)
        addSubview(viewForTrack)
        addSubview(trackImageForView)
        addSubview(typeOfRecommendation)
        addSubview(songNameLabel)
        addSubview(dateLabel)
        addSubview(playButton)
        
        viewForTrack.addSubview(trackImageForView)
        viewForTrack.addSubview(typeOfRecommendation)
        viewForTrack.addSubview(songNameLabel)
        viewForTrack.addSubview(dateLabel)
        viewForTrack.addSubview(playButton)
        
        NSLayoutConstraint.activate([
            
            artistImage.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            artistImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            artistImage.widthAnchor.constraint(equalToConstant: 350),
            artistImage.heightAnchor.constraint(equalToConstant: 350),
            
            artistName.centerXAnchor.constraint(equalTo: artistImage.centerXAnchor),
            artistName.bottomAnchor.constraint(equalTo: viewForTrack.topAnchor, constant: -20),
            
            viewForTrack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            viewForTrack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            viewForTrack.topAnchor.constraint(equalTo: artistImage.bottomAnchor, constant: -60),
            viewForTrack.heightAnchor.constraint(equalToConstant: 90),
            
            trackImageForView.heightAnchor.constraint(equalToConstant: 65),
            trackImageForView.widthAnchor.constraint(equalToConstant: 65),
            
            typeOfRecommendation.leadingAnchor.constraint(equalTo: trackImageForView.trailingAnchor, constant: 10),
            typeOfRecommendation.topAnchor.constraint(equalTo: viewForTrack.topAnchor, constant: 10),
            
            songNameLabel.leadingAnchor.constraint(equalTo: trackImageForView.trailingAnchor, constant: 10),
            songNameLabel.topAnchor.constraint(equalTo: typeOfRecommendation.bottomAnchor, constant: 0),
            songNameLabel.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -10),
            
            
            dateLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: trackImageForView.trailingAnchor, constant: 10),
            dateLabel.bottomAnchor.constraint(equalTo: viewForTrack.bottomAnchor, constant: -5),
            
            playButton.trailingAnchor.constraint(equalTo: viewForTrack.trailingAnchor, constant: -10),
            playButton.centerYAnchor.constraint(equalTo: viewForTrack.centerYAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 60),
            playButton.widthAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    
}
