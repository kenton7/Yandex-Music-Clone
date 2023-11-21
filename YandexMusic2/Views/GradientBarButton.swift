//
//  GradientBarButton.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 09.11.2023.
//

import UIKit

class RoundImageBarButtonItem: UIBarButtonItem {

    convenience init(image: UIImage?, target: Any?, action: Selector?) {
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.contentMode = .center
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30) // Задайте размеры под ваше изображение
        button.layer.cornerRadius = button.frame.width / 2
        button.clipsToBounds = true

        // Создаем градиентную рамку
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = button.bounds
        gradientLayer.cornerRadius = button.layer.cornerRadius
        gradientLayer.borderWidth = 2.0 // Толщина рамки

        // Задаем цвета градиента
        gradientLayer.colors = [UIColor.purple.cgColor, UIColor.systemBlue.cgColor]

        // Добавляем градиентную рамку к фону кнопки
        button.layer.insertSublayer(gradientLayer, at: 0)

        // Создаем UIBarButtonItem с UIButton в качестве кастомного представления
        self.init(customView: button)

        // Добавляем действие
        self.target = target as AnyObject?
        self.action = action
    }
}









