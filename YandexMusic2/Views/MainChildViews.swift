//
//  MainChildViews.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 30.10.2023.
//

import UIKit

class MainChildViews: MiniPlayerView {
        
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectForYouCell.self, forCellReuseIdentifier: CollectForYouCell.cellID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.isUserInteractionEnabled = false
        return tableView
    }()
    
    lazy var handleArea: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var controlImageOnHandleArea: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "chevron.compact.up")
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
        backgroundColor = .clear
        insertSubview(tableView, at: 0)
        insertSubview(handleArea, at: 0)
        handleArea.addSubview(controlImageOnHandleArea)
        //insertSubview(redView, at: 0)
        //addSubview(tableView)
        configure()
    }
    
    var handleAreaHeight = NSLayoutConstraint()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        NSLayoutConstraint.activate([
            
//            handleArea.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -frame.height / 2),
//            handleArea.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//            handleArea.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
//            handleArea.heightAnchor.constraint(equalToConstant: 200),
            
            handleArea.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            handleArea.trailingAnchor.constraint(equalTo: trailingAnchor),
            handleArea.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -20),
            //handleArea.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            //handleArea.heightAnchor.constraint(equalToConstant: 100),
            //handleArea.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: 10),
            
            controlImageOnHandleArea.centerXAnchor.constraint(equalTo: centerXAnchor),
            //controlImageOnHandleArea.centerYAnchor.constraint(equalTo: handleArea.centerYAnchor),
            controlImageOnHandleArea.bottomAnchor.constraint(equalTo: handleArea.bottomAnchor),
            //controlImageOnHandleArea.topAnchor.constraint(equalTo: handleArea.topAnchor, constant: 10),
            controlImageOnHandleArea.heightAnchor.constraint(equalToConstant: 30),
            controlImageOnHandleArea.widthAnchor.constraint(equalToConstant: 70),
            
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            //tableView.heightAnchor.constraint(equalToConstant: frame.height),
            tableView.topAnchor.constraint(equalTo: handleArea.bottomAnchor, constant: 0)
        ])
        
        handleAreaHeight = handleArea.heightAnchor.constraint(equalToConstant: 100)
        handleAreaHeight.isActive = true
    }
    
}
