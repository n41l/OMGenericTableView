//
//  PopoverDefaultTableCell.swift
//  OMGenericTableView
//
//  Created by HuangKun on 16/5/27.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

import UIKit
import OMGenericTableView

class PopoverDefaultTableCell: OMGenericTableCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var iconImageName: String?
    var title: String?
    var selectionHanlder: OMNPNRClosureBox?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setup(cellWithMetaData: OMTableCellMetaData) {
        super.setup(cellWithMetaData)
        
        guard let iconImageName = iconImageName, title = title else { fatalError("wrong meta data") }
        let image = UIImage(named: iconImageName)?.imageWithRenderingMode(.AlwaysTemplate)
        iconImageView.image = image
        iconImageView.tintColor = UIColor(red: 0.957, green: 0.957, blue: 0.957, alpha: 1.00)
        iconImageView.sizeToFit()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFontOfSize(16)
        titleLabel.textColor = UIColor(red: 0.957, green: 0.957, blue: 0.957, alpha: 1.00)
        self.backgroundColor = UIColor(red: 0.596, green: 0.596, blue: 0.596, alpha: 1.00)
        titleLabel.sizeToFit()
        
        self.setNeedsDisplay()
    }
    
    override func handleCellSelection(withMetaData: OMTableCellMetaData) {
        selectionHanlder?.unbox()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
