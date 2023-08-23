//
//  ScrollableStackView.swift
//  LandmarkApp
//
//  Created by Ahmed Tarık Bozyak on 22.08.2023.
//

import UIKit

class ScrollableStackView: UIView {
    
    private lazy var scrollView = UIScrollView()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.layoutMargins = UIEdgeInsets(top: 85, left: 20, bottom: 20, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    let landmark: Landmark
    
    init(frame: CGRect = .zero, landmark: Landmark) {
        self.landmark = landmark
        super.init(frame: frame)
        setupView()
        addTitleSection()
        addDivederLine()
        addDescriptionSection()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented..")
    }
    
    private func setupView() {
        backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            // scrollView constraints
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // stackView constraints
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func addTitleSection() {
        
        // titleLabel
        let titleLabel = UILabel()
        titleLabel.font = .preferredFont(forTextStyle: .title1)
        titleLabel.text = landmark.name
        
        // subtitleParkLabel
        let subtitleParkLabel = UILabel()
        subtitleParkLabel.numberOfLines = 2
        subtitleParkLabel.font = .preferredFont(forTextStyle: .subheadline)
        subtitleParkLabel.textColor = .secondaryLabel
        subtitleParkLabel.text = landmark.park
        
        // subtitleStateLabel
        let subtitleStateLabel = UILabel()
        subtitleStateLabel.font = .preferredFont(forTextStyle: .subheadline)
        subtitleStateLabel.textColor = .secondaryLabel
        subtitleStateLabel.text = landmark.state
        subtitleStateLabel.setContentHuggingPriority(.required, for: .horizontal)
        subtitleStateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        // subtitleStackView
        let subtitleStackView = UIStackView()
        subtitleStackView.axis = .horizontal
        subtitleStackView.distribution = .equalCentering
        subtitleStackView.spacing = 20
        subtitleStackView.addArrangedSubview(subtitleParkLabel)
        subtitleStackView.addArrangedSubview(subtitleStateLabel)
        
        // titleStackView
        let titleStackView = UIStackView(arrangedSubviews: [titleLabel,subtitleStackView])
        titleStackView.axis = .vertical
        titleStackView.spacing = 2
        addArrangedSubview(titleStackView)
    }
    
    func addDivederLine(){
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

