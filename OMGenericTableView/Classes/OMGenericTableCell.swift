//
//  OMGenericTableCell.swift
//  Pods
//
//  Created by HuangKun on 16/5/23.
//
//

import UIKit

public class OMGenericTableCell: UITableViewCell {
    
    public func setup(cellWithMetaData: OMTableCellMetaData) {
        for (key, value) in cellWithMetaData.allCustomOptions {
            self.setValue(value, forKey: key)
        }
        
        self.backgroundColor = cellWithMetaData.cellBackgroundColor
    }
    
    public func handleCellSelection(withMetaData: OMTableCellMetaData) {
        guard withMetaData.cellSelection else { return }
    }

}
