//
//  ItemDetailViewController.swift
//  TheCockTail
//
//  Created by Jageloo Yadav on 25/02/22.
//

import Foundation
import UIKit

class ItemDetailViewController: UIViewController {
    public let scrollingContentView = UIView()
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
    }
    
    private func setupScrollView() {
        let wrapperView = UIView()
        let scrollView = UIScrollView()
        wrapperView.backgroundColor = .clear
        self.view.addSubview(wrapperView)
        wrapperView.anchorToSuperView(topAnchor: view.safeAreaLayoutGuide.topAnchor, bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor)
        scrollView.backgroundColor = .clear
        wrapperView.addSubview(scrollView)
        scrollView.anchorToSuperView()
        scrollingContentView.backgroundColor = .clear
        scrollView.addSubview(scrollingContentView)
        scrollingContentView.anchorToSuperView()
        scrollingContentView.widthAnchor.constraint(equalTo: wrapperView.widthAnchor).isActive = true
        scrollingContentView.heightAnchor.constraint(greaterThanOrEqualTo: wrapperView.heightAnchor).isActive = true
    }
}
