//
//  TipViewController.swift
//  Tipster
//
//  Created by Ryan Chee on 9/20/16.
//  Copyright © 2016 ryanchee. All rights reserved.
//

import UIKit

class TipViewController: UIViewController, TipProtocol {
    
    
    @IBOutlet weak var billTotalField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    let defaults = NSUserDefaults.standardUserDefaults()
    let goodCharacters = NSCharacterSet.decimalDigitCharacterSet()
    var tipSelected = [0.15,0.18,0.2]
    var billTotal = 0.0
    var tipIndex = 0
    
    @IBAction func onScreenTap(sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(sender: AnyObject) {
        let bill = getbillTotalField()
        let tip = bill * tipSelected[tipControl.selectedSegmentIndex]
        let total = bill + tip
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        billTotal = bill
    }

    @IBAction func randomTipSelection(sender: AnyObject) {
        let randNum = random()%3
        tipControl.selectedSegmentIndex = randNum
        tipControl.setEnabled(true, forSegmentAtIndex: randNum)
        calculateTip(self)
    }
    @IBOutlet var shakeDetected: UIView!
    
    func getbillTotalField() ->Double {
        var bill = 0.0
        if !billTotalField.text!.isEmpty {
            var billTotalText = billTotalField.text
            billTotalText = billTotalText?.stringByReplacingOccurrencesOfString("$", withString: "")
            // Catch errors for non numeric input.
            if (billTotalText?.rangeOfCharacterFromSet(goodCharacters) != nil) {
                bill = Double(billTotalText!)!
            }
        }
        return bill
    }
    
    func setSettingsTipValues(value: [Double]) {
        tipSelected = value
        saveState()
        viewDidLoad()
    }
    
    func saveState() {
        print("saving state")
        defaults.setBool(true, forKey: "savedState")
        defaults.setObject(tipSelected, forKey: "tipPercetageArray")
        defaults.setDouble(billTotal, forKey: "billTotal")
        defaults.setInteger(tipIndex, forKey: "tipIndex")
        defaults.synchronize()
    }
    
    func loadState() {
        let savedState = defaults.boolForKey("savedState")
        if savedState {
            print("loadedstate")
            let savedTipArray = defaults.objectForKey("tipPercetageArray") as! [Double]
            tipSelected = savedTipArray
            let savedBillTotal = defaults.doubleForKey("billTotal")
            if (savedBillTotal != 0.0) {
                billTotal = savedBillTotal
                billTotalField.text = String(format: "$%.2f", billTotal)
            }
            let savedTipIndex = defaults.integerForKey("tipIndex")
                tipIndex = savedTipIndex
            }

    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            randomTipSelection(self)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        billTotalField.becomeFirstResponder()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        tipIndex = tipControl.selectedSegmentIndex
        let bill = getbillTotalField()
        billTotal = bill
        saveState()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidLoad()")
        loadState()
        for (var i = 0; i < tipSelected.count; i++) {
            tipControl.selectedSegmentIndex = i
            let percentageString = "\(Int(tipSelected[i] * 100))%"
            tipControl.setTitle(percentageString, forSegmentAtIndex: i)
        }
        tipControl.selectedSegmentIndex = tipIndex
        calculateTip(self)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "SettingsSegue") {
            let settingsVC = (segue.destinationViewController as! SettingsViewController)
            settingsVC.delegate = self
            settingsVC.settingsTipSelected = tipSelected
        }
    }
    
}

