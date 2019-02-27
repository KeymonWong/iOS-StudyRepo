//
//  PulseAnimationView.swift
//  脉冲动画
//
//  Created by keymon on 2019/2/26.
//  Copyright © 2019 ok. All rights reserved.
//

import UIKit

class PulseAnimationView: UIView {
    
    //定义脉冲图层
    var pulseLayer: CAShapeLayer!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let width = frame.size.width
        
        //动画图层
        pulseLayer = CAShapeLayer()
        pulseLayer.bounds = CGRect(x: 0, y: 0, width: width, height: width)
        pulseLayer.position = CGPoint(x: width * 0.5, y: width * 0.5)
        pulseLayer.backgroundColor = UIColor.clear.cgColor
        //用BezierPath画一个模型
        pulseLayer.path = UIBezierPath(ovalIn: pulseLayer.bounds).cgPath
        pulseLayer.fillColor = UIColor(red: 0.345, green: 0.737, blue: 0.804, alpha: 0.8).cgColor
        pulseLayer.opacity = 0.0
        
        //核心代码
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.bounds = pulseLayer.bounds
        replicatorLayer.position = pulseLayer.position
        replicatorLayer.instanceCount = 3 //3个复制图层
        replicatorLayer.instanceDelay = 1 //频率
        replicatorLayer.addSublayer(pulseLayer)
        self.layer.insertSublayer(replicatorLayer, at: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    func startAnimation() -> Void {
        //透明度动画
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1.0 //起始值
        opacityAnimation.toValue = 0 //结束值
        
        //扩散动画
        let spreadAnimation = CABasicAnimation(keyPath: "transform")
        let t = CATransform3DIdentity
        spreadAnimation.fromValue = NSValue(caTransform3D: CATransform3DScale(t, 0, 0, 0))
        spreadAnimation.toValue = NSValue(caTransform3D: CATransform3DScale(t, 1.0, 1.0, 0))
        /**
         * public func CATransform3DScale(_ t: CATransform3D, _ sx: CGFloat, _ sy: CGFloat, _ sz: CGFloat) -> CATransform3D
         实现以初始位置为基准,在x轴方向上平移x单位,在y轴方向上平移y单位,在z轴方向上平移z单位
         注: 当tx为正值时,会向x轴正方向平移,反之,则向x轴负方向平移;
         当ty为正值时,会向y轴正方向平移,反之,则向y轴负方向平移;
         当tz为正值时,会向z轴正方向平移,反之,则向z轴负方向平移
         */
        
        //给shapeLayer添加组合动画
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [opacityAnimation, spreadAnimation]
        groupAnimation.duration = 3.0 //持续时间
        groupAnimation.autoreverses = false //是否循环
        groupAnimation.repeatCount = HUGE //无限次循环
        pulseLayer.add(groupAnimation, forKey: nil)
    }
    
    func stopAnimation() -> Void {
        pulseLayer.removeAllAnimations()
    }

}
