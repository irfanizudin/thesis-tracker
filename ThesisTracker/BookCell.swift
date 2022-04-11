//
//  BookCell.swift
//  ThesisTracker
//
//  Created by Irfan Izudin on 08/04/22.
//

import UIKit

class BookCell: UITableViewCell {

    static let identifier = "BookCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "BookCell", bundle: nil)
    }

    @IBOutlet weak var taskLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
