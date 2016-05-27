//
//  OMTableCellMetaData.swift
//  Pods
//
//  Created by HuangKun on 16/5/22.
//
//

import UIKit

//public enum OMGenericTableCellStandardOption {
//    case CellHeight(value: CGFloat)
//    case CellBackgroundColor(value: UIColor)
//    case Unit(value: [OMGenericTableCellStandardOption])
//}

public class OMTableCellMetaData: NSObject {
    
    let cellIdentifier: String
    let cellNibName: String
    
    let currentCellClass: AnyClass
    
    var allCustomOptions: [String: AnyObject]
    
    public var cellHeight: CGFloat = 60
    public var cellBackgroundColor: UIColor = UIColor.whiteColor()
    public var cellSelection: Bool = true
    
    public init?(_ withClass: AnyClass) {
        guard var className = String.fromCString(class_getName(withClass)) else { return nil }
        
        if let dotIndex = className.characters.indexOf(".") {
            let range = dotIndex.successor()..<className.endIndex
            className = className[range]
        }
        
        cellIdentifier = className
        cellNibName = className
        currentCellClass = withClass
        allCustomOptions = [String: AnyObject]()
        super.init()
    }
    
    public func append(customOption: String, _ value: AnyObject) -> OMTableCellMetaData {
        allCustomOptions.updateValue(value, forKey: customOption)
        return self
    }
    
    public func append(customOptions: [String: AnyObject]) -> OMTableCellMetaData {
        for (name, value) in customOptions {
            allCustomOptions.updateValue(value, forKey: name)
        }
        return self
    }
    
    public func with(cellHeight height: CGFloat) -> OMTableCellMetaData {
        self.cellHeight = height
        return self
    }
    
    public func with(cellBackgroundColor color: UIColor) -> OMTableCellMetaData {
        self.cellBackgroundColor = color
        return self
    }
    
    public func with(cellSelection flag: Bool) -> OMTableCellMetaData {
        self.cellSelection = flag
        return self
    }
    
    public subscript(index: Int) -> (String, AnyObject)? {
        return allCustomOptions.enumerate().filter { $0.index == index }.first?.element
    }
}
