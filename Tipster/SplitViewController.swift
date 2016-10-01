//
//  SplitViewController.swift
//  Tipster
//
//  Created by Ryan Chee on 9/30/16.
//  Copyright © 2016 ryanchee. All rights reserved.
//

import UIKit

class SplitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tipTotalLabel: UILabel!
    @IBOutlet weak var uiTableView: UITableView!
    
    var tabTotal:Double = 0.0
    var currencyFormat = NSNumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipTotalLabel.text = currencyFormatter(tabTotal)
        print(tipTotalLabel.text)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func currencyFormatter(numberToFormat: Double) -> String {
        currencyFormat.usesGroupingSeparator = true
        currencyFormat.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormat.locale = NSLocale.currentLocale()
        return currencyFormat.stringFromNumber(numberToFormat)!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
