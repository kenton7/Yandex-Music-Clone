//
//  Extensions.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 13.10.2023.
//

import Foundation
import UIKit

extension UIView {
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(blurEffectView, at: 0)
    }

    func applyGradient(colours: [UIColor], cornerRadius: CGFloat?, startPoint: CGPoint, endPoint: CGPoint)  {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        if let cornerRadius = cornerRadius {
            gradient.cornerRadius = cornerRadius
        }
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.colors = colours.map { $0.cgColor }
        self.layer.insertSublayer(gradient, at: 0)
      }
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

//MARK: - ScrollView
extension UIScrollView {

    var isAtTop: Bool {
        return contentOffset.y <= verticalOffsetForTop
    }

    var isAtBottom: Bool {
        return contentOffset.y >= verticalOffsetForBottom
    }

    var verticalOffsetForTop: CGFloat {
        let topInset = contentInset.top
        return -topInset
    }

    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset
    }
}

//MARK: - UITableView
extension UITableView {
     public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
}

//MARK: - UIColor
extension UIColor {
    //Функция для получения доминирующего цвета картинки трека
    static func dominantColor(for image: UIImage) -> UIColor? {
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


