//
//  Constant.swift
//  SampleApp
//

import Foundation
import UIKit

let appDelegateShared:AppDelegate = UIApplication.shared.delegate as! AppDelegate
@available(iOS 13.0, *)
let sceneDelegateShared:SceneDelegate = UIApplication.shared.delegate as! SceneDelegate

var globalDateFormatter: DateFormatter = DateFormatter()

let kDateFormatYYYYMMDD = "yyyy-MM-dd"
let kServerDateTime = "yyyy-MM-dd hh:mm:ss"
let kServerDateTime24Hour = "yyyy-MM-dd HH:mm:ss"
let kServerDateFormat1 = "yyyy-MM-dd'T'HH:mm:ss"
let kServerDateFormat2 = "yyyy-MM-dd'T'HH:mm:ss.SSS"
let kServerDateFormat3 = "yyyy-MM-dd'T'HH:mm:ss.sss"
let kServerDateFormat4 = "yyyy-MM-dd HH:mm:ss.zzz"
let kServerDateFormat5 = "yyyy-MM-dd'T'HH:mm:ssZ"

let kDateFormatDDMMMYYYY = "dd MMM,yyyy"
let kTimeFormatHHMM = "hh:mm a"

// UserDefaults
let kUserDefaultsTestDate = "TestDate"

func showServiceLoader()
{
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0)
    {
        Loader.sharedLoader.add()
    }
}

func showLoader(withMessage:String)
{
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0)
    {
        Loader.sharedLoader.lblMessage.text = withMessage + "   "
        Loader.sharedLoader.add()
    }
}

func showLoader()
{
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0)
    {
        Loader.sharedLoader.add()
    }
}

func hideLoader()
{
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0)
    {
        Loader.sharedLoader.lblMessage.text = ""
        Loader.sharedLoader.remove()
    }
}

