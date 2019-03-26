//
//  ViewController.swift
//  脉冲动画
//
//  Created by keymon on 2019/2/26.
//  Copyright © 2019 ok. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pulseBtn: UIButton!
    
    var pulseView: PulseAnimationView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.pulseBtn.layer.cornerRadius = 40 * 0.5;
        
        pulseView = PulseAnimationView(frame: CGRect(x: (self.view.frame.size.width-300)*0.5, y: (self.view.frame.size.height-300)*0.5, width: 300, height: 300))
        
        //将动画view添加到按钮下面
        self.view.insertSubview(pulseView, belowSubview: self.pulseBtn)
        
        let n = "lll"
        
    }

    
    @IBAction func pulseBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            self.pulseView.startAnimation()
        } else {
            self.pulseView.stopAnimation()
        }
        
    }
}

