//
//  RoundedSearchTextField.swift
//  TheCockTail
//
//  Created by Jageloo Yadav on 23/02/22.
//

import Foundation
import UIKit

class RoundedSearchTextField: UITextField {
    private let height: CGFloat = 48.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        var filled = UIButton.Configuration.tinted()
        filled.buttonSize = .small
        filled.image = UIImage(systemName: "magnifyingglass")
        filled.imagePlacement = .trailing
        filled.imagePadding = 5
        filled.baseBackgroundColor = .clear
        let button = UIButton(configuration: filled, primaryAction: UIAction(handler: { [weak self] _ in
            self?.becomeFirstResponder()
        }))
        button.tintColor = .gray
        self.leftView = button
        self.placeholder = "Search"
        self.leftViewMode = .always
        self.backgroundColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        self.layer.cornerRadius = height / 2
        self.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


