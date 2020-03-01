//
//  QuizVC.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 3/1/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class QuizVC: UIViewController {
//MARK: Properties
    var pages: [UIView] = []
    var currentPage: Int = 0
    var numberOfPages: Int {
        get {
            return self.pages.count
        }
    }
    
//MARK: IBOutlets
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var continueButton: UIButton!
        
//MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
//MARK: Private Methods
    fileprivate func updateColors() {
        continueButton.isMainButton()
    }
    
    fileprivate func setupViews() {
        continueButton.setTitle("Next", for: .normal)
        mainStackView.alignment = .fill
        mainStackView.axis = .horizontal
        
        updateColors()
        setupPageViews()
    }
    
    fileprivate func setupPageViews() {
        let page1View = Page1View()
        let page2View = Page2View()
        let page3View = Page3View()
        let page4View = Page4View()
        let page5View = Page5View()
        let page6View = Page6View()
        let page7View = Page7View()
        pages.append(contentsOf: [page1View, page2View, page3View, page4View, page5View, page6View, page7View])
        for page in pages {
            page.translatesAutoresizingMaskIntoConstraints = false
            mainStackView.addArrangedSubview(page)
            NSLayoutConstraint.activate(
                page.pinToEdges(view: mainStackView)
            )
            page.widthAnchor.constraint(equalToConstant: self.view.frame.size.width).isActive = true
        }
    }
    
    fileprivate func setupNavigationBar() {
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
//MARK: Helpers
}

//MARK: Extensions
