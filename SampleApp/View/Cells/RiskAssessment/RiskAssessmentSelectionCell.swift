//
//  RiskAssessmentSelectionCell.swift
//  SampleApp
//

import UIKit

class RiskAssessmentSelectionCell: UITableViewCell {

    @IBOutlet weak var lblTitle: FontLabel!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
