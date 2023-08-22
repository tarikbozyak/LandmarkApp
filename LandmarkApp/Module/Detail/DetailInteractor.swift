//
//  DetailInteractor.swift
//  LandmarkApp
//
//  Created by Ahmed Tarık Bozyak on 22.08.2023.
//

import Foundation

protocol DetailInteractorProtocol {
    var presenter: DetailPresenterProtocol? { get set }
}

class DetailInteractor: DetailInteractorProtocol {
    var presenter: DetailPresenterProtocol?
    
    
}
