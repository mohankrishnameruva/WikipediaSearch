//
//  ResultTableViewCell.swift
//  WikipediaSearch
//
//  Created by Mohan on 20/07/18.
//  Copyright © 2018 Mohan. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var ThumbnailView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
