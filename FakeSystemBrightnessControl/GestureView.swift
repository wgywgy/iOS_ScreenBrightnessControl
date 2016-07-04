//
//  GestureView.swift
//  FakeSystemBrightnessControl
//
//  Created by wuguanyu on 16/3/4.
//  Copyright © 2016年 dejauu. All rights reserved.
//

import UIKit

class GestureView: UIView, UIGestureRecognizerDelegate {

    var vpan: UIPanGestureRecognizer!
    var locked = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(frame: CGRectZero)
        setup()
    }

    func setup() {
        vpan = UIPanGestureRecognizer(target: self, action: #selector(GestureView.vpanAction(_:)))
        vpan.delegate = self
        addGestureRecognizer(vpan)
        self.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
    }

    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        let pan = gestureRecognizer as? UIPanGestureRecognizer

        if pan == self.vpan {
            let velocity = pan!.velocityInView(self)
            return fabs(velocity.x) < fabs(velocity.y)
        }

        return true
    }

    func vpanAction(pan: UIPanGestureRecognizer) {
        if pan.state == .Began {
//            self.delegate?.rightVpanStart?()
        } else if pan.state == .Changed || pan.state == .Ended {
//            let location = pan.locationInView(self)
//            let screenSize: CGRect = UIScreen.mainScreen().bounds
//            let screenWidth = screenSize.width

            let velocity = pan.velocityInView(self)

            leftVpanWith(velocity.y)
            // right
//            if (location.x > screenWidth/2) {
//                self.delegate?.rightVpanWith?(velocity.y)
//            } else {
//                self.delegate?.leftVpanWith?(velocity.y)
//            }
        }
    }

    func leftVpanWith(offset: CGFloat) {
        guard locked == false else { return }

        var brightness = UIScreen.mainScreen().brightness

        if offset > 0 {
            brightness -= 0.03
        } else {
            brightness += 0.03
        }

        UIScreen.mainScreen().brightness = brightness

        BrightnessHub.sharedHub.brightness = brightness
    }

}
