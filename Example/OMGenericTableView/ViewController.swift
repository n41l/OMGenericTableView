//
//  ViewController.swift
//  OMGenericTableView
//
//  Created by HuangKun on 05/26/2016.
//  Copyright (c) 2016 HuangKun. All rights reserved.
//

import UIKit
import OMGenericTableView
import Popover

class ViewController: UIViewController {
    
    @IBOutlet weak var tapMeButton: UIButton!
    
    var tableViewController: OMTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTapMeButton()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupTapMeButton() {
        tapMeButton.layer.cornerRadius = 4
        tapMeButton.backgroundColor = UIColor(red: 0.000, green: 0.627, blue: 0.745, alpha: 1.00)
        tapMeButton.tintColor = UIColor.whiteColor()
    }
    
    private func setupYourCustomTableView() {
        let informationCellMetaData = OMTableCellMetaData(PopoverInformationTableCell.self)?.append("infos", [["1", "one"], ["2", "two"]]).with(cellHeight: 100).with(cellSelection: true).append("handler", OMNPNRClosureBox({ print("12344-----") })).with(true)
        
        tableViewController = OMTableViewController(withCellMetaDatas: informationCellMetaData!)
        let tableView = tableViewController!.tableView
        tableView.separatorStyle = .None
        tableView.frame = CGRect(x: 0, y: 0, width: (self.view.bounds.width - 10), height: tableView.bounds.height)
    }
    
    @IBAction func tapMeButtonDidPressed(sender: AnyObject) {
        let options:[PopoverOption] = [
            .Type(.Up),
            .CornerRadius(4),
            .SideEdge(10)
        ]
        let popover = Popover(options: options, showHandler: nil, dismissHandler: nil)
        popover.show(tableViewController!.tableView, fromView: tapMeButton)
    }
    
}

