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
    let appearance = UINavigationBarAppearance()
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
        

        //_ = Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(updateCellData), userInfo: nil, repeats: true)
        
        //mainChildViews.tableView.delegate = self
        //mainChildViews.tableView.dataSource = self
        
        mainChildViews.childCollectionView.delegate = self
        mainChildViews.childCollectionView.dataSource = self
        mainChildViews.childCollectionView.collectionViewLayout = createLayout()
        mainChildViews.childCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ((self.tabBarController?.tabBar.frame.size.height)! * 2) + 50, right: 0)
        
        
//        mainChildViews.recomendationsCollectionView.delegate = self
//        mainChildViews.recomendationsCollectionView.dataSource = self
                
       // tabBarController?.tabBar.isTranslucent = false
        //tabBarController?.tabBar.backgroundImage = UIImage()
        //tabBarController?.tabBar.shadowImage = UIImage()
        //tabBarController?.tabBar.backgroundColor = UIColor.clear
        //tabBarController?.tabBar.barTintColor = UIColor.clear
        tabBarController?.tabBar.isTranslucent = true
        
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
//            mainChildViews.miniPlayer.isHidden = false
//            mainChildViews.sliderOnMiniPlayer.isHidden = false
//            mainChildViews.songName.isHidden = false
//            mainChildViews.songAuthor.isHidden = false
//            mainChildViews.likeButtonMiniPlayer.isHidden = false
//            mainChildViews.changeSourcePlayingMiniPlayer.isHidden = false
//            mainChildViews.playPauseButtonMiniPlayer.isHidden = false
        }
        
        if AudioPlayer.shared.player?.isPlaying == true {
            print("child playing")
            mainChildViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)), for: .normal)
        } else {
            print("child not playing")
            mainChildViews.playPauseButtonMiniPlayer.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)), for: .normal)
        }
        
        mainChildViews.songName.text = UserDefaults.standard.string(forKey: "songName")
        mainChildViews.songAuthor.text = UserDefaults.standard.string(forKey: "songAuthor")
        mainChildViews.sliderOnMiniPlayer.maximumValue = UserDefaults.standard.float(forKey: "maximumValue")
        mainChildViews.sliderOnMiniPlayer.value = UserDefaults.standard.float(forKey: "valueSlider")
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.alpha = 1.0
        
    }
    
    @objc private func updateTime() {
        mainChildViews.sliderOnMiniPlayer.value = UserDefaults.standard.float(forKey: "valueSlider")
        UserDefaults.standard.set(mainChildViews.sliderOnMiniPlayer.value, forKey: "valueSlider")
    }
    
//    @objc private func updateCellData() {
//        if let previousCell = mainChildViews.tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? MetInMyWaveTableViewCell {
//            previousCell.playerView.stopVideo()
//        }
//        videoIDs[0] = videoIDs.randomElement()!
//        mainChildViews.tableView.reloadSections(IndexSet(integer: 4), with: .left)
//    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
                        
            switch sectionIndex {
            case 0:
                return self.createRecomendationtsLayout()
            case 1:
                return self.createMyLikedTracksLayout()
            case 2:
                return self.recommendNewLayout()
            case 3:
                return self.inStyleLayout()
            case 4:
                return self.inStyleCollectionLayout()
            case 5:
                return self.inStyleLayout()
            case 6:
                return self.myWaveGengresLayout()
            case 7:
                return self.metInMyWaveLayout()
            case 8:
                return self.inStyleCollectionLayout()
            default:
                return self.createRecomendationtsLayout()
            }
        }
    }
    
    private func createLayoutSection(group: NSCollectionLayoutGroup,
                                     behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
                                     interGroupSpacing: CGFloat,
                                     supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem],
                                     contentInsets: Bool) -> NSCollectionLayoutSection {
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems
        return section
    }
    
    private func createRecomendationtsLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), 
                                              heightDimension: .absolute(70))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                               heightDimension: .absolute(70))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(20)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        return section
    }
    
    private func createMyLikedTracksLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(90))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(90))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 10, leading: 10, bottom: 0, trailing: 10)
        return section
    }
    
    private func recommendNewLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(430))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(430))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        //group.supplementaryItems = [supplementaryHeaderItem()]
        // Заголовок секции
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        // pinToVisibleBounds в true, чтобы сделать заголовок видимым и непрокручиваемым
        header.pinToVisibleBounds = false
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        if #available(iOS 16.0, *) {
            section.supplementaryContentInsetsReference = .none
        } else {
            // Fallback on earlier versions
            section.supplementariesFollowContentInsets = false
        }
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: 0, leading: 0, bottom: 30, trailing: 0)
        return section
    }
    
    private func inStyleLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(44), heightDimension: .absolute(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(44), heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, /*supplementary*/])
        group.interItemSpacing = .fixed(20)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        header.pinToVisibleBounds = false
    
        let section = NSCollectionLayoutSection(group: group)
        //section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 10)
        return section
    }
    
    private func inStyleCollectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(180),
                                              heightDimension: .absolute(250))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                               heightDimension: .absolute(250))
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        header.pinToVisibleBounds = false
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [header]
        section.contentInsets = .init(top: 0, leading: 0, bottom: 50, trailing: 0)
        return section
    }
    
    private func myWaveGengresLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95),
                                               heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        return section
    }
    
    private func metInMyWaveLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(120),
                                              heightDimension: .absolute(150))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(120),
                                               heightDimension: .absolute(150))
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(20))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        header.pinToVisibleBounds = false
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        return section
    }
    
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {

        return .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                       heightDimension: .estimated(30)),
                     elementKind: UICollectionView.elementKindSectionHeader,
                     alignment: .top)
    }
    
}

extension MainChildVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return 10
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = ForYouOrTrendsTableViewCell(style: .default, reuseIdentifier: ForYouOrTrendsTableViewCell.cellID)
            return cell
        case 1:
            let cell = YourFavouriteTableViewCell(style: .default, reuseIdentifier: YourFavouriteTableViewCell.cellID)
            return cell
        case 2:
            let cell = RecommendNewTableViewCell(style: .default, reuseIdentifier: RecommendNewTableViewCell.cellID)
            return cell
//            let cell = ListenedRecentlyTableViewCell(style: .default, reuseIdentifier: ListenedRecentlyTableViewCell.cellID)
//            return cell
        case 3:
            let cell = InStyleTableViewCell(style: .default, reuseIdentifier: InStyleTableViewCell.cellID)
            return cell
        case 4:
            let cell = MetInMyWaveTableViewCell(style: .default, reuseIdentifier: MetInMyWaveTableViewCell.cellID)
            
//            cell.playerView.load(withVideoId: videoIDs[0], playerVars: [
//                "playsinline": 1,
//                "mute": 1,
//                "controls": 1,
//                "allowFullscreen": 1,
//                "autohide": 1,
//                "showinfo": 0,
//                "modestbranding": 1,
//                "rel": 0,
//                "loop": 1
//            ])
//            cell.playerView.delegate = self
            return cell
            
        case 5:
            let cell = MoreTableViewCell(style: .default, reuseIdentifier: MoreTableViewCell.cellID)
            return cell
        case 6:
            let cell = CollectForYouCell(style: .default, reuseIdentifier: CollectForYouCell.cellID)
            return cell
            
        case 7:
            let cell = NeuroMusicTableViewCell(style: .default, reuseIdentifier: NeuroMusicTableViewCell.cellID)
            return cell
            
        case 8:
            let cell = ListenedRecentlyTableViewCell(style: .default, reuseIdentifier: ListenedRecentlyTableViewCell.cellID)
            return cell
//            
//        case 7:
//            let cell = ChartTableViewCell(style: .default, reuseIdentifier: ChartTableViewCell.cellID)
//            return cell
//            
//        case 8:
//            let cell = NeuroMusicTableViewCell(style: .default, reuseIdentifier: NeuroMusicTableViewCell.cellID)
//            return cell
//            
//        case 9:
//            let cell = SelectionsTableViewCell(style: .default, reuseIdentifier: SelectionsTableViewCell.cellID)
//            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 100
        case 1:
            return 110
        case 2:
            return 450
        case 3:
            return 300
        case 4:
            return 150
        case 5:
            return 130
        case 6:
            return 300
        case 7:
            return 300
        case 8:
            return 300
//        case 8:
//            return 180
//        case 9:
//            
//            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: mainChildViews.miniPlayer.frame.height + tabBarController!.tabBar.frame.height + 30, right: 0)
//            let numberOfColumns: CGFloat = 2 // кол-во рядов на экране в одну строку
//            let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // значения отступов между секциями
//            
//            let interItemSpacing = CGFloat(10) // значение интервалов между ячейками
//            
//            let collectionViewWidth = tableView.frame.width - sectionInsets.left - sectionInsets.right // ширина коллекции
//            let itemWidth = floor((collectionViewWidth + interItemSpacing) / numberOfColumns) - interItemSpacing //ширина контента коллекции (ячейки)
//            
//            let numberOfRows = ceil(CGFloat(11) / numberOfColumns)
//            
//            let totalHeight = (itemWidth * numberOfRows) + ((numberOfRows - 1) * interItemSpacing) + sectionInsets.top + sectionInsets.bottom // высота
//            
//            return totalHeight
        default:
            return UITableView.automaticDimension
        }
    }
}

extension MainChildVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //Метод запрашивает отображение доп объекта
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: HeaderSupplementaryView.cellID,
                                                                         for: indexPath) as! HeaderSupplementaryView
            
            switch indexPath.section {
            case 0:
                header.configureHeader(categoryName: "")
            case 1:
                header.configureHeader(categoryName: "")
            case 2:
                header.configureHeader(categoryName: "Рекомендуем новинки")
                
            case 3:
                header.configureHeader(categoryName: "В стиле")
                
            case 4:
                header.configureHeader(categoryName: "")
                
            case 7:
                header.configureHeader(categoryName: "Встретились в Моей волне")
            case 8:
                header.configureHeader(categoryName: "Собираем для вас")
            default:
                header.configureHeader(categoryName: "")
            }
            
            //header.configureHeader(categoryName: sections[indexPath.section].title)
            return header
        }
//        } else if kind == "textElementKind" {
//            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: StyleCollectionViewCell.cellID, for: indexPath) as! StyleCollectionViewCell
//            cell.artistImage.image = cell.inStyleArtistsImages[indexPath.item]
//            cell.artistName.text = cell.inStyleArtistsNames[indexPath.item]
//            
//            return cell
//        }
        return UICollectionReusableView()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        case 2:
            return 9
        case 3:
            return 6
        case 4:
            return 8
        case 5:
            return 4
        case 6:
            return 6
        case 7:
            return 8
        case 8:
            return 4
        default:
            return 2
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecomendationsCollectionViewCell.cellID, for: indexPath) as! RecomendationsCollectionViewCell
            if indexPath.item == 0 {
                cell.forYouLabel.text = "Для вас"
                cell.artistsLabel.text = "Oxxxymiron, NILETTO"
                cell.imageView1InForYouLabel.image = UIImage(named: "Oxxxymiron")
                cell.imageView2InForYouLabel.image = UIImage(named: "NILETTO")
            } else {
                cell.forYouLabel.text = "Тренды"
                cell.artistsLabel.text = "Лёша Свик, Markul"
                cell.imageView1InForYouLabel.image = UIImage(named: "Лёша Свик")
                cell.imageView2InForYouLabel.image = UIImage(named: "Markul")
            }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyLikedTracksCollectionViewCell.cellID, for: indexPath) as! MyLikedTracksCollectionViewCell
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationsNewCollectionViewCell.cellID, for: indexPath) as! RecommendationsNewCollectionViewCell
            cell.artistImage.image = cell.recommendationsImages[indexPath.item]
            cell.artistName.text = cell.recommendationNames[indexPath.item]
            cell.songNameLabel.text = cell.recommendationsSongNames[indexPath.item]
            cell.trackImageForView.image = cell.recommendationSongImages[indexPath.item]
            cell.dateLabel.text = cell.dates[indexPath.item]
            cell.viewForTrack.backgroundColor = .dominantColor(for: cell.recommendationSongImages[indexPath.item])
            
            if indexPath.item == 1 {
                cell.typeOfRecommendation.text = TypesOfRelease.album.rawValue
            } else {
                cell.typeOfRecommendation.text = TypesOfRelease.single.rawValue
            }
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StyleCollectionViewCell.cellID, for: indexPath) as! StyleCollectionViewCell
            if indexPath.item == 0 {
                cell.artistName.text = "В стиле"
                cell.artistImage.isHidden = true
            } else {
                cell.interestingNowLabel.isHidden = true
                cell.artistImage.isHidden = false
                cell.artistImage.image = cell.inStyleArtistsImages[indexPath.item - 1]
                cell.artistName.text = cell.inStyleArtistsNames[indexPath.item - 1]
            }
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StyleRecomedationsCollectionViewCell.cellID, for: indexPath) as! StyleRecomedationsCollectionViewCell
            
            cell.artistName.text = cell.collectionArtists[indexPath.item]
            cell.songImageView.image = cell.collectionImages[indexPath.item]
            cell.songName.text = cell.collectionSongNames[indexPath.item]
            return cell
        case 5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoreOpenedInMyWaveCollectionViewCell.cellID, for: indexPath) as! MoreOpenedInMyWaveCollectionViewCell
            
            if indexPath.item == 0 {
                cell.typeLabel.text = "Больше открытий"
                cell.typeLabel.textColor = .white
                cell.typeLabel.font = .boldSystemFont(ofSize: 16)
                cell.isUserInteractionEnabled = false
            } else {
                cell.typeLabel.text = cell.types[indexPath.item - 1]
                cell.typeLabel.textColor = .lightGray
            }
            return cell
            
        case 6:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyWaveGenresCollectionViewCell.cellID, for: indexPath) as! MyWaveGenresCollectionViewCell
            cell.myWaveTypesLabel.text = "▶ \(cell.myWaveTypes[indexPath.item])"
            cell.stackView.backgroundColor = cell.colors[indexPath.item]
            let animation = CABasicAnimation(keyPath: "colors")
            
            animation.fromValue = [cell.colors[indexPath.item].cgColor, UIColor.white.cgColor]
            animation.toValue = [UIColor.white.cgColor, cell.colors[indexPath.item].cgColor]
            animation.autoreverses = true
            animation.duration = 5.0
            animation.repeatCount = Float.infinity
            cell.gradientLayer.frame = cell.bounds
            cell.gradientLayer.add(animation, forKey: nil)
            return cell
            
        case 7:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MetInWaveCollectionViewCell.cellID, for: indexPath) as! MetInWaveCollectionViewCell
            cell.artistImage.image = cell.artistsImages[indexPath.item]
            cell.artistName.text = cell.artistNames[indexPath.item]
            return cell
        case 8:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectForYouCollectionViewCell.cellID, for: indexPath) as! CollectForYouCollectionViewCell
            cell.descriptionLabel.text = cell.descriptionPlaylist[indexPath.item]
            cell.playlistImage.image = cell.images[indexPath.item]
            return cell
        default:
            return UICollectionViewCell()
        }
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecomendationsCollectionViewCell.cellID, for: indexPath) as! RecomendationsCollectionViewCell
//        
//        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width / 2, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.item == 0 {
                print("Для вас")
            } else {
                print("Тренды")
            }
        case 1:
            let allMyTracksVC = AllMyTracksCollectionViewController(collectionViewLayout: AllMyTracksLayout())
            self.navigationController?.pushViewController(allMyTracksVC, animated: true)
        default:
            break
        }
    }
    
}

extension MainChildVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        let maxContentOffsetY: CGFloat = -97.66666666666667
        
        if scrollView.contentOffset.y < -110 {
            // Остановите скроллинг, установив новый contentOffset
            scrollView.setContentOffset(CGPoint(x: 0, y: maxContentOffsetY), animated: false)
            if let parentVC = self.parent as? MainVC {
                parentVC.returnChildToInitialState()
                print("return")
            }
        }

//        if scrollView.contentOffset.y <= -120 {
//            if let parentVC = self.parent as? MainVC {
//                parentVC.returnChildToInitialState()
//            }
//        }
    }
}

