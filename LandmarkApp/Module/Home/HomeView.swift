//
//  HomeView.swift
//  LandmarkApp
//
//  Created by Ahmed Tarık Bozyak on 22.08.2023.
//

import Foundation
import UIKit

protocol HomeViewProtocol {
    var presenter: HomePresenterProtocol? { get set }
    
    func update(with landmark: [Landmark])
    func update(with error: String)
}

final class HomeViewController: UIViewController, HomeViewProtocol, UITableViewDelegate, UITableViewDataSource {

    var presenter: HomePresenterProtocol?
    
    var landmarks: [Landmark] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(LandmarkCell.self, forCellReuseIdentifier: LandmarkCell.reuseIdentifier)
        tableView.isHidden = true
        return tableView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 300)
        label.center = view.center
    }
    
    func update(with landmarks: [Landmark]) {
        DispatchQueue.main.async { [weak self] in
            self?.landmarks = landmarks
            self?.tableView.reloadData()
            self?.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.landmarks = []
            self?.label.text = "Error occured.. \(error)"
            self?.label.isHidden = false
            self?.tableView.isHidden = true
        }
    }
    
    //Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: LandmarkCell = tableView.dequeueReusableCell(withIdentifier: LandmarkCell.reuseIdentifier, for: indexPath) as? LandmarkCell else {
            return UITableViewCell()
        }
        cell.configure(with: landmarks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.router?.navigate(with: landmarks[indexPath.row], rootViewController: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    

    
}

extension HomeViewController: LandmarkTableDelegate {
    func updateFavoriteCell(for landmarkId: Int, isFavorite: Bool) {
        guard let rowIndex = landmarks.firstIndex(where: {$0.id == landmarkId}) else { return }
        let indexPath = IndexPath(row: rowIndex, section: 0)
        guard let cell = tableView.cellForRow(at: indexPath) as? LandmarkCell else { return }
        cell.favoriteButton.isSelected = isFavorite
    }
}

protocol LandmarkTableDelegate {
    func updateFavoriteCell(for landmarkId: Int, isFavorite: Bool)
}
