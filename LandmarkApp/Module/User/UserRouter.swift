//
//  UserRouter.swift
//  LandmarkApp
//
//  Created by Ahmed Tarık Bozyak on 22.08.2023.
//

import Foundation
import UIKit

typealias EntryPoint = UserViewProtocol & UIViewController

protocol UserRouterProtocol {
    var entry: EntryPoint? { get }
    static func start() -> UserRouterProtocol
    func navigate(with user: User, rootViewController: UIViewController)
}

class UserRouter: UserRouterProtocol {
    
    var entry: EntryPoint?
    
    static func start() -> UserRouterProtocol {
        let router = UserRouter()
        
        // Assign VIP
        var view: UserViewProtocol = UserViewController()
        var interactor: UserInteractorProtocol = UserInteractor()
        var presenter: UserPresenterProtocol = UserPresenter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        
        router.entry = view as? EntryPoint
        
        return router
        
    }
    
    func navigate(with user: User, rootViewController: UIViewController) {
        let router = DetailRouter.prepareModul(with: user)
        guard let detailVC = router.entryPoint else { return }
        rootViewController.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}
