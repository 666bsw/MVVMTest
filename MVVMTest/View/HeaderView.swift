//
//  HeaderView.swift
//  MVVMTest
//
//  Created by Bezdenezhnykh Sergey on 05.06.2021.
//

import UIKit

protocol HeaderViewProtocol {
    var buttonLoad: UIButton { get set }
}

class HeaderView: UIView, HeaderViewProtocol  {
    
    lazy var buttonLoad: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Load", for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.primary.cgColor
        button.setTitleColor(UIColor.primary, for: .normal)
        button.tintColor = UIColor.primary
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = false
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 4
        return button
    }()
    
    private lazy var labelTitle: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .label
        label.text = "load json:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var border: UIView = {
        let border = UIView()
        border.backgroundColor = .primary
        border.translatesAutoresizingMaskIntoConstraints = false
        return border
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        self.addSubview(buttonLoad)
        self.addSubview(border)
        self.addSubview(labelTitle)
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        
    func setupConstraints() {
        labelTitle.heightAnchor.constraint(equalToConstant: 29).isActive = true
        labelTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        labelTitle.trailingAnchor.constraint(equalTo: buttonLoad.leadingAnchor).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        
        buttonLoad.heightAnchor.constraint(equalToConstant: 29).isActive = true
        buttonLoad.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        buttonLoad.widthAnchor.constraint(equalToConstant: 63).isActive = true
        buttonLoad.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        
        border.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        border.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        border.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        border.heightAnchor.constraint(equalToConstant: 1).isActive = true
    
    }
}
