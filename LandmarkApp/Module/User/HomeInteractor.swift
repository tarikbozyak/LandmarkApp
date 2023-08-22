//
//  HomeInteractor.swift
//  LandmarkApp
//
//  Created by Ahmed Tarık Bozyak on 22.08.2023.
//

import Foundation

protocol HomeInteractorProtocol {
    var presenter: HomePresenterProtocol? { get set }
    func getLandmarks()
}

class HomeInteractor: HomeInteractorProtocol {
    var presenter: HomePresenterProtocol?
    
    func getLandmarks() {
        let data: Data
        let filename = "landmarkData.json"

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            presenter?.interactorDidFetchLandmarks(with: .failure(FetchError.failed))
            return
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            presenter?.interactorDidFetchLandmarks(with: .failure(error))
            return
        }

        do {
            let landmark = try JSONDecoder().decode([Landmark].self, from: data)
            presenter?.interactorDidFetchLandmarks(with: .success(landmark))
        } catch {
            presenter?.interactorDidFetchLandmarks(with: .failure(error))
        }
    }
    
    
}
