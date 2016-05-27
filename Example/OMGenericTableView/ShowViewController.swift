//
//  ShowViewController.swift
//  OMGenericTableView
//
//  Created by HuangKun on 16/5/27.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {

    @IBOutlet weak var dimissMeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDismissButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupDismissButton() {
        dimissMeButton.layer.cornerRadius = 4
        dimissMeButton.backgroundColor = UIColor(red: 0.118, green: 0.125, blue: 0.157, alpha: 1.00)
        dimissMeButton.tintColor = UIColor.whiteColor()
    }

    @IBAction func dismissMeButtonDidPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
