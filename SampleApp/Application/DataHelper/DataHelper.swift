//
//  DataHelper.swift
//  SampleApp
//

import UIKit

class DataHelper: NSObject {
    
    class func parseDateAndGetDateObject(forObject:Any?) -> Date?
    {
        let strDate = DataHelper.getStringValueForObject(optionalValue: forObject)
        
        if strDate.count > 0
        {
            globalDateFormatter.dateFormat = kDateFormatYYYYMMDD
            if let date = globalDateFormatter.date(from: strDate)
            {
                return date
            }
            globalDateFormatter.dateFormat = kServerDateFormat1
            if let date = globalDateFormatter.date(from: strDate)
            {
                return date
            }
            globalDateFormatter.dateFormat = kServerDateFormat2
            if let date = globalDateFormatter.date(from: strDate)
            {
                return date
            }
            globalDateFormatter.dateFormat = kServerDateFormat3
            if let date = globalDateFormatter.date(from: strDate)
            {
                return date
            }
            globalDateFormatter.dateFormat = kServerDateFormat4
            if let date = globalDateFormatter.date(from: strDate)
            {
                return date
            }
            globalDateFormatter.dateFormat = kServerDateFormat5
            if let date = globalDateFormatter.date(from: strDate)
            {
                return date
            }
            globalDateFormatter.dateFormat = kServerDateTime
            if let date = globalDateFormatter.date(from: strDate)
            {
                return date
            }
            globalDateFormatter.dateFormat = kServerDateTime24Hour
            if let date = globalDateFormatter.date(from: strDate)
            {
                return date
            }
        }
        return nil
    }
    
    class func getStringValueForObject(optionalValue:Any?) -> String
    {
        if let value = optionalValue
        {
            let strValue = Utility.saveResponse(inString: value)
            if strValue == "<null>" || strValue == "null"
            {
                return ""
            }
            return strValue
        }
        return ""
    }
    
    class func setTestDate(strDate: String?)
    {
        if let date = DataHelper.parseDateAndGetDateObject(forObject: strDate)
        {
            UserDefaults.standard.set(date, forKey: kUserDefaultsTestDate)
            UserDefaults.standard.synchronize()
        }
        
    }
    
    class func getCurrentDateInYMDformat() -> String
    {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = kDateFormatYYYYMMDD
        return dateFormatter.string(from: Date()).naIfBlank()
    }
    
    class func getCurrentDateTime() -> String
    {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = kServerDateTime24Hour
        return dateFormatter.string(from: Date()).naIfBlank()
    }
    
    //    class func getCurrentDateTime() -> Date
    //    {
    //    let date = Date()
    //    let format = DateFormatter()
    //    format.dateFormat = "yyyy-MM-dd HH:mm:ss"
    //    let formattedDate = format.string(from: date)
    //    print(formattedDate)
    //    }
    
    class func getUserId() -> String {
        return "2"
    }
    
    class func getStringWithOneDecimal(_ str : String) -> String
    {
        let numberFormatter = NumberFormatter()
        let number = numberFormatter.number(from: str)
        let numberFloatValue = number?.floatValue
        return String(format: "%.1f", numberFloatValue ?? 0)
    }
    
    class func getAttributedStringFor(strPrefix : String, strMain : String, strPrefixFontTag : String, strMainFontTag : String) -> String
    {
        let strAttributed1 = NSAttributedString(string: strPrefix,
                                                attributes: [NSAttributedString.Key.foregroundColor : colorDarkGrey, NSAttributedString.Key.font : getFontWithTag(tag: strPrefixFontTag)])
        
        let strAttributed2 = NSAttributedString(string: String("\(strMain)"),
                                                attributes: [NSAttributedString.Key.foregroundColor : colorRed, NSAttributedString.Key.font : getFontWithTag(tag: strMainFontTag)])
        
        let finalAttributed = NSMutableAttributedString(attributedString: strAttributed1)
        if !strAttributed2.string.isEmpty
        {
            finalAttributed.append(strAttributed2)
        }
        return finalAttributed.string
    }
    
    class func getMessageForAssessmentResult() -> String
    {
        var strMsg = ""
        if UserDefaults.standard.value(forKey: kUserDefaultsTestDate) != nil {
            if let date = UserDefaults.standard.value(forKey: kUserDefaultsTestDate)
            {
                globalDateFormatter.dateFormat = kDateFormatDDMMMYYYY
                let strDate = globalDateFormatter.string(from: date as! Date)
                
                globalDateFormatter.dateFormat = kTimeFormatHHMM
                let strTime = globalDateFormatter.string(from: date as! Date)
                return ("Dear User! Self-Assessment completed on \(strDate) at \(strTime)")
            }
        }
        return "Dear User! Please assess yourself before going to the office."
    }
    
    
}
