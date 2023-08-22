//
//  UserPresenter.swift
//  LandmarkApp
//
//  Created by Ahmed Tarık Bozyak on 22.08.2023.
//

import Foundation

enum FetchError: Error {
    case failed
}

protocol UserPresenterProtocol {
    var interactor: UserInteractorProtocol? { get set }
    var router: UserRouterProtocol? { get set }
    var view: UserViewProtocol? { get set }
    func interactorDidFetchUsers(with result: Result<[User], Error>)
}


class UserPresenter: UserPresenterProtocol {
    var interactor: UserInteractorProtocol? {
        didSet {
            interactor?.getUsers()
        }
    }
    
    var router: UserRouterProtocol?
    
    var view: UserViewProtocol?
    
    func interactorDidFetchUsers(with result: Result<[User], Error>) {
        switch result {
        case .success(let user):
            view?.update(with: user)
        case .failure(let error):
            view?.update(with: "Error occured : \(error.localizedDescription)")
        }
    }
    
    
}
