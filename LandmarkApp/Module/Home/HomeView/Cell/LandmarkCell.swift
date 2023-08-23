//
//  LandmarkCell.swift
//  LandmarkApp
//
//  Created by Ahmed Tarık Bozyak on 23.08.2023.
//

import UIKit

class LandmarkCell: UITableViewCell {
    
    static let reuseIdentifier = "LandmarkCell_Id"
    
    lazy var landmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 2
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.isUserInteractionEnabled = true
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("HeaderView init(coder:) has not been implemented")
    }
    
    @objc func didButtonTapped(){
        favoriteButton.isSelected.toggle()
    }
    
    func setUp(){
        contentView.isUserInteractionEnabled = true
        selectionStyle = .none
        addSubview(landmarkImageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(favoriteButton)
    }

    func configure(with item: Landmark) {
        titleLabel.text = item.name
        subTitleLabel.text = item.park
        landmarkImageView.image = item.image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            //landmarkImageView constraints
            landmarkImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            landmarkImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            landmarkImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            landmarkImageView.widthAnchor.constraint(equalTo: landmarkImageView.heightAnchor, multiplier: 1),
            
            //titleLabel constraints
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: landmarkImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -16),
            
            //subTitleLabel constraints
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subTitleLabel.leadingAnchor.constraint(equalTo: landmarkImageView.trailingAnchor, constant: 16),
            subTitleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -24),
            
            //favoriteButton constraints
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            favoriteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
            
        ])
        
        landmarkImageView.layer.cornerRadius = landmarkImageView.frame.size.height / 10
        
    }

}
