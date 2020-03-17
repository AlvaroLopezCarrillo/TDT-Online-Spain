//
//  ChannelsTableViewCell.swift
//  TDT Online España
//
//  Created by Álvaro López Carrillo on 14/01/2020.
//  Copyright © 2020 Iberian Apps. All rights reserved.
//

import UIKit

class ChannelsTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var logo: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
