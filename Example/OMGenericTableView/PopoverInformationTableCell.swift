//
//  PopoverInformationTableCell.swift
//  GridDiary
//
//  Created by HuangKun on 16/5/11.
//  Copyright © 2016年 Sumi Interactive. All rights reserved.
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
    
    var testStr: String = ""
    
    private var _backInfos: [(title: String, content: String)] = []
    
//    override class var cellNibName: String {
//        get {
//            return "PopoverInformationTableCell"
//        }
//    }
//    override class var cellIdentifier: String {
//        get {
//            return "PopoverInformationTableCell"
//        }
//    }
//    
//    override class var canBeSelect: Bool {
//        get {
//            return false
//        }
//    }
    
    var handler: OMNPNRClosureBox?
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.backgroundColor = UIColor.gd_lineColor()
    }
    
    override func handleCellSelection(withMetaData: OMTableCellMetaData) {
        super.handleCellSelection(withMetaData)
        handler?.unbox()
    }
    
    override func setup(cellWithMetaData: OMTableCellMetaData) {
        resetView()
        super.setup(cellWithMetaData)
        
        var views: [String: AnyObject] = [:]
        informationLabels = _backInfos.enumerate().map {index, data in
            
            let result = UILabel()
            result.text = data.content + " " + data.title
//            result.font = UIFont.gd_smallGridBodyFont()
//            result.textColor = UIColor.gd_contentIconColor()
//            result.backgroundColor = UIColor.gd_lineColor()
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
            result.backgroundColor = UIColor.redColor()
            
//            if index == 0 || index == _backInfos.count {
//                result.hidden = true
//            }
            
            separatorStr.append("separator_" + String(index))
            views.updateValue(result, forKey: "separator_" + String(index))
            result.translatesAutoresizingMaskIntoConstraints = false
            let width = NSLayoutConstraint(item: result, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute(rawValue: 0)!, multiplier: 1, constant: 1)
            let height = NSLayoutConstraint(item: result, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute(rawValue: 0)!, multiplier: 1, constant: self.bounds.height * 0.5)
            separatorViewsWidthConstriants.append(width)
            separatorViewsHightConStraints.append(height)
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
        
        print(horizontalString)
        
        let baseHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(horizontalString, options: .AlignAllCenterY, metrics: nil, views: views)
        allCustomConstraints = baseHorizontalConstraints + separatorViewsWidthConstriants + separatorViewsHightConStraints
        allCustomConstraints += [centerY]
        _ = allCustomConstraints.map { $0.active = true }
        //        NSLayoutConstraint.activateConstraints(allCustomConstraints)
        
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
    
//    func setupInformateionCell(withInfo: [(title: String, content: String)]) {
//        
//        resetView()
//        
//        var views: [String: AnyObject] = [:]
//        informationLabels = withInfo.enumerate().map {index, data in
//            
//            let result = UILabel()
//            result.text = data.content + " " + data.title
//            result.font = UIFont.gd_smallGridBodyFont()
//            result.textColor = UIColor.gd_contentIconColor()
//            result.backgroundColor = UIColor.gd_lineColor()
//            result.textAlignment = .Center
//            result.sizeToFit()
//            result.translatesAutoresizingMaskIntoConstraints = false
//            contentsStr.append("label_" + String(index))
//            views.updateValue(result, forKey: "label_" + String(index))
//            self.addSubview(result)
//            return result
//        }
//        
//        for (index, label) in informationLabels!.enumerate() {
//            label.setContentHuggingPriority(Float(label.bounds.width), forAxis: .Horizontal)
//        }
//        
//        let referencelabel = informationLabels?.first
//        
//        let centerY = NSLayoutConstraint(item: referencelabel!, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0)
//        
//        var separatorViewsWidthConstriants = [NSLayoutConstraint]()
//        var separatorViewsHightConStraints = [NSLayoutConstraint]()
//        
//        separatorViews = (0..<(withInfo.count + 1)).map { index in
//            let result = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: self.bounds.height * 0.6))
//            result.backgroundColor = UIColor.gd_contentIconColor()
//            
//            if index == 0 || index == withInfo.count {
//                result.hidden = true
//            }
//            
//            separatorStr.append("separator_" + String(index))
//            views.updateValue(result, forKey: "separator_" + String(index))
//            result.translatesAutoresizingMaskIntoConstraints = false
//            let width = NSLayoutConstraint(item: result, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute(rawValue: 0)!, multiplier: 1, constant: 1)
//            let height = NSLayoutConstraint(item: result, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute(rawValue: 0)!, multiplier: 1, constant: self.bounds.height * 0.5)
//            separatorViewsWidthConstriants.append(width)
//            separatorViewsHightConStraints.append(height)
//            self.addSubview(result)
//            return result
//        }
//        
//        var horizontalString = (0..<separatorStr.count).reduce("H:|-(10)-") { (result, index) -> String in
//            let zeroStr = "-(10)-"
//            
//            func convert(str: String) -> String {
//                return "[" + str + "]"
//            }
//            
//            guard index < contentsStr.count else { return result + convert(separatorStr[index]) }
//            return result + convert(separatorStr[index]) + zeroStr + convert(contentsStr[index]) + zeroStr
//        }
//        
//        horizontalString += "-(10)-|"
//        
//        print(horizontalString)
//        
//        let baseHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(horizontalString, options: .AlignAllCenterY, metrics: nil, views: views)
//        allCustomConstraints = baseHorizontalConstraints + separatorViewsWidthConstriants + separatorViewsHightConStraints
//        allCustomConstraints += [centerY]
//        _ = allCustomConstraints.map { $0.active = true }
////        NSLayoutConstraint.activateConstraints(allCustomConstraints)
//        
//        bottomLineView.frame = CGRect(x: 0, y: self.bounds.height - 1, width: self.bounds.width, height: 1)
//        bottomLineView.backgroundColor = UIColor.gd_lineColor()
//        self.addSubview(bottomLineView)
//        self.setNeedsDisplay()
//    }
//    
//    func resetView() {
//        _ = allCustomConstraints.map { $0.active = false }
//        allCustomConstraints.removeAll()
//        contentsStr.removeAll()
//        separatorStr.removeAll()
//        
//        guard let labels = informationLabels, separator = separatorViews else { return }
//        _ = labels.map { $0.removeFromSuperview() }
//        _ = separator.map { $0.removeFromSuperview() }
//        
//        informationLabels?.removeAll()
//        separatorViews?.removeAll()
//    }
    
}
