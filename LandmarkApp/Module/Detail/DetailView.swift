//
//  DetailView.swift
//  LandmarkApp
//
//  Created by Ahmed Tarık Bozyak on 22.08.2023.
//

import Foundation
import UIKit

protocol DetailViewProtocol {
    var presenter: DetailPresenterProtocol? { get set }
}

class DetailViewController: UIViewController, DetailViewProtocol {
    var presenter: DetailPresenterProtocol?
    var user: User
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        addUserName()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        label.center = view.center
    }
    
    init(_ user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    func addUserName(){
        view.addSubview(label)
        label.text = user.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
