//
//  UICell.swift
//  RED NOTE
//
//  Created by andrey.belyaev on 02/12/2018.
//  Copyright © 2018 Julika Orekhova Corp. All rights reserved.
//

import UIKit

class UICell: UITableViewCell {

    @IBOutlet weak var titleNote: UILabel!
    @IBOutlet weak var dateNote: UILabel!    
    @IBOutlet weak var firstPictureNote: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillCell(with model: NoteRealm) {
        firstPictureNote.layer.cornerRadius = 200
        firstPictureNote.layer.masksToBounds = true
        self.titleNote.text = model.title
        self.dateNote.text = model.date
    }
}
