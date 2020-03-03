//
//  QuizVC.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 3/1/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class QuizVC: UIViewController {
//MARK: Non-views Properties
    var pages: [UIView] = []
    var currentPage: Int { //tell which page is currently being viewed based on the contentOffset of the UIScrollView
        get {
            let page = Int(scrollView.contentOffset.x / view.bounds.size.width)
            return page
        }
    }
    var numberOfPages: Int {
        get {
            return self.pages.count
        }
    }
    
//MARK: Views Properties
    let scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    let contentView: UIView = {
        let view: UIView = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    let containerStackView: UIStackView = {
        let stackView: UIStackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
        
//MARK: App Life Cycle
    override func loadView() {
        super.loadView()
        self.navigationController?.isNavigationBarHidden = true //hide nav
        setupScrollView()
//        setupPageControl()
        setupPageViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        pageControl.numberOfPages = self.numberOfPages
//        pageControl.currentPage = currentPage
    }
    
//MARK: Private methods
    fileprivate func setupScrollView() { //setup scrollView and contentView
        scrollView.delegate = self //optional
        view.insertSubview(scrollView, at: 0)
        scrollView.insertSubview(contentView, at: 1)
        NSLayoutConstraint.activate(
            scrollView.frameLayoutGuide.pinToEdgesEqually(view: self.view) //pin scrollView's frameLayoutGuide to the edges of self.view
        )
        
        scrollView.addSubview(containerStackView)
        containerStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        containerStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        containerStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        
//        NSLayoutConstraint.activate(
//            scrollView.contentLayoutGuide.pinToEdgesEqually(view: contentView) //pin scrollView's contentLayoutGuide to edges of contentView
//        )
        scrollView.contentLayoutGuide.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor).isActive = true //NOTE: you can get width and height from scrollView's frameLayoutGuide, and you can pin top, left, right, and bottom to scrollView's contentLayoutGuide //refer to Adriana's ScrollView Recipe
    }
    
//    fileprivate func setupPageViews() {
//        page1View = OnboardingPageView(color: .orange, pageImage: kMIGRAINEIMAGE.tint(with: .white), description: "Welcome to \(kAPPNAME)")
//        page2View = OnboardingPageView(color: .systemPink, pageImage: kPILLIMAGE.tint(with: .white), description: "Subscribe to your daily, weekly, or monthly medications and more")
//        page3View = OnboardingPageView(color: .purple, pageImage: kMIGRAINEIMAGE.tint(with: .white), description: "Let's get started", isLastPage: true)
//        pages.append(contentsOf: [page1View, page2View, page3View])
//        applyPageConstraints()
//    }
    
    fileprivate func setupPageViews() {
        let page1View = Page1View()
        let page2View = Page2View()
        let page3View = Page3View()
        let page4View = Page4View()
        let page5View = Page5View()
        let page6View = Page6View()
        let page7View = Page7View()
//        pages = [page1View, page2View, page3View]
        pages = [page1View, page2View, page3View, page4View, page5View, page6View, page7View]
        for page in pages {
            containerStackView.addArrangedSubview(page)
            page.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        }
//        for page in pages {
//            page.translatesAutoresizingMaskIntoConstraints = false
////            mainStackView.addArrangedSubview(page)
//            self.view.addSubview(page)
//            NSLayoutConstraint.activate(
//                page.pinToEdges(view: self.view)
////                page.pinToEdges(view: mainStackView)
//            )
//            page.widthAnchor.constraint(equalToConstant: self.view.frame.size.width).isActive = true
//        }
//        let pinkView = UIView(frame: CGRect(x: 100, y: 40, width: 100, height: 40))
//        pinkView.backgroundColor = .systemPink
//        applyPageConstraints()
    }
    
    fileprivate func applyPageConstraints() { //apply constraints to all pages
        self.pages.enumerated().forEach { tuple in //this tuple only have offset and element
            let index = tuple.offset //index of page
            let page = tuple.element //page
            contentView.addSubview(page) //add page to contentView
            NSLayoutConstraint.activate([ //set page's top, bottom and width
                page.topAnchor.constraint(equalTo: scrollView.topAnchor),
                page.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                page.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
            if index == 0 { //if first page, then set page's leftAnchor to contentView's leftAnchor
                NSLayoutConstraint.activate([
                    page.leftAnchor.constraint(equalTo: contentView.leftAnchor)
                ])
            } else { //else set current page's leftAnchor to the previous page's rightAnchor
                NSLayoutConstraint.activate([
                    page.leftAnchor.constraint(equalTo: pages[index - 1].rightAnchor)
                ])
            }
            if index == pages.count - 1 { //if last page, then set that page's rightAnchor to contentView's rightAnchor
                NSLayoutConstraint.activate([
                    page.rightAnchor.constraint(equalTo: contentView.rightAnchor)
                ])
                //                page.continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
            }
        }
    }
    
//MARK: Helpers
//    @objc func continueButtonTapped() {
//        let vc: LoginVC = LoginVC()
//        navigationController?.pushViewController(vc, animated: true)
////        self.navigationController?.initRootVC(vc: vc, fromRight: true)
//    }
}

extension QuizVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        pageControl.currentPage = currentPage
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        pageControl.currentPage = currentPage
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       if scrollView.contentOffset.y > 0 || scrollView.contentOffset.y < 0 {
          scrollView.contentOffset.y = 0 //disable vertical scrolling
       }
    }
}

//MARK: Helper Methods
extension QuizVC {
    fileprivate func nextPage() {
        if currentPage + 1 < self.numberOfPages {
            navigateToPage(page: currentPage + 1)
        }
    }
    
    fileprivate func previousPage() {
        if currentPage > 0 {
            navigateToPage(page: currentPage - 1)
        }
    }
    
    @objc func pageControlDidTouch() { //method to change page when user interacts with pageControl {
//        navigateToPage(page: pageControl.currentPage)
    }
    
    private func updateUI() {
//        pageControl.currentPage = currentPage
    }
    
    private func navigateToPage(page: Int) {
        if page < self.numberOfPages {
            var frame = scrollView.frame
            frame.origin.x = CGFloat(page) * frame.size.width
            scrollView.scrollRectToVisible(frame, animated: true)
        }
    }
}

















//fileprivate func setupPageViews() {
////        scrollView.
//        let page1View = Page1View()
//        let page2View = Page2View()
//        let page3View = Page3View()
//        let page4View = Page4View()
//        let page5View = Page5View()
//        let page6View = Page6View()
//        let page7View = Page7View()
////        pages = [page1View, page2View, page3View]
//        pages = [page1View, page2View, page3View, page4View, page5View, page6View, page7View]
////        for page in pages {
////            page.translatesAutoresizingMaskIntoConstraints = false
//////            mainStackView.addArrangedSubview(page)
////            self.view.addSubview(page)
////            NSLayoutConstraint.activate(
////                page.pinToEdges(view: self.view)
//////                page.pinToEdges(view: mainStackView)
////            )
////            page.widthAnchor.constraint(equalToConstant: self.view.frame.size.width).isActive = true
////        }
////        let pinkView = UIView(frame: CGRect(x: 100, y: 40, width: 100, height: 40))
////        pinkView.backgroundColor = .systemPink
//        applyPageConstraints()
//    }
