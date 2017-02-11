//
//  NoticiaTableViewCell.swift
//  app-cut
//
//  Created by Juan Beleño Díaz on 8/02/17.
//  Copyright © 2017 Juan Beleño Díaz. All rights reserved.
//

import UIKit

class NoticiaTableViewCell: UITableViewCell {

    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
