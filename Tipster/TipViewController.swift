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
    var lastSavedDate = NSDate()
    var initialized = false
    
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
    
//    deinit {
//        print("deinit called")
//        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationDidBecomeActiveNotification, object: nil)
//    }
    
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
    
    //Function used to return update values from SettingsController.
    func setSettingsTipValues(value: [Double]) {
        tipSelected = value
        saveState()
        viewDidLoad()
    }
    
    //Set all values for UI to default.
    func setDefaultValues() {
        defaults.setObject(tipSelected, forKey: "tipPercetageArray")
        billTotal = 0.0
        defaults.setDouble(billTotal, forKey: "billTotal")
        tipIndex = 0
        defaults.setInteger(tipIndex, forKey: "tipIndex")
    }
    
    //Save the current values
    func saveState() {
        print("saving state")
        lastSavedDate = NSDate()
        tipIndex = tipControl.selectedSegmentIndex
        let bill = getbillTotalField()
        billTotal = bill
        defaults.setObject(lastSavedDate, forKey: "lastSavedDate")
        defaults.setObject(tipSelected, forKey: "tipPercetageArray")
        defaults.setDouble(billTotal, forKey: "billTotal")
        defaults.setInteger(tipIndex, forKey: "tipIndex")
        defaults.synchronize()
    }
    
    //Load the saved values
    func loadState() {
        print("LOADSTATE CALLED")
        let checkArray = defaults.objectForKey("tipPercetageArray")
        if (checkArray != nil) {
            tipSelected = checkArray as! [Double]
        }
        let checkDate = defaults.objectForKey("lastSavedDate")
        if (checkDate != nil) {
            lastSavedDate = checkDate as! NSDate
        }
        let timeDiff = NSDate().timeIntervalSinceDate(lastSavedDate)
        print("Timediff is: \(timeDiff)")
        if(timeDiff > 60) {
            print("set default values")
            setDefaultValues()
        }
        let savedBillTotal = defaults.doubleForKey("billTotal")
        if (savedBillTotal != 0.0) {
            billTotal = savedBillTotal
            billTotalField.text = String(format: "$%.2f", billTotal)
        } else {
            billTotalField.text = ""
        }
        tipIndex = defaults.integerForKey("tipIndex")
        viewDidLoad()
    }
    
    //Function to override to become first responder.
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    //Detect when the shaking stops.
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            randomTipSelection(self)
        }
    }
    
    //Set the billTotalField to be first responder for keyboard.
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        billTotalField.becomeFirstResponder()
    }

    //Load values from controller into view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (!initialized) {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadState", name: UIApplicationDidBecomeActiveNotification, object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "saveState", name: UIApplicationDidEnterBackgroundNotification, object: nil)
            initialized = true
            print("initialized is \(initialized)")
            loadState()
        }
        print("viewdidLoad()")
        //    loadState()
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
    
    //Function used to pass data to next view controller.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "SettingsSegue") {
            let settingsVC = (segue.destinationViewController as! SettingsViewController)
            settingsVC.delegate = self
            settingsVC.settingsTipSelected = tipSelected
        }
    }
    
}

