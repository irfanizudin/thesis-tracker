//
//  ProgressCell.swift
//  ThesisTracker
//
//  Created by Irfan Izudin on 07/04/22.
//

import UIKit

class ProgressCell: UITableViewCell {

    static let identifier = "ProgressCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ProgressCell", bundle: nil)
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeDone: UILabel!
    @IBOutlet weak var timeTarget: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var emoticonImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
