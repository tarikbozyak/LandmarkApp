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
    var user: User
    
    var isFavorite: Bool {
        return false
    }
    
    lazy var mapView = MKMapView()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavbar()
        view.backgroundColor = .white
        addMapView()
        setMapRegion()
    }
    
    func configureNavbar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.hidesBackButton = true
        
        //back button
        let backButton = UIBarButtonItem.customBarButton(type: .back, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
        //favorite button
        let favoriteButton = UIBarButtonItem.customBarButton(type: .favorite ,target: self, action: #selector(favoriteButtonTapped(sender:)))
        navigationItem.rightBarButtonItem = favoriteButton
        
        if let favButton = favoriteButton.customView as? UIButton {
            favButton.isSelected = isFavorite
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        label.center = view.center
    }
    
    @objc func backButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func favoriteButtonTapped(sender: Any){
        guard let button = sender as? UIButton else { return }
        button.isSelected.toggle()
    }
    
    init(_ user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    func addUserName(){
        view.addSubview(label)
        label.text = user.name
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
            guard let latitude = self?.user.address?.geo?.latitude, let longitude = self?.user.address?.geo?.longitude else { return }
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            let coordinateRegion = MKCoordinateRegion(center: coordinate, span: span)
            self?.mapView.setRegion(coordinateRegion, animated: true)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
