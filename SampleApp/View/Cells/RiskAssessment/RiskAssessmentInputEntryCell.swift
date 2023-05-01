//
//  RiskAssessmentInputEntryCell.swift
//  SampleApp
//

import UIKit

class RiskAssessmentInputEntryCell: UITableViewCell {
    @IBOutlet weak var lblTitle: FontLabel!
    @IBOutlet weak var btnCelsius: UIButton!
    @IBOutlet weak var btnFahrenheit: UIButton!
    @IBOutlet weak var txtInput: CustomizedTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
