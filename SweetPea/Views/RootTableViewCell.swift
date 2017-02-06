//
//  RootTableViewCell.swift
//  SweetPea
//
//  Created by Ben Murphy on 1/16/17.
//  Copyright © 2017 Constellation Software. All rights reserved.
//

import UIKit

class RootTableViewCell: UITableViewCell {


    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeTitle: UILabel!
    @IBOutlet weak var episodeDate: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
