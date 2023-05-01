//
//  Extension.swift
//  SampleApp
//

import Foundation
import UIKit

extension UITextField {
func addDoneToolbar(onDone: (target: Any, action: Selector)? = nil) {
    let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

    let toolbar: UIToolbar = UIToolbar()
    toolbar.barStyle = .black
    toolbar.items = [
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
        UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
    ]
    toolbar.sizeToFit()

    self.inputAccessoryView = toolbar
}

// Default actions:
@objc func doneButtonTapped() { self.resignFirstResponder() }
}

extension NSMutableAttributedString {

    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
}

extension String
{
    var isValidEmail: Bool {
       let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
       let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
       return testEmail.evaluate(with: self)
    }
    
    func getEncodedString() -> String
    {
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[]^` ").inverted)
        var strEncoded = self
        if let escapedString = self.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            strEncoded = escapedString
        }
        return strEncoded
    }
    
    func boolValue()->Bool
    {
        if self == "1" || self == "true"
        {
            return true
        }
        return false
    }
    
    func zeroIfBlank() -> String
    {
        if self.count == 0
        {
            return "0"
        }
        return self
    }
    
    func naIfBlank() -> String
    {
        let trimmedString = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if trimmedString.count <= 0
        {
            return "NA"
        }
        return self
    }
    
    func hyphenIfBlank() -> String
       {
           let trimmedString = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
           if trimmedString.count <= 0
           {
               return "-"
           }
           return self
       }
    
        func slice(from: String, to: String) -> String? {
            return (range(of: from)?.upperBound).flatMap { substringFrom in
                (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                    String(self[substringFrom..<substringTo])
                }
            }
        }
}

extension UIColor
{
    convenience init(hex: String)
    {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#"))
        {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6)
        {
            self.init(red: 140.0/255.0,
            green:140.0/255.0,
            blue: 140.0/255.0, alpha: CGFloat(1.0))
        }
        else
        {
            var rgbValue:UInt64 = 0
            Scanner(string: cString).scanHexInt64(&rgbValue)
            
            self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
        }
    }
}



