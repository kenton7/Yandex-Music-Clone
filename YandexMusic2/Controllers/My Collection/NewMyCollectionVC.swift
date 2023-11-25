//
//  NewMyCollectionVC.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 25.11.2023.
//

import UIKit

final class NewMyCollectionVC: UIViewController {
    
    private let newMyCollectionViews = NewMyCollectionViews()
    
    override func loadView() {
        super.loadView()
        view = newMyCollectionViews
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Коллекция"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(searchButtonPressed))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        navigationItem.setLeftBarButtonItems([
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: #selector(profileButtonPressed)),
        ], animated: true)
        navigationItem.leftBarButtonItems?.forEach { $0.tintColor = .white }
        
        newMyCollectionViews.tableView.delegate = self
        newMyCollectionViews.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.layoutSubviews()
    }
    
    @objc private func searchButtonPressed() {
        print("pressed")
    }
    
    @objc private func profileButtonPressed() {
        print("Pressed")
    }

}

extension NewMyCollectionVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = MyCollectionWaveTableViewCell(style: .default, reuseIdentifier: MyCollectionWaveTableViewCell.cellID)
            return cell
        case 1:
            let cell = ILikeTableViewCell(style: .default, reuseIdentifier: ILikeTableViewCell.cellID)
            return cell
        case 2:
            let cell = MoreInYourCollectionTableViewCell(style: .default, reuseIdentifier: MoreInYourCollectionTableViewCell.cellID)
            return cell
        case 3:
            let cell = FavouriteArtistsTableViewCell(style: .default, reuseIdentifier: FavouriteArtistsTableViewCell.cellID)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 65
        case 1:
            return 250
        case 2:
            return 120
        case 3:
            return 130
        default:
            return UITableView.automaticDimension
        }
    }
    
    
}
