//
//  Loader.swift
//  SampleApp
//

import UIKit

class Loader: UIView {
    
    @IBOutlet weak var spinnerView: Spinner!
    @IBOutlet weak var lblMessage: UILabel!

    static let sharedLoader = Loader.initWithNib()
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    class func initWithNib() -> Loader
    {
        return UINib(nibName: "Loader", bundle: nil).instantiate(withOwner: nil, options: nil).last! as! Loader
    }
    
    func add()
    {
        spinnerView.beginRefreshing()
        self.translatesAutoresizingMaskIntoConstraints = false
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        window!.addSubview(self)
        window!.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[self]|", options:  NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["self":self]))
        window!.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[self]|", options:  NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["self":self]))
    }
    
    func remove()
    {
        spinnerView.endRefreshing()
        self.removeFromSuperview()
    }
}
