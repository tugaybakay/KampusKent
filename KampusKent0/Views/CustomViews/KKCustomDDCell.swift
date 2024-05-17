//
//  KKCustomDDCell.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//

import UIKit
import DropDown

class KKCustomDDCell: DropDownCell {
    
    @IBOutlet var myImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        myImageView.contentMode = .scaleAspectFit
        backgroundColor = .systemBackground
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
