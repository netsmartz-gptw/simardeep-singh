//
//  ErrorView.swift
//  SampleApp
//

import UIKit

class ErrorView: UIView {
    @IBOutlet weak var lcBottom: NSLayoutConstraint!
    @IBOutlet weak var lblError: UILabel!

    var timer:Timer = Timer()
    
    static let sharedErrorView = ErrorView.initWithNib()
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    class func initWithNib() -> ErrorView
    {
        return UINib(nibName: "ErrorView", bundle: nil).instantiate(withOwner: nil, options: nil).last! as! ErrorView
    }
    
    func setText(string:String)
    {
        lblError.text = string
        self.layoutIfNeeded()
    }
    
    func showErrorView(forError:NSError?)
    {
        if forError?.code == -1009
        {
            ErrorView.sharedErrorView.add(withError:"No Internet", color:UIColor.red)
        }
        else
        {
            ErrorView.sharedErrorView.add(withError: forError?.localizedDescription ?? "", color:UIColor.red)
        }
        print(forError?.localizedDescription ?? "")
    }
    
    func showWithAnimation()
    {
        lcBottom.constant = 500
        
        UIView.animate(withDuration: 0.25, animations:{
            
            self.layoutIfNeeded()
        },completion:{ (complete) in
            
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.removeWithAnimation), userInfo: nil, repeats: false)
        })
    }
    
    func add(withError:String, color:UIColor)
    {
        remove()
        
        lblError.superview?.backgroundColor = color
        appDelegateShared.window?.endEditing(true)
        setText(string: withError)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1)
        {
            self.translatesAutoresizingMaskIntoConstraints = false
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            window?.addSubview(self)
            window?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[self]|", options:  NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["self":self]))
            window?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[self]|", options:  NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["self":self]))
            self.showWithAnimation()
        }
    }
    func remove()
    {
        self.lcBottom.constant = 0
        self.layoutIfNeeded()
        timer.invalidate()
        self.removeFromSuperview()
    }
    @objc func removeWithAnimation()
    {
        self.lcBottom.constant = 0
        UIView.animate(withDuration: 0.25, animations:
            {
            self.layoutIfNeeded()
        },completion: { (complete) in
            self.remove()
        })
    }
}
