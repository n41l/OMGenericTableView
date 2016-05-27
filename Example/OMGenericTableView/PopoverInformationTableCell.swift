//
//  PopoverInformationTableCell.swift
//  OMGenericTableView
//
//  Created by HuangKun on 16/5/27.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import OMGenericTableView

class PopoverInformationTableCell: OMGenericTableCell {
    
    private var informationLabels: [UILabel]?
    private var separatorViews: [UIView]?
    private var contentsStr: [String] = []
    private var separatorStr: [String] = []
    
    private var allCustomConstraints: [NSLayoutConstraint] = []
    
    var infos: [[String]] = [] {
        didSet {
            _backInfos = infos.map { ($0.first!, $0.last!) }
        }
    }
    
    private var _backInfos: [(title: String, content: String)] = []
    
    //    var handler: OMNPNRClosureBox?
    
    //    override func handleCellSelection(withMetaData: OMTableCellMetaData) {
    //        super.handleCellSelection(withMetaData)
    //        handler?.unbox()
    //    }
    
    override func setup(cellWithMetaData: OMTableCellMetaData) {
        super.setup(cellWithMetaData)
        
        self.backgroundColor = UIColor(red: 0.467, green: 0.467, blue: 0.467, alpha: 1.00)
        resetView()
        var views: [String: AnyObject] = [:]
        informationLabels = _backInfos.enumerate().map {index, data in
            
            let result = UILabel()
            result.text = data.content + " " + data.title
            result.textColor = UIColor(red: 0.753, green: 0.753, blue: 0.753, alpha: 1.00)
            result.font = UIFont.systemFontOfSize(15)
            result.textAlignment = .Center
            result.sizeToFit()
            result.translatesAutoresizingMaskIntoConstraints = false
            contentsStr.append("label_" + String(index))
            views.updateValue(result, forKey: "label_" + String(index))
            self.addSubview(result)
            return result
        }
        
        for (index, label) in informationLabels!.enumerate() {
            label.setContentHuggingPriority(Float(label.bounds.width), forAxis: .Horizontal)
        }
        
        let referencelabel = informationLabels?.first
        
        let centerY = NSLayoutConstraint(item: referencelabel!, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0)
        
        var separatorViewsWidthConstriants = [NSLayoutConstraint]()
        var separatorViewsHightConStraints = [NSLayoutConstraint]()
        
        separatorViews = (0..<(_backInfos.count + 1)).map { index in
            let result = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: self.bounds.height * 0.6))
            result.backgroundColor = UIColor(red: 0.765, green: 0.765, blue: 0.765, alpha: 1.00)
            
            separatorStr.append("separator_" + String(index))
            views.updateValue(result, forKey: "separator_" + String(index))
            result.translatesAutoresizingMaskIntoConstraints = false
            let width = NSLayoutConstraint(item: result, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute(rawValue: 0)!, multiplier: 1, constant: 1)
            let height = NSLayoutConstraint(item: result, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute(rawValue: 0)!, multiplier: 1, constant: self.bounds.height * 0.5)
            separatorViewsWidthConstriants.append(width)
            separatorViewsHightConStraints.append(height)
            
            if index == 0 || index == _backInfos.count {
                result.alpha = 0
            }
            
            self.addSubview(result)
            return result
        }
        
        var horizontalString = (0..<separatorStr.count).reduce("H:|-(10)-") { (result, index) -> String in
            let zeroStr = "-(10)-"
            
            func convert(str: String) -> String {
                return "[" + str + "]"
            }
            
            guard index < contentsStr.count else { return result + convert(separatorStr[index]) }
            return result + convert(separatorStr[index]) + zeroStr + convert(contentsStr[index]) + zeroStr
        }
        
        horizontalString += "-(10)-|"
        
        
        let baseHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(horizontalString, options: .AlignAllCenterY, metrics: nil, views: views)
        allCustomConstraints = baseHorizontalConstraints + separatorViewsWidthConstriants + separatorViewsHightConStraints
        allCustomConstraints += [centerY]
        _ = allCustomConstraints.map { $0.active = true }
        
        //        bottomLineView.frame = CGRect(x: 0, y: self.bounds.height - 1, width: self.bounds.width, height: 1)
        //        bottomLineView.backgroundColor = UIColor.gd_lineColor()
        //        self.addSubview(bottomLineView)
        self.setNeedsDisplay()
    }
    
    private func resetView() {
        _ = allCustomConstraints.map { $0.active = false }
        allCustomConstraints.removeAll()
        contentsStr.removeAll()
        separatorStr.removeAll()
        
        guard let labels = informationLabels, separator = separatorViews else { return }
        _ = labels.map { $0.removeFromSuperview() }
        _ = separator.map { $0.removeFromSuperview() }
        
        informationLabels?.removeAll()
        separatorViews?.removeAll()
    }
    
}
