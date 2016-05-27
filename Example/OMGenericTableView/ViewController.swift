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
    var tapMePopover: Popover?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.882, green: 0.922, blue: 0.957, alpha: 1.00)
        setupPopover()
        setupTapMeButton()
        setupYourCustomTableView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupTapMeButton() {
        tapMeButton.layer.cornerRadius = 4
        tapMeButton.backgroundColor = UIColor(red: 0.118, green: 0.125, blue: 0.157, alpha: 1.00)
        tapMeButton.tintColor = UIColor.whiteColor()
    }
    
    private func setupYourCustomTableView() {
        let informationCellMetaData = OMTableCellMetaData(PopoverInformationTableCell.self)?.append("infos", [["Diarys", "10"], ["Attachments", "5"], ["Characters", "666"]]).with(cellHeight: 70).with(cellCustomSeparatorShow: true)
        
        let defaultCellMetaData_1 = OMTableCellMetaData(PopoverDefaultTableCell.self)?.append("iconImageName", "testIcon").append("title", "Push~").with(cellHeight: 60).with(cellSelection: true).append("selectionHanlder", OMNPNRClosureBox({ [unowned self] in
            self.tapMePopover?.dismiss()
            self.performSegueWithIdentifier("Show", sender: nil)
        }))
        
        tableViewController = OMTableViewController(withCellMetaDatas:informationCellMetaData!, defaultCellMetaData_1!)
        let tableView = tableViewController!.tableView
        tableView.separatorStyle = .None
        tableView.frame = CGRect(x: 0, y: 0, width: (self.view.bounds.width - 10), height: tableView.bounds.height)
    }
    
    private func setupPopover() {
        let options:[PopoverOption] = [
            .Type(.Up),
            .CornerRadius(4),
            .SideEdge(10),
            .Color(UIColor(red: 0.596, green: 0.596, blue: 0.596, alpha: 1.00))
        ]
        tapMePopover = Popover(options: options, showHandler: nil, dismissHandler: nil)
    }
    
    @IBAction func tapMeButtonDidPressed(sender: AnyObject) {
        tapMePopover?.show(tableViewController!.tableView, fromView: tapMeButton)
    }
    
}

