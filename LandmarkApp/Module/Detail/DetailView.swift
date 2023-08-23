//
//  DetailView.swift
//  LandmarkApp
//
//  Created by Ahmed Tarık Bozyak on 22.08.2023.
//

import Foundation
import UIKit
import MapKit

protocol DetailViewProtocol {
    var presenter: DetailPresenterProtocol? { get set }
}

class DetailViewController: UIViewController, DetailViewProtocol {
    var presenter: DetailPresenterProtocol?
    var landmark: Landmark
    
    var isFavorite: Bool {
        return false
    }
    
    lazy var mapView = MKMapView()
    
    lazy var stackView = ScrollableStackView(landmark: landmark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavbar()
        view.backgroundColor = .white
        addMapView()
        setMapRegion()
        addStackView()
    }
    
    func addStackView(){
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -40),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        stackView.layer.cornerRadius = 24
        stackView.clipsToBounds = true
    }
    
    func configureNavbar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.hidesBackButton = true
        
        // leftBarButtonItem
        navigationItem.leftBarButtonItem = .customBarButton(
            type: .back,
            target: self,
            action: #selector(backButtonTapped)
        )
        
        // rightBarButtonItem
        navigationItem.rightBarButtonItem = .customBarButton(
            type: .favorite,
            isSelected: isFavorite,
            target: self,
            action: #selector(favoriteButtonTapped)
        )
    }
    
    @objc func backButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func favoriteButtonTapped(sender: Any){
        guard let button = sender as? UIButton else { return }
        button.isSelected.toggle()
    }
    
    init(_ landmark: Landmark) {
        self.landmark = landmark
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addMapView(){
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 400)
        ])
        
    }
    
    func setMapRegion(){
        DispatchQueue.main.async { [weak self] in
            guard let coordinate = self?.landmark.locationCoordinate else { return }
            let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            let coordinateRegion = MKCoordinateRegion(center: coordinate, span: span)
            self?.mapView.setRegion(coordinateRegion, animated: true)
        }
    }
    
}
