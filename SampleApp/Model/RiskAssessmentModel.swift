//
//  RiskAssessmentModel.swift
//  SampleApp
//

import Foundation

class RiskAssessmentModel {
    var UserID = ""
    var IsTestTaken = false
    var HealthStatusID = ""
    var HealthStatus = ""
    var arrayChecklist = [CheckList]()
    
    init(_ dict : [String : Any])
    {
        UserID = DataHelper.getStringValueForObject(optionalValue: dict["UserID"])
        IsTestTaken = DataHelper.getStringValueForObject(optionalValue: dict["IsTestTaken"]).boolValue()
        HealthStatusID = DataHelper.getStringValueForObject(optionalValue: dict["HealthStatusID"])
        HealthStatus = DataHelper.getStringValueForObject(optionalValue: dict["HealthStatus"])
        
        guard let jsonResult = dict["ChecklistItems"] as? [[String: Any]] else
        {
            return
        }
        for dic in jsonResult
        {
            arrayChecklist.append(CheckList.init(dic))
        }
    }
}

class CheckList
{
    var ListItemId = ""
    var code = ""
    var answer_type = ""
    var name = ""
    var option_1 = ""
    var option_2 = ""
    var optionSelected = ""
    var boolCelsiusSelected = false
    
    init(_ dict : [String : Any])
    {
        ListItemId = DataHelper.getStringValueForObject(optionalValue: dict["ListItemId"])
        code = DataHelper.getStringValueForObject(optionalValue: dict["code"])
        answer_type = DataHelper.getStringValueForObject(optionalValue: dict["answer_type"])
        name = DataHelper.getStringValueForObject(optionalValue: dict["name"])
        option_1 = DataHelper.getStringValueForObject(optionalValue: dict["option_1"])
        option_2 = DataHelper.getStringValueForObject(optionalValue: dict["option_2"])
    }
}

class AssessmentResult
{
    var status = ""
    var code = ""
    var description = ""
    
    init(_ dict : [String : Any])
    {
        status = DataHelper.getStringValueForObject(optionalValue: dict["status"])
        code = DataHelper.getStringValueForObject(optionalValue: dict["code"])
        description = DataHelper.getStringValueForObject(optionalValue: dict["description"])
    }
}
