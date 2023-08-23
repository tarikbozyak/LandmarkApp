//
//  DetailRouter.swift
//  LandmarkApp
//
//  Created by Ahmed Tarık Bozyak on 22.08.2023.
//

import Foundation
import UIKit

typealias DetailEntry = UIViewController & DetailViewProtocol

protocol DetailRouterProtocol {
    var entryPoint: DetailEntry? { get }
    static func prepareModul(with landmark: Landmark, delegate: LandmarkTableDelegate) -> DetailRouterProtocol
}

class DetailRouter: DetailRouterProtocol {
    var entryPoint: DetailEntry?
    
    static func prepareModul(with landmark: Landmark, delegate: LandmarkTableDelegate) -> DetailRouterProtocol {
        var router = DetailRouter()
        
        var view: DetailViewProtocol = DetailViewController(landmark, delegate: delegate)
        var interactor: DetailInteractorProtocol = DetailInteractor()
        var presenter: DetailPresenterProtocol = DetailPresenter()
        
        //view
        view.presenter = presenter
        
        //interactor
        interactor.presenter = presenter
        
        //presentor
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.entryPoint = view as? DetailEntry
        return router
    }
    
    
}
