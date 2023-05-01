//
//  AssessmentResultVC.swift
//  SampleApp
//

import UIKit

class AssessmentResultVC: BaseVC {

    var strCode = ""
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblStatus: FontLabel!
    @IBOutlet weak var lblMsg: FontLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = kTitleHealthAssessment
        showResult()
    }
    
    func showResult()
    {
        if strCode == "R" {
            self.view.backgroundColor = colorRed
            self.imgView.image = UIImage(named: "ic_cross_result")
            self.lblStatus.text = kResultRed
        }
        if strCode == "O" {
            self.view.backgroundColor = colorOrange
            self.imgView.image = UIImage(named: "ic_question_result")
            self.lblStatus.text = kResultOrange
        }
        if strCode == "G" {
            self.view.backgroundColor = colorGreen
            self.imgView.image = UIImage(named: "ic_tick_result")
            self.lblStatus.text = kResultGreen
        }
        
        self.lblMsg.text = kMsgSuccess
    }



}
