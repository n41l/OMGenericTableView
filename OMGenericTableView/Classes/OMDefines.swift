//
//  OMDefines.swift
//  Pods
//
//  Created by HuangKun on 16/5/25.
//
//

import UIKit

public class OMNPNRClosureBox: NSObject {
    var value: () -> ()
    public init(_ withValue: () -> ()) {
        value = withValue
    }
    
    public var unbox: () -> () {
        get {
            return value
        }
    }
}
