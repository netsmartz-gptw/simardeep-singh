//
//  CustomizedButton.swift
//  SampleApp
//

import UIKit

class FontButton: UIButton
{
    @IBInspectable var fontTag:String = ""
    {
        didSet
        {
            self.titleLabel?.font = getFontWithTag(tag: fontTag)
        }
    }
}

class CustomizedButton: FontButton {
    
    @IBInspectable var showBottomShadow:Bool = false
        {
        didSet
        {
            if showBottomShadow == true
            {
                self.clipsToBounds = false
                self.layer.shadowColor = UIColor.black.cgColor
                self.layer.shadowOffset = CGSize.init(width: 0.5, height: 5.0)
                self.layer.shadowOpacity = 0.5
            }
            else
            {
                self.layer.shadowColor = nil
                self.layer.shadowOffset = CGSize.init(width: 0.0, height: 0.0)
                self.layer.shadowOpacity = 0
            }
        }
    }
    
    // Corner Radius
    @IBInspectable var cornerRadius: CGFloat = 0
        {
        didSet
        {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    // Border Width
    @IBInspectable var borderWidth: CGFloat = 0
        {
        didSet
        {
            self.layer.borderWidth = borderWidth
        }
    }
    
    // Border Color
    @IBInspectable var borderColor: UIColor?
        {
        didSet
        {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
    
    // Rounded button
    @IBInspectable var isRoundEdges:Bool = false
        {
        didSet
        {
            if isRoundEdges == true
            {
                self.layer.cornerRadius = self.frame.size.height/2
            }
        }
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        if isRoundEdges == true
        {
            self.layer.cornerRadius = self.frame.size.height/2
        }
    }
}
