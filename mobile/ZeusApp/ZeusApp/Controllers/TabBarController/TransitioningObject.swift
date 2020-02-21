//
//  TransitioningObject.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 2/20/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class TransitioningObject: NSObject, UIViewControllerAnimatedTransitioning { //UIViewControllerAnimatedTransitioning = A set of methods for implementing the animations for a custom view controller transition.

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromView: UIView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView: UIView = transitionContext.view(forKey: UITransitionContextViewKey.to)!

        transitionContext.containerView.addSubview(fromView)
        transitionContext.containerView.addSubview(toView)

        UIView.transition(from: fromView, to: toView, duration: transitionDuration(using: transitionContext), options: UIView.AnimationOptions.transitionFlipFromLeft) { finished in
            transitionContext.completeTransition(true)
        }
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
}
