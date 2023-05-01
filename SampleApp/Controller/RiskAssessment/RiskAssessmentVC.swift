//
//  RiskAssessmentVC.swift
//  SampleApp
//

import UIKit

struct Constants {
    static let MAX_BEFORE_DECIMAL_DIGITS = 3
    static let MAX_AFTER_DECIMAL_DIGITS = 2
}

class RiskAssessmentVC: BaseVC {

    var objRiskModel : RiskAssessmentModel?
    var objAssessmentResult : AssessmentResult?
    var arrayChecklist = [CheckList]()
    
    var strTemp = ""
    
    @IBOutlet weak var lblStatus: FontLabel!
    @IBOutlet weak var lblMsg: FontLabel!
    @IBOutlet var viewAssessmentTiming: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnSubmit: CustomizedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnSubmit.isHidden = true
        self.title = kTitleHealthAssessment
        registerCustomCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if compareDatesAndShowDesignView() == true
        {
            callCheckListAPI()
        } else {
            self.addAssessmentTimingView()
        }
    }
        
    func compareDatesAndShowDesignView() -> Bool
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let strDate = formatter.string(from: Date())
        let formattedCurrentDate : Date = formatter.date(from: strDate)!
        
        formatter.dateFormat = "yyyy-MM-dd"
        var strDateTimeAfter6Am = formatter.string(from: Date())
        var strDateTimeBefore12Pm = formatter.string(from: Date())
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        strDateTimeAfter6Am = strDateTimeAfter6Am +  " " + "06:00:00"
        let formattedDateAfter6Am : Date = formatter.date(from: strDateTimeAfter6Am)!
        
        strDateTimeBefore12Pm = strDateTimeBefore12Pm +  " " + "23:59:59"
        let formattedDateBefore12Pm : Date = formatter.date(from: strDateTimeBefore12Pm)!
                
        let range = formattedDateAfter6Am...formattedDateBefore12Pm
        
        if range.contains(formattedCurrentDate) {
            return true
        } else {
            return false
        }
    }
    
    func addAssessmentTimingView()
    {
        if (viewAssessmentTiming != nil) {
            viewAssessmentTiming.removeFromSuperview()
        }
        self.view.addSubview(viewAssessmentTiming)
        viewAssessmentTiming.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[viewAssessmentTiming]|", options:  NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["viewAssessmentTiming":viewAssessmentTiming!]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[viewAssessmentTiming]|", options:  NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["viewAssessmentTiming":viewAssessmentTiming!]))
        
        self.lblStatus.text = kBlueScreen
        self.lblMsg.text = DataHelper.getMessageForAssessmentResult()
    }
    
    func registerCustomCells()
    {
        tblView.register(UINib.init(nibName: "RiskAssessmentInputEntryCell", bundle: nil), forCellReuseIdentifier: "RiskAssessmentInputEntryCell")
        tblView.estimatedRowHeight = 220.0
        tblView.rowHeight = UITableView.automaticDimension
        
        tblView.register(UINib.init(nibName: "RiskAssessmentSelectionCell", bundle: nil), forCellReuseIdentifier: "RiskAssessmentSelectionCell")
        tblView.estimatedRowHeight = 100.0
        tblView.rowHeight = UITableView.automaticDimension
    }
    
    func callCheckListAPI()
    {
        showLoader()
        let dict : [String : Any] = ["UserId" : DataHelper.getUserId(),
                                     "Date" : DataHelper.getCurrentDateInYMDformat()]
        ApiManager.call_ChecklistDataService(params: dict) { (obj) in
            self.objRiskModel = obj
            if (self.viewAssessmentTiming != nil) {
                self.viewAssessmentTiming.removeFromSuperview()
            }
            if self.objRiskModel != nil {
                    self.arrayChecklist = self.objRiskModel!.arrayChecklist
                if self.arrayChecklist.count > 0
                {
                    self.btnSubmit.isHidden = false
                }
            self.tblView.reloadData()
//            }
            }
        }
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        if compareDatesAndShowDesignView() == true
        {
            createDictionaryForSubmitting()
        } else {
            self.addAssessmentTimingView()
        }
    }
    
    func createDictionaryForSubmitting()
    {
         var arrayParams = [[String : Any]]()
               for obj in arrayChecklist {
                var strAnswer = ""
                var strAnswerType = "bit"
                
                if obj.answer_type == "int"
                {
                    if obj.boolCelsiusSelected {
                        strAnswerType = "C"
                    }
                    else {
                        strAnswerType = "F"
                    }
                    strAnswer = strTemp
                } else {
                    strAnswer = obj.optionSelected
                }
                
                   let dict = ["ListItemId" : obj.ListItemId,
                               "code" : obj.code,
                               "answer_type" : strAnswerType,
                               "response" : strAnswer
                       ] as [String : AnyObject]
                   arrayParams.append(dict)
               }

        var dictParams : [String : Any] = [:]
        dictParams["UserId"] = DataHelper.getUserId()
        dictParams["CreatedDate"] = DataHelper.getCurrentDateTime()
        dictParams["Test"] = arrayParams
        
        ApiManager.call_SaveChecklistDataService(params: dictParams) { (objResult) in
            self.objAssessmentResult = objResult
            if self.objAssessmentResult != nil
            {
                let resultVC = AssessmentResultVC.init(nibName: "AssessmentResultVC", bundle: nil)
                resultVC.strCode = self.objAssessmentResult!.code
                self.navigationController?.pushViewController(resultVC, animated: true)
            }
        }
    }
}

extension RiskAssessmentVC : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayChecklist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellInput = tblView.dequeueReusableCell(withIdentifier: "RiskAssessmentInputEntryCell") as! RiskAssessmentInputEntryCell
        cellInput.selectionStyle = .none
        
        let cellSelection = tblView.dequeueReusableCell(withIdentifier: "RiskAssessmentSelectionCell") as! RiskAssessmentSelectionCell
        cellSelection.selectionStyle = .none
        
        if arrayChecklist.count > 0 {
        let objChecklist = arrayChecklist[indexPath.row]
            if objChecklist.answer_type == "int" {
            cellInput.lblTitle.text = objChecklist.name
            cellInput.txtInput.addDoneToolbar(onDone: (target: self, action: #selector(self.tapDone)))
            cellInput.txtInput.delegate = self
                
                if objChecklist.boolCelsiusSelected
                {
                    cellInput.btnCelsius.isSelected = true
                    cellInput.btnFahrenheit.isSelected = false
                } else {
                    cellInput.btnCelsius.isSelected = false
                    cellInput.btnFahrenheit.isSelected = true
                }
                
                cellInput.btnCelsius.addTarget(self, action: #selector(btnCelsiusAction(button:)), for: .touchUpInside)
                cellInput.btnCelsius.tag = indexPath.row
                
                cellInput.btnFahrenheit.addTarget(self, action: #selector(btnFahrenheitAction(button:)), for: .touchUpInside)
                cellInput.btnFahrenheit.tag = indexPath.row
                
                cellInput.txtInput.text = strTemp
            return cellInput
        } else {
            cellSelection.lblTitle.text = objChecklist.name
            cellSelection.btnYes.addTarget(self, action: #selector(btnYesAction(button:)), for: .touchUpInside)
            cellSelection.btnYes.tag = indexPath.row
            
            cellSelection.btnNo.addTarget(self, action: #selector(btnNoAction(button:)), for: .touchUpInside)
            cellSelection.btnNo.tag = indexPath.row
            if objChecklist.optionSelected == "Y" {
                cellSelection.btnYes.isSelected = true
                cellSelection.btnNo.isSelected = false
            }
            if objChecklist.optionSelected == "N" {
                cellSelection.btnYes.isSelected = false
                cellSelection.btnNo.isSelected = true
            }
            if objChecklist.optionSelected == "" {
                cellSelection.btnYes.isSelected = false
                cellSelection.btnNo.isSelected = false
            }
            
            return cellSelection
        }
        }
        return UITableViewCell()
    }
    
    @objc func tapDone() {
        view.endEditing(true)
    }
    
    @objc func btnYesAction(button: UIButton)
    {
        let obj = arrayChecklist[button.tag]
        obj.optionSelected = "Y"
        arrayChecklist.remove(at: button.tag)
        arrayChecklist.insert(obj, at: button.tag)
        self.tblView.beginUpdates()
        self.tblView.reloadRows(at: [IndexPath.init(row: button.tag, section: 0)], with: .none)
        self.tblView.endUpdates()
    }
    
    @objc func btnNoAction(button: UIButton)
    {
        let obj = arrayChecklist[button.tag]
        obj.optionSelected = "N"
        arrayChecklist.remove(at: button.tag)
        arrayChecklist.insert(obj, at: button.tag)
        self.tblView.beginUpdates()
        self.tblView.reloadRows(at: [IndexPath.init(row: button.tag, section: 0)], with: .none)
        self.tblView.endUpdates()
    }
    
    @objc func btnCelsiusAction(button: UIButton)
    {
        let obj = arrayChecklist[button.tag]
        obj.boolCelsiusSelected = true
               arrayChecklist.remove(at: button.tag)
               arrayChecklist.insert(obj, at: button.tag)
        self.tblView.beginUpdates()
        self.tblView.reloadRows(at: [IndexPath.init(row: button.tag, section: 0)], with: .none)
        self.tblView.endUpdates()
    }
    
    @objc func btnFahrenheitAction(button: UIButton)
    {
        let obj = arrayChecklist[button.tag]
               obj.boolCelsiusSelected = false
               arrayChecklist.remove(at: button.tag)
               arrayChecklist.insert(obj, at: button.tag)
        self.tblView.beginUpdates()
        self.tblView.reloadRows(at: [IndexPath.init(row: button.tag, section: 0)], with: .none)
        self.tblView.endUpdates()
    }
}

extension RiskAssessmentVC : UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
       {
               if textField.text?.count == 0 && (string == "0" || string == ".") {
                   return false
               }
               let computationString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                strTemp = computationString.replacingOccurrences(of: "..", with: ".") // Need for passing in Save Service
                print("Temp entered is \(strTemp)")
               let arrayOfSubStrings = computationString.components(separatedBy: ".")
               if computationString.contains("..")
               {
                   return false
               }
               else if arrayOfSubStrings.count == 1 && computationString.count > Constants.MAX_BEFORE_DECIMAL_DIGITS {
                   return false
               } else if arrayOfSubStrings.count == 2 {
                   let stringPostDecimal = arrayOfSubStrings[1]
                   return stringPostDecimal.count <= Constants.MAX_AFTER_DECIMAL_DIGITS
               }
           return true
       }
}
