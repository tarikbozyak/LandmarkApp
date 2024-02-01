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

protocol HomePresenterProtocol: AnyObject {
    var interactor: HomeInteractorProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    var view: HomeViewProtocol? { get set }
    func interactorDidFetchLandmarks(with result: Result<[Landmark], Error>)
    func didSelectLandmark(_ item: Landmark)
}

protocol LandmarkTableDelegate: AnyObject {
    func updateFavoriteCell(for landmarkId: Int, isFavorite: Bool)
}

class HomePresenter: HomePresenterProtocol, LandmarkTableDelegate {

    weak var interactor: HomeInteractorProtocol? {
        didSet {
            interactor?.getLandmarks()
        }
    }
    
    var router: HomeRouterProtocol?
    
    var view: HomeViewProtocol?
    
    func interactorDidFetchLandmarks(with result: Result<[Landmark], Error>) {
        switch result {
        case .success(let landmark):
            view?.update(with: landmark)
        case .failure(let error):
            view?.update(with: "Error occured : \(error.localizedDescription)")
        }
    }
    
    func didSelectLandmark(_ item: Landmark) {
        router?.navigate(with: item, rootViewController: view, delegate: self)
    }
    
    func updateFavoriteCell(for landmarkId: Int, isFavorite: Bool) {
        view?.updateCell(for: landmarkId, isFavorite: isFavorite)
    }
    
    
}
