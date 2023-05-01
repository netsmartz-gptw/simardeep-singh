//
//  BaseVC.swift
//  SampleApp
//

import UIKit
import Foundation

class BaseVC: UIViewController {
    var shouldAnimateWhilePop = true
    var showBackConfirmation = true
    
    @IBInspectable var showNavBar:Bool = true
        {
        didSet
        {
            navigationController?.setNavigationBarHidden(!showNavBar, animated: false)
        }
    }
    @IBOutlet weak var lcViewBottom: NSLayoutConstraint!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navBarSetup()
    }
    
    func navBarSetup()
    {
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().tintColor = UIColor.black
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let backButton = UIBarButtonItem.init(image: UIImage(named: "ic_back"), style: .plain, target: self, action: #selector(backAction))
        if self.isKind(of: RiskAssessmentVC.self) {
            self.navigationItem.setHidesBackButton(true, animated: false)
        } else {
        self.navigationItem.leftBarButtonItem = backButton
        }
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font:getFontWithTag(tag: "1254"),NSAttributedString.Key.foregroundColor : colorDarkGrey]
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    @objc func backAction()
    {
        self.navigationController?.popViewController(animated: shouldAnimateWhilePop)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        if (lcViewBottom) != nil
        {
            NotificationCenter.default.addObserver(self, selector: #selector(notifyKeyboardWillChangeFrame(notification:)), name: UIWindow.keyboardWillChangeFrameNotification, object: nil)
        }
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        if showNavBar == false
        {
            navigationController?.setNavigationBarHidden(true, animated: false)
        }
        else
        {
            navBarSetup()
            navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        view.endEditing(true)
        
        ErrorView.sharedErrorView.remove()
        
        if (lcViewBottom) != nil
        {
            lcViewBottom.constant = 0
            
            NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillChangeFrameNotification, object: nil)
        }
    }
    
    @objc func notifyKeyboardWillChangeFrame(notification: NSNotification)
    {
        let frame =  notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        if (lcViewBottom) != nil
        {
            lcViewBottom.constant = returnBottomSpacingForKeyboard() - frame.origin.y
        }

        UIView.animate(withDuration: animationDuration)
        {
            self.view.layoutIfNeeded()
        }
    }
    
    func returnBottomSpacingForKeyboard() -> CGFloat
    {
        if (lcViewBottom) != nil
        {
            var vwBottomView:UIView?
            
            if lcViewBottom.firstAttribute == NSLayoutConstraint.Attribute.top
            {
                vwBottomView = lcViewBottom.firstItem as? UIView
            }
            else if lcViewBottom.secondAttribute == NSLayoutConstraint.Attribute.top
            {
                vwBottomView = lcViewBottom.secondItem as? UIView
            }
            if  let vwConstraint = vwBottomView
            {
                return vwConstraint.frame.origin.y
            }
            else
            {
                return self.view.frame.size.height
            }
        }
        
        return self.view.frame.size.height
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
