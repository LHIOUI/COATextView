//
//  COATextViewHeader.swift
//  COATextView
//
//  Created by coyote on 19/02/16.
//  Copyright © 2016 coyote. All rights reserved.
//

import UIKit

class COATextViewHeader: UITableViewController {

    @IBOutlet weak var undoButton: UIButton!
    var delegate: COATextViewHeaderProtocol!
    var anonymCellHidden = true
    override func viewDidLoad() {
        super.viewDidLoad()
        undoButton.layer.borderColor = UIColor(netHex : 0x6FA6FF).CGColor
    }
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if(anonymCellHidden){
            delegate.anonymeCellHidden(anonymCellHidden)
        }
    }
    @IBAction func undoAnonyme(sender: UIButton) {
        anonymCellHidden = true
        delegate.anonymeCellHidden(anonymCellHidden)
        self.tableView.reloadData()
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row == 0 && anonymCellHidden){
            return 0.0
        }else{
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


//Protocol Header
protocol COATextViewHeaderProtocol{
    func anonymeCellHidden(value:Bool)
}
