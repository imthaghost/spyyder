//
//  UIScrollView+extensions.swift
//  MobileClasswork
//
//  Created by Macbook Pro 15 on 1/23/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

//MARK: Notes:
/*
https://fizzbuzzer.com/understanding-the-contentoffset-and-contentinset-properties-of-the-uiscrollview-class/
 - contentOffset: CGPoint
    - “The point at which the origin of the content view is offset from the origin of the scroll view.”
    - In other words it defines the point in the content view that is visible at the top left of the scroll view bounds. We can use this property to scroll programmatically .
 
 - var contentInset: UIEdgeInsets
    - "The distance that the content view is inset from the enclosing scroll view."
    - In other words it is the distance that the content view is inset from the enclosing scroll view (padding). So, if you want to add more scrollable space at the bottom or at the top, you can use the property contentInset.top and contentInset.bottom, so you can add some extra space without changing the content size. It is important to note that through the contentInset we add more scrollable space. So an contentInset.top = 10 will add an extra space of 10 at the top. One way to think of it is "how much to shift the content down the scroll view when we're scrolled all the way to the top". When we scroll down this padding also scrolls along with the rest of the content.
*/


extension UIScrollView {

    var isAtTop: Bool {
        return contentOffset.y <= verticalOffsetForTop
    }

    var isAtBottom: Bool {
        return contentOffset.y >= verticalOffsetForBottom
    }

    var verticalOffsetForTop: CGFloat {
        let topInset = contentInset.top
        return -topInset
    }

    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset
    }
}
