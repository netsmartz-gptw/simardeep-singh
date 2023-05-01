//
//  CustomizedTextField.swift
//  SampleApp
//

import UIKit

class FontTextField: UITextField
{
    @IBInspectable var fontTag:String = ""
        {
        didSet
        {
            self.font = getFontWithTag(tag: fontTag)
        }
    }
}

class CustomizedTextField: FontTextField {
    
    // Corner Radius
    @IBInspectable var cornerRadius : CGFloat = 0
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
    
    var padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 5)
    
    @IBInspectable var addPadding:Bool = true
        {
        didSet
        {
            if self.isSecureTextEntry {
            self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            }
            if addPadding == true
            {
                if self.isSecureTextEntry {
                padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 25)
                } else {
                padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 5)
                }
                self.layoutIfNeeded()
            }
            else
            {
                padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
        }
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}
