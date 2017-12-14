//
//  SectionFooter.swift
//  FeederReader
//
//  Created by Admin on 10/14/17.
//  Copyright © 2017 Sheeja. All rights reserved.
//

import UIKit

protocol SectionFooterDelegate {
    func sectionFooter(_ sectionFooter: SectionFooter, didSelectAt index: Int)
}

class SectionFooter: UITableViewCell {
    
    @IBOutlet weak var sectionFooterButton: UIButton!
    @IBOutlet weak var sectionFooterLabel: UILabel!
    var delegate: SectionFooterDelegate?
    var index: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didSelectSectionFooter(_ sender: UIButton) {
        self.delegate?.sectionFooter(self, didSelectAt: self.index)
    }
}
