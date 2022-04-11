//
//  CompletionCell.swift
//  ThesisTracker
//
//  Created by Irfan Izudin on 07/04/22.
//

import UIKit

class CompletionCell: UITableViewCell {

    static let identifier = "CompletionCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CompletionCell", bundle: nil)
    }
    
    @IBOutlet weak var symbol: UIImageView!
    @IBOutlet weak var progressName: UILabel!
    @IBOutlet weak var notStarted: UILabel!
    @IBOutlet weak var inProgress: UILabel!
    @IBOutlet weak var done: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
