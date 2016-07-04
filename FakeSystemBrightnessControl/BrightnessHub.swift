//
//  BrightnessHub.swift
//  TheSarrs
//
//  Created by wuguanyu on 16/2/18.
//  Copyright © 2016年 leso. All rights reserved.
//

import UIKit

private let sharedInstance = BrightnessHub()

class BrightnessHub: UIView {

    var disMissTimer: NSTimer?
    var volViewArray = [UIView]()

    var brightness: CGFloat = 0 {
        didSet {
            // 亮度块数
            let num = Int(round(brightness * 16))

            for index in 0 ..< 16 {
                let aVolView = volViewArray[index]
                if index < num {
                    aVolView.hidden = false
                } else {
                    aVolView.hidden = true
                }
            }

            self.alpha = 1
            self.hidden = false

            disMissTimer?.invalidate()
            disMissTimer = nil
            disMissTimer = NSTimer(timeInterval: 2, target: self, selector: #selector(BrightnessHub.dismissSelf), userInfo: nil, repeats: false)
            NSRunLoop.mainRunLoop().addTimer(disMissTimer!, forMode: NSDefaultRunLoopMode)
        }
    }

    convenience init() {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        self.init(frame: CGRect(x: 0, y: 0, width: 155, height: 155))
        self.center = CGPoint(x: screenWidth / 2, y: screenHeight / 2)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = CGRect(x: 0, y: 0, width: 155, height: 155)
        blurEffectView.layer.cornerRadius = 10
        blurEffectView.layer.masksToBounds = true
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(blurEffectView)

        self.userInteractionEnabled = false
        let label = UILabel(frame: CGRect(x: 60, y: 10, width: 34, height: 18))
        label.text = "亮度"
        label.alpha = 0.7
        label.textColor = UIColor.blackColor()
        label.font = UIFont.boldSystemFontOfSize(16)
        self.addSubview(label)

        // sun
        let sunView = UIImageView(frame: CGRect(x: 41, y: 41, width: 72, height: 72))
        sunView.image = UIImage(named: "sunLogo")
        sunView.alpha = 0.7
        self.addSubview(sunView)

        let totolVolBgView = UIView(frame: CGRect(x: 13, y: 133, width: 129, height: 7))
        totolVolBgView.backgroundColor = UIColor.blackColor()
        totolVolBgView.alpha = 0.7
        self.addSubview(totolVolBgView)

        for index in 0 ..< 16 {
            let volView = UIView(frame: CGRect(x: 14 + index * 8, y: 134, width: 7, height: 5))
            volView.backgroundColor = UIColor.whiteColor()
            volView.hidden = true
            volViewArray.append(volView)
            self.addSubview(volView)
        }

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BrightnessHub.orientationDidChange(_:)), name: UIDeviceOrientationDidChangeNotification, object: nil)
        addToWindow()
    }

    func orientationDidChange(notify: NSNotification) {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        self.center = CGPoint(x: screenWidth / 2, y: screenHeight / 2)
    }

    class var sharedHub: BrightnessHub {
        return sharedInstance
    }

    func dismissSelf() {
        UIView.animateWithDuration(0.15, animations: {
            self.alpha = 0.0
            }, completion: {
                (value: Bool) in
                self.hidden = true
        })

        disMissTimer?.invalidate()
        disMissTimer = nil
    }

    func addToWindow() {
        var keyWindow = UIApplication.sharedApplication().keyWindow

        if keyWindow == nil {
            keyWindow = UIApplication.sharedApplication().windows[0]
        }

        keyWindow!.addSubview(self)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
