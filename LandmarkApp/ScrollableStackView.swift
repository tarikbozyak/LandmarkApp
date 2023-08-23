//
//  ScrollableStackView.swift
//  LandmarkApp
//
//  Created by Ahmed Tarık Bozyak on 22.08.2023.
//

import UIKit

class ScrollableStackView: UIView {
    
    private lazy var scrollView = UIScrollView()
    private lazy var stackView = UIStackView()
    
    let landmark: Landmark
    
    init(frame: CGRect = .zero, landmark: Landmark) {
        self.landmark = landmark
        super.init(frame: frame)
        setupView()
        addTitleSection()
        addDiverLine()
        addDescriptionSection()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented..")
    }
    
    private func setupView() {
        
        backgroundColor = .white
        
        // Set up the scroll view
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // Set up the stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.layoutMargins = UIEdgeInsets(top: 85, left: 20, bottom: 20, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func addTitleSection() {
        let titleLabel = UILabel()
        titleLabel.font = .preferredFont(forTextStyle: .title1)
        titleLabel.text = landmark.name
        
        let subtitleStackView = UIStackView()
        subtitleStackView.axis = .horizontal
        subtitleStackView.distribution = .equalCentering
        subtitleStackView.spacing = 20
        
        let subtitlePark = UILabel()
        subtitlePark.numberOfLines = 2
        subtitlePark.font = .preferredFont(forTextStyle: .subheadline)
        subtitlePark.textColor = .secondaryLabel
        subtitlePark.text = landmark.park
        
        let subtitleState = UILabel()
        subtitleState.font = .preferredFont(forTextStyle: .subheadline)
        subtitleState.textColor = .secondaryLabel
        subtitleState.text = landmark.state
        subtitleState.setContentHuggingPriority(.required, for: .horizontal)
        subtitleState.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        subtitleStackView.addArrangedSubview(subtitlePark)
        subtitleStackView.addArrangedSubview(subtitleState)
        
        let titleStackView = UIStackView(arrangedSubviews: [titleLabel,subtitleStackView])
        titleStackView.axis = .vertical
        titleStackView.spacing = 2
        
        addArrangedSubview(titleStackView)
    }
    
    func addDiverLine(){
        let divider = UIView()
        divider.backgroundColor = .gray
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        addArrangedSubview(divider)
    }
    
    func addDescriptionSection(){
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = landmark.description
        
        addArrangedSubview(descriptionLabel)
    }


    func addArrangedSubview(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }
}

