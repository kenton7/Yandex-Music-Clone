//
//  MoreInYourCollectionTableViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 25.11.2023.
//

import UIKit

class MoreInYourCollectionTableViewCell: UITableViewCell {
    
    static let cellID = "MoreInYourCollectionTableViewCell"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        collectionView.register(MoreInYourCollectionViewCell.self, forCellWithReuseIdentifier: MoreInYourCollectionViewCell.cellID)
        return collectionView
    }()
    
    private lazy var moreInYourCollectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ещё у вас в Коллекции"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        selectionStyle = .none
        contentView.isUserInteractionEnabled = false
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(collectionView)
        addSubview(moreInYourCollectionLabel)
        
        NSLayoutConstraint.activate([
            moreInYourCollectionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            collectionView.topAnchor.constraint(equalTo: moreInYourCollectionLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 90),
            
        ])
    }
}

extension MoreInYourCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoreInYourCollectionViewCell.cellID, for: indexPath) as! MoreInYourCollectionViewCell
        cell.backgroundColor = #colorLiteral(red: 0.07843136042, green: 0.07843136042, blue: 0.07843136042, alpha: 1)
        cell.playlistTypeLabel.text = cell.playlistTypes[indexPath.item]
        
        switch indexPath.item {
        case 0:
            cell.informationAboutPlaylistLabel.text = "Топ, Тайник, Мой 22-й"
            cell.imageView3.image = UIImage(named: "100RussianHits")
            cell.imageView2.image = UIImage(named: "Premier")
            cell.imageView1.image = UIImage(named: "NILETTO, Олег Майами & Лёша Свик - Не Вспоминай")
        case 1:
            cell.informationAboutPlaylistLabel.text = "3 часа"
            cell.imageView3.image = UIImage(named: "Oxxxymiron - Агент")
            cell.imageView2.image = UIImage(named: "Markul, Тося Чайкина - Стрелы")
            cell.imageView1.image = UIImage(named: "Muse - The Handler")
        case 2:
            cell.informationAboutPlaylistLabel.text = "Не вспоминай, Мурашками"
            cell.imageView3.image = UIImage(named: "The Weeknd - Save Your Tears")
            cell.imageView2.image = UIImage(named: "NILETTO, Олег Майами & Лёша Свик - Не Вспоминай")
            cell.imageView1.image = UIImage(named: "Три дня дождя, MONA - Прощание")
        case 3:
            cell.informationAboutPlaylistLabel.isHidden = true
            cell.imageView1.image = UIImage(systemName: "teddybear")
            cell.imageView1.tintColor = .lightGray
            cell.imageView2.isHidden = true
            cell.imageView3.isHidden = true
        case 4:
            cell.informationAboutPlaylistLabel.isHidden = true
            cell.imageView1.image = UIImage(systemName: "books.vertical")
            cell.imageView1.tintColor = .lightGray
            cell.imageView2.isHidden = true
            cell.imageView3.isHidden = true
        case 5:
            cell.informationAboutPlaylistLabel.text = "CocoaHeads, Podlodka Podcast"
            cell.imageView3.image = UIImage(named: "Podlodka")
            cell.imageView2.image = UIImage(named: "CocoaHeads")
            cell.imageView1.isHidden = true
        default:
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 80)
    }
    
}
