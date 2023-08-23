//
//  DetailPresenter.swift
//  LandmarkApp
//
//  Created by Ahmed Tarık Bozyak on 22.08.2023.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    var view: DetailViewProtocol? { get set }
    var interactor: DetailInteractorProtocol? { get set }
    var router: DetailRouterProtocol? { get set }
}

class DetailPresenter: DetailPresenterProtocol {
    var view: DetailViewProtocol?
    
    weak var interactor: DetailInteractorProtocol?
    
    var router: DetailRouterProtocol?
    
    
}
