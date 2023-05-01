//
//  ApiManager.swift
//  SampleApp
//

import UIKit
import Alamofire

let kStatusCode_VersionUpdate = 426

class ApiManager: NSObject {

    class func call_ChecklistDataService(params : [String : Any],success:@escaping(RiskAssessmentModel) -> Void)
    {
        Alamofire.request(urlChecklist, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers as? HTTPHeaders).responseJSON
            {   (response) in
                hideLoader()
                if response.result.isSuccess
                {
//                    debugPrint(response)
                    if let dictResponse = response.result.value as? Dictionary<String, AnyObject>
                    {
                        if DataHelper.getStringValueForObject(optionalValue: dictResponse["Status"]) == "1"
                        {
                            if let data = dictResponse["Data"] as? Dictionary<String, AnyObject>
                            {
                                DataHelper.setTestDate(strDate: DataHelper.getStringValueForObject(optionalValue: data["TestDate"]))
                                let objRiskForm = RiskAssessmentModel.init(data)
                                success(objRiskForm)
                                return
                            }
                        }
                        ErrorView.sharedErrorView.add(withError: DataHelper.getStringValueForObject(optionalValue: dictResponse["Message"]), color: colorRed)
                        return
                    }
                }
                else
                {
                    ErrorView.sharedErrorView.add(withError: DataHelper.getStringValueForObject(optionalValue: response.error?.localizedDescription), color: colorRed)
                }
        }
    }
    
    class func call_SaveChecklistDataService(params : [String : Any],success:@escaping(AssessmentResult) -> Void)
    {
        showLoader()
        Alamofire.request(urlSaveChecklist, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers as? HTTPHeaders).responseJSON
        {   (response) in
            hideLoader()
            if response.result.isSuccess
            {
                //                    debugPrint(response)
                if let dictResponse = response.result.value as? Dictionary<String, AnyObject>
                {
                    if DataHelper.getStringValueForObject(optionalValue: dictResponse["Status"]) == "1"
                    {
                        if let data = dictResponse["Data"] as? Dictionary<String, AnyObject>
                        {
                            DataHelper.setTestDate(strDate: DataHelper.getStringValueForObject(optionalValue: data["TestDate"]))
                            let objAssessmentResult = AssessmentResult.init(data)
                            success(objAssessmentResult)
                            return
                        }
                    }
                    ErrorView.sharedErrorView.add(withError: DataHelper.getStringValueForObject(optionalValue: dictResponse["Message"]), color: colorRed)
                    return
                }
            }
            else
            {
                ErrorView.sharedErrorView.add(withError: DataHelper.getStringValueForObject(optionalValue: response.error?.localizedDescription), color: colorRed)
            }
        }
    }
    
}
