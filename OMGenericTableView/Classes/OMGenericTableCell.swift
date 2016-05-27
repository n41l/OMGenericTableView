//
//  OMGenericTableCell.swift
//  Pods
//
//  Created by HuangKun on 16/5/23.
//
//

import UIKit

public class OMGenericTableCell: UITableViewCell {
    
    public lazy var cellSeparatorLine: UIView = {
        let result = UIView(frame: CGRect(x: 0, y: self.bounds.height - 1, width: self.bounds.width, height: 1))
        result.backgroundColor = UIColor(red: 0.529, green: 0.529, blue: 0.529, alpha: 1.00)
        return result
    }()
    
    public func setup(cellWithMetaData: OMTableCellMetaData) {
        for (key, value) in cellWithMetaData.allCustomOptions {
            self.setValue(value, forKey: key)
        }
        
        self.backgroundColor = cellWithMetaData.cellBackgroundColor
        
        if cellWithMetaData.cellCustomSeparatorShow {
            self.contentView.addSubview(cellSeparatorLine)
        }
    }
    
    public func handleCellSelection(withMetaData: OMTableCellMetaData) {
        guard withMetaData.cellSelection else { return }
    }

}
