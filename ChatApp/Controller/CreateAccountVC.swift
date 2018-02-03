//
//  CreateAccountVC.swift
//  ChatApp
//
//  Created by Lucheo Tombini Filho on 26/01/18.
//  Copyright © 2018 Lucheo Tombini Filho. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var userImg: UIImageView!
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light") && bgColor == nil{
                userImg.backgroundColor = UIColor.lightGray
            }
        }
    }

    @IBAction func pickBgColorPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        
        UIView.animate(withDuration: 0.2) {
            self.userImg.backgroundColor = self.bgColor
        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    func setupView() {
        spinner.isHidden = true
        usernameField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
        emailField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
        passwordField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        guard let name = usernameField.text , usernameField.text != "" else {return}
        guard let email = emailField.text , emailField.text != "" else { return }
        guard let pass = passwordField.text , passwordField.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                            }
                        })
                        
                    }
                })
            }
        }
        
    }
    
    
}
