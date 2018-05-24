//
//  YHRippleButton.swift
//  YHRipple
//
//  Created by yuhua on 2018/5/24.
//  Copyright © 2018年 余华. All rights reserved.
//

import UIKit

class YHRippleButton: UIButton {

    //添加了一个属性表示波纹是否出现
    var rippleState = false
    
    //私有属性
    private var rippleColor: UIColor!
    private var rippleLayer: CALayer?
    
    init(frame: CGRect, rippleColor: UIColor = .red) {
        super.init(frame: frame)
        self.rippleColor = rippleColor
        
        let backLayer = CALayer()
        backLayer.frame = CGRect(x: frame.width/4, y: frame.width/4, width: frame.width/2, height: frame.width/2)
        backLayer.cornerRadius = frame.width/4
        backLayer.backgroundColor = rippleColor.cgColor
        layer.addSublayer(backLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isSelected ? began() : stop()
    }
    
    private func began() {
        rippleLayer = CALayer.createRippleLayer(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), duration: 4, ripColor: rippleColor)
        layer.insertSublayer(rippleLayer!, at: 0)
        rippleState = true
    }
    
    private func stop() {
        rippleLayer?.removeFromSuperlayer()
        rippleLayer = nil
        rippleState = false
    }

}

extension CALayer {
    //创建出动画layer
    static func createRippleLayer(frame: CGRect, duration: CFTimeInterval, ripColor: UIColor = .red) -> CALayer {
        let shape = CAShapeLayer()
        let newFrame = CGRect(x: frame.minX, y: frame.minY, width: frame.width*CGFloat(5/4), height: frame.height*CGFloat(5/4))
        let bound = CGRect(x: 0, y: 0, width: frame.width*CGFloat(5/4), height: frame.height*CGFloat(5/4))
        shape.frame = bound
        shape.path = UIBezierPath(ovalIn: bound).cgPath
        shape.fillColor = ripColor.cgColor
        shape.opacity = 0
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [alphaAnimation(), scaleAnimation()]
        animationGroup.duration = 2
        animationGroup.autoreverses = false
        animationGroup.repeatCount = HUGE
        shape.add(animationGroup, forKey: "animationGroup")
        
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = newFrame
        replicatorLayer.instanceCount = 10
        replicatorLayer.instanceDelay = 0.5
        replicatorLayer.addSublayer(shape)
        return replicatorLayer
    }
    
    //透明度动画
    private static func alphaAnimation() -> CABasicAnimation {
        let alpha = CABasicAnimation(keyPath: "opacity")
        alpha.fromValue = 1
        alpha.toValue = 0
        return alpha
    }
    
    //放大动画
    private static func scaleAnimation() -> CABasicAnimation {
        let scale = CABasicAnimation(keyPath: "transform")
        scale.fromValue = CATransform3DScale(CATransform3DIdentity, 0.5, 0.5, 0)
        scale.toValue = CATransform3DScale(CATransform3DIdentity, 1, 1, 0)
        return scale
    }
}
