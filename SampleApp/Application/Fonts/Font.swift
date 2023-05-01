//
//  Font.swift
//  SampleApp
//

import Foundation
import UIKit

func font_OpenSansRegular(size:CGFloat) -> UIFont
{
    return UIFont(name: "OpenSans", size: size)!
}
func font_OpenSansSemiBold(size:CGFloat) -> UIFont
{
    return UIFont(name: "OpenSans-Semibold", size: size)!
}
func font_OpenSansItalic(size:CGFloat) -> UIFont
{
    return UIFont(name: "OpenSans-Italic", size: size)!
}
func font_OpenSansBold(size:CGFloat) -> UIFont
{
    return UIFont(name: "OpenSans-Bold", size: size)!
}
func font_RalewayBold(size:CGFloat) -> UIFont
{
    return UIFont(name: "Raleway-Bold", size: size)!
}
func font_RalewaySemiBold(size:CGFloat) -> UIFont
{
    return UIFont(name: "Raleway-SemiBold", size: size)!
}
func font_RalewayRegular(size:CGFloat) -> UIFont
{
    return UIFont(name: "Raleway-Regular", size: size)!
}

func getFontWithTag(tag:String)-> UIFont
{
    if tag.count > 3
    {
        let strFontTag = tag.prefix(2)
        let strSizeTag = tag.suffix(tag.count-2)
        
        let intSizeTag = Int(strSizeTag) ?? 42
        let fontSize = getFontSizeforTag(tag: intSizeTag)
        
        if strFontTag == "11"
        {
            return font_OpenSansItalic(size: fontSize)
        }
        else if strFontTag == "12"
        {
            return font_OpenSansSemiBold(size: fontSize)
        }
        else if strFontTag == "13"
        {
            return font_OpenSansBold(size: fontSize)
        }
        else if strFontTag == "31"
        {
            return font_RalewayRegular(size: fontSize)
        }
        else if strFontTag == "32"
        {
            return font_RalewaySemiBold(size: fontSize)
        }
        else if strFontTag == "34"
        {
            return font_RalewayBold(size: fontSize)
        }
        else
        {
            return font_OpenSansRegular(size: fontSize)
        }
    }
    return font_OpenSansRegular(size: getFontSizeforTag(tag: 42))
}

func getFontSizeforTag(tag:Int)->CGFloat
{
    if UIScreen.main.bounds.size.height <= 568
    {
        return (CGFloat(tag)/3) - 1.0
    }
    else if UIScreen.main.bounds.size.height == 667
    {
        return (CGFloat(tag)/3) - 0.5
    }
    else if UIScreen.main.bounds.size.height == 736
    {
        return (CGFloat(tag)/3)
    }
    else
    {
        return (CGFloat(tag)/3) + 0.5
    }
}

