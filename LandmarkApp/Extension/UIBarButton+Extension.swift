//
//  UIBarButton+Extension.swift
//  LandmarkApp
//
//  Created by Ahmed Tarık Bozyak on 22.08.2023.
//

import UIKit

enum BarButtonType {
    case back
    case favorite
    
    var image: UIImage? {
        switch self {
        case .back:
            return UIImage(systemName: "chevron.left")
        case .favorite:
            return UIImage(systemName: "heart")
        }
    }
    
    var selectedImage: UIImage? {
        switch self {
        case .back:
            return image
        case .favorite:
            return UIImage(systemName: "heart.fill")
        }
    }
    
}

extension UIBarButtonItem {
    static func customBarButton(type: BarButtonType, isSelected: Bool = false, target: Any?, action: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        button.tintColor = .white
        button.setImage(type.image, for: .normal)
        button.setImage(type.selectedImage, for: .selected)
        button.isSelected = isSelected
        button.addTarget(target, action: action, for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.layer.cornerRadius = 20
       
        //shadow
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 2
        
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }
}

