//
//  ViewController.swift
//  FakeSystemBrightnessControl
//
//  Created by wuguanyu on 16/2/25.
//  Copyright © 2016年 dejauu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var vpan: UIPanGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkGrayColor()

        let gestureView = GestureView(frame: UIScreen.mainScreen().bounds)
        self.view.addSubview(gestureView)
    }

}
