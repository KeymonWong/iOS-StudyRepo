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
    var loadingView: LoadingAnimationView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.pulseBtn.layer.cornerRadius = 40 * 0.5;
        
        // width height 不等即为椭圆形脉冲动画，相等即为圆形脉冲动画
        pulseView = PulseAnimationView(frame: CGRect(x: 60-(120-40)*0.5, y: 60*0.5, width: 120, height: 60))
        
        //将动画view添加到按钮下面
        self.view.insertSubview(pulseView, belowSubview: self.pulseBtn)
        
        loadingView = LoadingAnimationView(frame: CGRect(x: UIScreen.main.bounds.size.width-60-50, y: 60, width: 50, height: 50))
        self.view.addSubview(loadingView)
    }

    
    @IBAction func pulseBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            self.pulseView.startAnimation()
        } else {
            self.pulseView.stopAnimation()
        }
    }
    
    @IBAction func loadingBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            self.loadingView.startAnimation()
        } else {
            self.loadingView.stopAnimation()
        }
    }
}

