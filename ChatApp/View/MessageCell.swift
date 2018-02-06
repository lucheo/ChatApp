//
//  MessageCell.swift
//  ChatApp
//
//  Created by Lucheo Tombini Filho on 06/02/18.
//  Copyright © 2018 Lucheo Tombini Filho. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBodyLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userImg: CircleImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(message: Message) {
        messageBodyLbl.text = message.message
        username.text = message.userName
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
    }

}
