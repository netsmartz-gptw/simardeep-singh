//
//  Spinner.swift
//  SampleApp
//

import UIKit

class Spinner: UIView
{
    var circleLayer = CAShapeLayer()
    
    override func draw(_ rect: CGRect)
    {
        self.commonInit()
    }
    
    func commonInit() -> Void
    {
        self.layer .addSublayer(circleLayer)
        circleLayer.fillColor = nil
        circleLayer.lineCap = CAShapeLayerLineCap.round
        circleLayer.lineWidth = 2.0
        
        circleLayer.strokeColor = colorRed.cgColor
        circleLayer.strokeStart = 0
        circleLayer.strokeEnd = 0
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        if(!self.circleLayer.frame.equalTo(self.bounds)){
            self.updateCircleLayer()
        }
    }
    
    
    func updateCircleLayer()
    {
        let center : CGPoint = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
       let radius : CGFloat = (self.bounds.size.height - 30)/2

        let startAngle : CGFloat = 0.0
        let endAngle : CGFloat = CGFloat(Double.pi) * 2.0
        let path : UIBezierPath = UIBezierPath.init(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        circleLayer.path = path.cgPath
        circleLayer.frame = self.bounds
    }
    
    func beginRefreshing()
    {
        let rotateAnimation : CAKeyframeAnimation = CAKeyframeAnimation.init(keyPath: "transform.rotation")
        rotateAnimation.values = [0,Double.pi,(2*Double.pi)]
        
        let headAnimation : CABasicAnimation = CABasicAnimation.init()
        headAnimation.keyPath = "strokeStart"
        headAnimation.duration = 1
        headAnimation.fromValue = 0.0
        headAnimation.toValue = 0.25
        
        let tailAnimation : CABasicAnimation = CABasicAnimation.init()
        tailAnimation.keyPath = "strokeEnd"
        tailAnimation.duration = 1
        tailAnimation.fromValue = 0.0
        tailAnimation.toValue = 1
        
        let endHeadAnimation : CABasicAnimation = CABasicAnimation.init()
        endHeadAnimation.keyPath = "strokeStart"
        endHeadAnimation.beginTime = 1
        endHeadAnimation.duration = 1
        endHeadAnimation.fromValue = 0.25
        endHeadAnimation.toValue = 1
        
        let endTailAnimation : CABasicAnimation = CABasicAnimation.init()
        endTailAnimation.keyPath = "strokeEnd"
        endTailAnimation.beginTime = 1
        endTailAnimation.duration = 1
        endTailAnimation.fromValue = 1
        endTailAnimation.toValue = 1
        
        let animations : CAAnimationGroup = CAAnimationGroup.init()
        animations.duration = 2
        animations.animations = [rotateAnimation,headAnimation,tailAnimation,endHeadAnimation,endTailAnimation]
        animations.repeatCount = 10000.0
        circleLayer.add(animations, forKey: "animations")
    }
    
    func endRefreshing()
    {
        circleLayer.removeAnimation(forKey: "animations")
    }
}

