//
//  HomeEntity.swift
//  LandmarkApp
//
//  Created by Ahmed Tarık Bozyak on 22.08.2023.
//

import Foundation
import UIKit
import CoreLocation

// MARK: - Landmark
struct Landmark: Hashable, Codable ,Identifiable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    var isFavorite: Bool
    var isFeatured: Bool
    var category: Category
    
    private var imageName: String
    
    var image: UIImage? {
        UIImage(named: imageName)
    }
    
    var featureImage: UIImage?{
        isFeatured ? UIImage(named: imageName+"_feature") : nil
    }

    private var coordinates: Coordinates
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }

}

// MARK: - Category
enum Category: String, CaseIterable, Codable{
    case lakes = "Lakes"
    case rivers = "Rivers"
    case mountains = "Mountains"
}

// MARK: - Coordinates
struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}
