//
//  ViewController.swift
//  OMGenericTableView
//
//  Created by HuangKun on 05/26/2016.
//  Copyright (c) 2016 HuangKun. All rights reserved.
//

import UIKit
import OMGenericTableView

class ViewController: UIViewController {
    var tableViewController: OMTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let metaData = OMTableCellMetaData(PopoverInformationTableCell.self)?.append("infos", [["1", "one"], ["2", "two"]]).with(cellHeight: 100).with(cellSelection: true).append("handler", OMNPNRClosureBox({ print("12344-----") }))
        let metaData2 = OMTableCellMetaData(PopoverInformationTableCell.self)?.append("infos", [["two", "2"], ["one", "1"]]).append("handler", OMNPNRClosureBox({ print("-----213123-----") }))
        
        tableViewController = OMTableViewController(withCellMetaDatas: metaData!, metaData!, metaData!, metaData!, metaData2!)
        let tableView = tableViewController!.tableView
        tableView.frame = self.view.bounds
        self.view.addSubview(tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

