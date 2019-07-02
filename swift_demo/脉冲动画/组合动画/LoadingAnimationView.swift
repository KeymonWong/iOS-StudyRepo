//
//  LoadingAnimationView.swift
//  脉冲动画
//
//  Created by keymon on 2019/7/2.
//  Copyright © 2019 ok. All rights reserved.
//

import UIKit

class LoadingAnimationView: UIView {
    var loadingPathLayer: CAShapeLayer!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadingPathLayer = CAShapeLayer()
        loadingPathLayer.frame = self.bounds
        loadingPathLayer.strokeEnd = 0
        loadingPathLayer.fillColor = self.backgroundColor?.cgColor
        loadingPathLayer.strokeColor = UIColor.orange.cgColor
        loadingPathLayer.lineWidth = 2
        loadingPathLayer.lineCap = .round
        loadingPathLayer.lineJoin = .round
        loadingPathLayer.fillRule = .evenOdd
        self.layer.addSublayer(loadingPathLayer)
        
        let path = CGMutablePath()
        path.addEllipse(in: self.bounds)
        loadingPathLayer.path = path
    }
    
    func startAnimation() -> Void {
        self.stopAnimation()
        
        let rotationAni = CABasicAnimation(keyPath: "transform.rotation")
        rotationAni.toValue = Double.pi * 2
        rotationAni.repeatCount = HUGE
        rotationAni.duration = 2
        self.layer.add(rotationAni, forKey: "rotationAni")
        
        let startAni_1 = CABasicAnimation(keyPath: "strokeStart")
        startAni_1.duration = 2 / 1.5
        startAni_1.toValue = 0.25
        
        let endAni_1 = CABasicAnimation(keyPath: "strokeEnd")
        endAni_1.duration = 2 / 1.5
        endAni_1.toValue = 1.0
        
        let startAni_2 = CABasicAnimation(keyPath: "strokeStart")
        startAni_2.beginTime = 2 / 1.5
        startAni_2.duration = 2 / 3.0
        startAni_2.fromValue = 0.25
        startAni_2.toValue = 1.0;
        
        let endAni_2 = CABasicAnimation(keyPath: "strokeEnd")
        endAni_2.beginTime = 2 / 1.5
        endAni_2.duration = 2 / 3.0
        endAni_2.fromValue = 1
        endAni_2.toValue = 1
        
        let groupAni = CAAnimationGroup()
        groupAni.animations = [startAni_1, endAni_1, startAni_2, endAni_2]
//        groupAni.autoreverses = false
        groupAni.repeatCount = HUGE
        groupAni.isRemovedOnCompletion = false
        groupAni.fillMode = .forwards
        groupAni.duration = 2
        groupAni.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        loadingPathLayer.add(groupAni, forKey: "groupAni")
    }
    
    func stopAnimation() -> Void {
        loadingPathLayer.removeAllAnimations()
        self.layer.removeAllAnimations()
    }

}
