//
//  TodoTagTableViewCell.swift
//  ZuperTask
//
//  Created by Murugan M on 19/03/22.
//

import UIKit

class TodoTagTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgV: UIImageView!
    
    @IBOutlet weak var lbl1: UILabel!
            
    var info : Info? {
        didSet {
            lbl1.text = info?.title
            if info?.priority == Priority.low {
                imgV.backgroundColor = .yellow
            } else if info?.priority == Priority.medium {
                imgV.backgroundColor = .green
            } else {
                imgV.backgroundColor = .red
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
