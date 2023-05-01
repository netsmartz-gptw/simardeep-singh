
//
//  Url.swift
//  SampleApp
//


import Foundation

let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
let headers = ["version" : appVersion,
               "Device" : "iOS"]

// QA server
let urlBase = "https://apps.bcone.com/IKeepUsSafe/"

let urlChecklist = urlBase + "api/Checklist/ChecklistData"
let urlSaveChecklist = urlBase + "api/Checklist/Save"

