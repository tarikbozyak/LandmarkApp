//
//  HomeRouter.swift
//  LandmarkApp
//
//  Created by Ahmed Tarık Bozyak on 22.08.2023.
//

import Foundation
import UIKit

typealias EntryPoint = HomeViewProtocol & UIViewController
typealias LandmarkList = UIViewController & LandmarkTableDelegate

protocol HomeRouterProtocol {
    var entry: EntryPoint? { get }
    static func start() -> HomeRouterProtocol
    func navigate(with landmark: Landmark, rootViewController: UIViewController?, delegate: LandmarkTableDelegate)
}

class HomeRouter: HomeRouterProtocol {
    
    var entry: EntryPoint?
    
    static func start() -> HomeRouterProtocol {
        let router = HomeRouter()
        
        // Assign VIP
        var view: HomeViewProtocol = HomeViewController()
        var interactor: HomeInteractorProtocol = HomeInteractor()
        var presenter: HomePresenterProtocol = HomePresenter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
        
    }
    
    func navigate(with landmark: Landmark, rootViewController: UIViewController?, delegate: LandmarkTableDelegate) {
        let router = DetailRouter.prepareModul(with: landmark, delegate: delegate)
        guard let detailVC = router.entryPoint else { return }
        rootViewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}
