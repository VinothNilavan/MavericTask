//
//  ItemTableViewCell.swift
//  MavericTask
//
//  Created by Vinoth on 06/05/21.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgImageView: UIImageView! {
        didSet {
            imgImageView.layer.cornerRadius = 5.0
            imgImageView.clipsToBounds      = true
            imgImageView.contentMode        = .scaleAspectFill
            imgImageView.layer.borderWidth  = 1.0
            imgImageView.layer.borderColor  = UIColor.lightGray.cgColor
        }
    }
    var model = TvModel () {
        didSet {
            titleLbl.text      = model.title ?? ""
            imgImageView.image = UIImage(named: model.imageUrl ?? "")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        imgImageView.image = nil
    }
}
