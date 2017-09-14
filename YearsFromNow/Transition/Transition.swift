//
//  FadeTransitionAnimation.swift
//  TransitionTreasury
//
//  Created by DianQK on 12/22/15.
//  Copyright © 2016 TransitionTreasury. All rights reserved.
//
import UIKit

public enum Transition: TransitionAnimationable {
    case push
    case present
    case scanbot(present : UIPanGestureRecognizer? ,dismisTransiltion :UIPanGestureRecognizer?)
    
    public func transitionAnimation() -> TRViewControllerAnimatedTransitioning {
        switch self {
        case .push:
            return FadeTransitionAnimation()
        case .present:
            return FadeTransitionAnimation(status: .present)
        case let .scanbot(presentGesture, dismissGesture) :
            return ScanbotTransitionAnimation(presentGesture :presentGesture, dismissGesture: dismissGesture);
        }
    }
}


open class FadeTransitionAnimation: NSObject, TRViewControllerAnimatedTransitioning, TransitionInteractiveable {
    
    open var transitionStatus: TransitionStatus

    open var  presentTransiltionGestureRecognizer: UIPanGestureRecognizer?
    open var  dismisTransiltionGestureRecognizer: UIPanGestureRecognizer?
    
    open var transitionContext: UIViewControllerContextTransitioning?
    
    open var percentTransition: UIPercentDrivenInteractiveTransition?
    
    open var completion: (() -> Void)?

    open var cancelPop: Bool = false

    open var interacting: Bool = false
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    public init(status: TransitionStatus = .push) {
        transitionStatus = status
        super.init()
    }
    public init(presentTransiltion: UIPanGestureRecognizer? ,dismisTransiltion: UIPanGestureRecognizer?) {
         transitionStatus = .present
         presentTransiltionGestureRecognizer = presentTransiltion
         dismisTransiltionGestureRecognizer = dismisTransiltion
         super.init()

    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let containView = transitionContext.containerView
        
        containView.addSubview(fromVC!.view)
        containView.addSubview(toVC!.view)
        toVC!.view.layer.opacity = 0
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveEaseInOut, animations: {
            toVC!.view.layer.opacity = 1
            }) { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                if !self.cancelPop {
                    if finished {
                        self.completion?()
                        self.completion = nil
                    }
                }
                self.cancelPop = false
        }
    }
    
}
