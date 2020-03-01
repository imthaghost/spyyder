//
//  Page3View.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 3/1/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class Page3View: UIView {
    
    @IBOutlet var contentView: UIView!
    
    required init() { //with initializer
        super.init(frame: .zero)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("Page3View", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        setup()
    }
    
    fileprivate func setup() {
        self.contentView.backgroundColor = .yellow
    }
}
