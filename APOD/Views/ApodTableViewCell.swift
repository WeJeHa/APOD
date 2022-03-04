//
//  ApodTableViewCell.swift
//  APOD
//
//  Created by William Johanssen Hutama on 01/03/22.
//

import UIKit

class ApodTableViewCell: UITableViewCell {
    @IBOutlet weak var ApodCellLabel: UILabel!
    @IBOutlet weak var ApodCellImage: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
    }
}
