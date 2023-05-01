//
//  CustomizedLabel.swift
//  SampleApp
//

import UIKit

class FontLabel: UILabel
{
    @IBInspectable var fontTag:String = ""
        {
        didSet
        {
            self.font = getFontWithTag(tag: fontTag)
        }
    }
}

class CustomizedLabel: FontLabel
{
    @IBInspectable var cornerRadius: CGFloat = 0
        {
        didSet
        {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0
        {
        didSet
        {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor?
        {
        didSet
        {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
    
}
