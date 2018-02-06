//
//  ChatVC.swift
//  ChatApp
//
//  Created by Lucheo Tombini Filho on 26/01/18.
//  Copyright © 2018 Lucheo Tombini Filho. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var chatLbl: UILabel!
    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
    self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(notif:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNELS_SELECTED, object: nil)
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
        
        
    }
    
    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChanell?.channelTitle ?? ""
        chatLbl.text = "#\(channelName)"
    }
    
    @objc func userDataDidChange(notif: Notification) {
        
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        } else {
            chatLbl.text = "Please Log In"
        }
    }
    
    func onLoginGetMessages() {
        MessageService.instance.findAllChannels { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChanell = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.chatLbl.text = "No Channels yet"
                }
            }
        }
    }
    
    func getMessages() {
        guard let channelId = MessageService.instance.selectedChanell?.id else {return}
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            <#code#>
        }
    }

   
    
}
