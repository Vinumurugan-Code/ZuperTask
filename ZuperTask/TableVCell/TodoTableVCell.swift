//
//  TodoTableVCell.swift
//  ZuperTask
//
//  Created by vinumurugan E on 18/03/22.
//

import UIKit

class TodoTableVCell: UITableViewCell {
    
    @IBOutlet weak var imgV: UIImageView!
    
    @IBOutlet weak var lbl1: UILabel!
        
    @IBOutlet weak var lbl2: UILabel!
    
    @IBOutlet weak var radioBtn: UIButton!
    
    var info : Info? {
        didSet {
            lbl1.text = info?.title
            lbl2.text = "  \(info?.tag ?? "")  "
            if info?.priority == Priority.low {
                imgV.backgroundColor = .yellow
            } else if info?.priority == Priority.medium {
                imgV.backgroundColor = .green
            } else {
                imgV.backgroundColor = .red
            }
            if info?.is_completed ?? Bool(){
                radioBtn.setImage(UIImage(systemName: "checkmark.seal"), for: .normal)
                radioBtn.tintColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
            } else {
                radioBtn.setImage(UIImage(systemName: "circle"), for: .normal)
                radioBtn.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

