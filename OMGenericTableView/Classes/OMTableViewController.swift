//
//  OMTableViewGenerator.swift
//  Pods
//
//  Created by HuangKun on 16/5/23.
//
//



import UIKit

public class OMTableViewController: NSObject {
    
    public var tableView: UITableView!
    var allCellMetaDatas: [OMTableCellMetaData]
    
    public init(withCellMetaDatas: OMTableCellMetaData...) {
        allCellMetaDatas = withCellMetaDatas
        super.init()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: CGRectZero)
        tableView.delegate = self
        tableView.dataSource = self
        for cellMetaData in allCellMetaDatas {
            tableView.registerClass(cellMetaData.currentCellClass, forCellReuseIdentifier: cellMetaData.cellIdentifier)
        }
    }
    
}

extension OMTableViewController: UITableViewDataSource {
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCellMetaDatas.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(allCellMetaDatas[indexPath.row].cellIdentifier, forIndexPath: indexPath)
    }
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return allCellMetaDatas[indexPath.row].cellHeight
    }
}

extension OMTableViewController: UITableViewDelegate {
    public func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let cell = cell as? OMGenericTableCell else { fatalError("this cell must be an instance of OMGenericTableCell") }
        cell.setup(allCellMetaDatas[indexPath.row])
    }
    
    public func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return allCellMetaDatas[indexPath.row].cellSelection
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) as? OMGenericTableCell else { fatalError("this cell must be an instance of OMGenericTableCell") }
        cell.handleCellSelection(allCellMetaDatas[indexPath.row])
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
