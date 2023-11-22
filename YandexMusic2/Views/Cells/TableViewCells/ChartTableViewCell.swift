//
//  ChartTableViewCell.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 05.11.2023.
//

import UIKit

class ChartTableViewCell: UITableViewCell {
    
    static let cellID = "ChartTableViewCell"
    
    private let first5TracksInChart = [
        "Царица": "ANNA ASTI", "Спонсор твоих проблем": "GUF, A.V.G", "Зима в сердце": "Моя Мишель", "Север": "Tkimali, Лолита",
        "Давай сбежим (Искорки) prod. by Barabanov": "5УТРА"
    ]
    
    private lazy var first5Tracks = [
        ("Царица", "ANNA ASTI"), ("Спонсор твоих проблем", "GUF, A.V.G"), ("Зима в сердце", "Моя Мишель"), ("Север", "Tkimali, Лолита"), ("Давай сбежим (Искорки) (prod. by Barabanov)", "5УТРА")
    ]
    
    private let trackImages: [UIImage] = [
        UIImage(named: "Царица")!,
        UIImage(named: "Спонсор твоих проблем")!,
        UIImage(named: "Зима в сердце")!,
        UIImage(named: "Север")!,
        UIImage(named: "Давай сбежим")!
    ]
    
    private lazy var chartLabel: UILabel = {
        let label = UILabel()
        label.text = "Чарт"
        label.font = UIFont(name: "YandexSansText-Medium", size: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var seeMoreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Смотреть всё", for: .normal)
        return button
    }()
    
    private lazy var chartTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FullChartTableViewCell.self, forCellReuseIdentifier: FullChartTableViewCell.cellID)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.isUserInteractionEnabled = false
        
        addSubview(chartLabel)
        addSubview(chartTableView)
        addSubview(seeMoreButton)
        
        NSLayoutConstraint.activate([
            chartLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            chartTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            chartTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            chartTableView.heightAnchor.constraint(equalToConstant: 350),
            
            seeMoreButton.topAnchor.constraint(equalTo: chartTableView.bottomAnchor, constant: 5),
            seeMoreButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        ])
    }
}

extension ChartTableViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FullChartTableViewCell.cellID, for: indexPath) as! FullChartTableViewCell
        
        cell.positionInChartLabel.text = "\(Array(1...5)[indexPath.row])"
        cell.songAuthor.text = first5Tracks[indexPath.row].1
        cell.songName.text = first5Tracks[indexPath.row].0
        cell.songImage.image = trackImages[indexPath.row]
        
        switch indexPath.row {
        case 0:
            cell.isChangedPositionInChartImage.image = UIImage(named: "crown")
        case 1, 4:
            cell.isChangedPositionInChartImage.image = UIImage(systemName: "equal")
            cell.isChangedPositionInChartImage.tintColor = .lightGray
            
            if indexPath.row == 1 {
                cell.explicitImageView.isHidden = false
            }
        case 2:
            cell.isChangedPositionInChartImage.image = UIImage(systemName: "arrowtriangle.up.fill")
        case 3:
            cell.isChangedPositionInChartImage.image = UIImage(systemName: "arrowtriangle.down.fill")
            cell.isChangedPositionInChartImage.tintColor = .systemRed
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

