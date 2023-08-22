//
//  HomePresenter.swift
//  LandmarkApp
//
//  Created by Ahmed Tarık Bozyak on 22.08.2023.
//

import Foundation

enum FetchError: Error {
    case failed
}

protocol HomePresenterProtocol {
    var interactor: HomeInteractorProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    var view: HomeViewProtocol? { get set }
    func interactorDidFetchUsers(with result: Result<[User], Error>)
}


class HomePresenter: HomePresenterProtocol {
    var interactor: HomeInteractorProtocol? {
        didSet {
            interactor?.getUsers()
        }
    }
    
    var router: HomeRouterProtocol?
    
    var view: HomeViewProtocol?
    
    func interactorDidFetchUsers(with result: Result<[User], Error>) {
        switch result {
        case .success(let user):
            view?.update(with: user)
        case .failure(let error):
            view?.update(with: "Error occured : \(error.localizedDescription)")
        }
    }
    
    
}
