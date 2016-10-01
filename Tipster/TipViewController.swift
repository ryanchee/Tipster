//
//  TipViewController.swift
//  Tipster
//
//  Created by Ryan Chee on 9/20/16.
//  Copyright © 2016 ryanchee. All rights reserved.
//

import UIKit

struct UIFields {
    var billTotalNewWidth:CGFloat = 320.0
    var billTotalNewHeight:CGFloat = 100.0
    var billTotalOldWidth:CGFloat = 320.0
    var billTotalOldHeight:CGFloat = 283.0
    var oldTipLabelAlpha:CGFloat = 0
    var oldTipControlAlpha:CGFloat = 0
    var oldTotalLabelAlpha:CGFloat = 0
    var tipLabelAlpha:CGFloat = 2
    var tipControlAlpha:CGFloat = 2
    var totalLabelAlpha:CGFloat = 2
    var textColor:UIColor = UIColor.grayColor()
}


class TipViewController: UIViewController, TipProtocol {
    
    
    @IBOutlet weak var billTotalField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var splitTabUIView: UITableView!
    let defaults = NSUserDefaults.standardUserDefaults()
    let goodCharacters = NSCharacterSet.decimalDigitCharacterSet()
    var tipSelected = [0.15,0.18,0.2]
    var billTotal = 0.0
    var tipIndex = 0
    var lastSavedDate = NSDate()
    var initialized = false
    var currencyFormat = NSNumberFormatter()
    var uifields = UIFields()

    
    @IBAction func onScreenTap(sender: AnyObject) {
    //    view.endEditing(true)
    }

    @IBAction func calculateTip(sender: AnyObject) {
        let bill = getbillTotalField()
        let tip = bill * tipSelected[tipControl.selectedSegmentIndex]
        let total = bill + tip
        tipLabel.text = currencyFormatter(tip)
        totalLabel.text = currencyFormatter(total)
        billTotal = bill
    }
    
    @IBAction func userInputReceived(sender: AnyObject) {
        let bill = getbillTotalField()
        if (bill == 0.0) {
            UIView.animateWithDuration(0.1, animations: {
                self.billTotalField.frame.size.height = self.uifields.billTotalOldHeight
            })
            tipLabel.alpha = 0
            tipControl.alpha = 0
            totalLabel.alpha = 0
        } else {
            UIView.animateWithDuration(0.1, animations: {
                self.billTotalField.frame.size.height = self.uifields.billTotalNewHeight
            })
            tipLabel.alpha = 2
            tipControl.alpha = 2
            totalLabel.alpha = 2
        }
    }
    @IBOutlet var shakeDetected: UIView!
    
    func getbillTotalField() ->Double {
        var bill = 0.0
        if !billTotalField.text!.isEmpty {
            var billTotalText = billTotalField.text
            billTotalText = billTotalText?.stringByReplacingOccurrencesOfString("\(currencyFormat.currencySymbol)", withString: "")
            billTotalText = billTotalText?.stringByReplacingOccurrencesOfString("\(currencyFormat.currencyGroupingSeparator)", withString: "")
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
    
    func currencyFormatter(numberToFormat: Double) -> String {
        currencyFormat.usesGroupingSeparator = true
        currencyFormat.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormat.locale = NSLocale.currentLocale()
        return currencyFormat.stringFromNumber(numberToFormat)!
    }
    
    //Set all values for UI to default.
    func setDefaultValues() {
        defaults.setObject(tipSelected, forKey: "tipPercetageArray")
        billTotal = 0.0
        defaults.setDouble(billTotal, forKey: "billTotal")
        tipIndex = 0
        defaults.setInteger(tipIndex, forKey: "tipIndex")
        defaults.setObject(uifields.billTotalOldHeight, forKey: "billTotalFrameHeight")
        defaults.setObject(uifields.oldTipLabelAlpha, forKey: "tipLabelAlpha")
        defaults.setObject(uifields.oldTipControlAlpha, forKey: "tipControlAlpha")
        defaults.setObject(uifields.oldTotalLabelAlpha, forKey: "totalLabelAlpha")
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
        defaults.setObject(billTotalField.frame.size.height, forKey: "billTotalFrameHeight")
        defaults.setObject(tipLabel.alpha, forKey: "tipLabelAlpha")
        defaults.setObject(tipControl.alpha, forKey: "tipControlAlpha")
        defaults.setObject(totalLabel.alpha, forKey: "totalLabelAlpha")
        defaults.synchronize()
    }
    
    //Load the saved values
    func loadState() {
        print("loading state")
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
            billTotalField.text = String(format: "%.2f", billTotal)
        } else {
            billTotalField.text = ""
        }
        let height = defaults.objectForKey("billTotalFrameHeight")
        if (height != nil) {
            UIView.animateWithDuration(0.1, animations: {
                self.billTotalField.frame.size.height = height as! CGFloat
            })
        }
        tipIndex = defaults.integerForKey("tipIndex")
        tipLabel.textColor = UIColor.grayColor()
        let tipLabelAlpha = defaults.objectForKey("tipLabelAlpha")
        if (tipLabelAlpha != nil) {
            tipLabel.alpha = tipLabelAlpha as! CGFloat
        } else {
            tipLabel.alpha = uifields.oldTipLabelAlpha
        }
        let tipControlAlpha = defaults.objectForKey("tipControlAlpha")
        if (tipControlAlpha != nil) {
            tipControl.alpha = tipControlAlpha as! CGFloat
        } else {
            tipControl.alpha = uifields.oldTipLabelAlpha
        }
        let totalLabelAlpha = defaults.objectForKey("tipLabelAlpha")
        if (totalLabelAlpha != nil) {
            totalLabel.alpha = totalLabelAlpha as! CGFloat
        } else {
            totalLabel.alpha = uifields.oldTotalLabelAlpha
        }
        viewDidLoad()
    }
    
    func swipeLeft(sender: UISwipeGestureRecognizer) {
        print("swipe left?")
        if (sender.direction == .Left) {
        self.performSegueWithIdentifier("swipeLeft", sender: self)
        }
    }
    
    func randomTipSelection() {
        let randNum = random()%3
        tipControl.selectedSegmentIndex = randNum
        tipControl.setEnabled(true, forSegmentAtIndex: randNum)
        calculateTip(self)
    }
    
    //Function to override to become first responder.
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    //Detect when the shaking stops.
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            randomTipSelection()
        }
        //check if swiped
    }
    
    //Set the billTotalField to be first responder for keyboard.
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        billTotalField.becomeFirstResponder()
    }

    //Load values from controller into view.
    override func viewDidLoad() {
        super.viewDidLoad()
        billTotalField.backgroundColor = UIColor(red: 0, green: 130/255, blue: 40, alpha: 0.3)
        billTotalField.textColor = UIColor.grayColor()
        if (!initialized) {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadState", name: UIApplicationDidBecomeActiveNotification, object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "saveState", name: UIApplicationDidEnterBackgroundNotification, object: nil)
            let swipe = UISwipeGestureRecognizer(target: self, action: "swipeLeft")
            swipe.direction = UISwipeGestureRecognizerDirection.Left
            totalLabel.addGestureRecognizer(swipe)
            initialized = true
            loadState()
        }
        print("viewdidLoad()")
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
        } else if (segue.identifier == "swipeLeft") {
            let splitVC = (segue.destinationViewController as! SplitViewController)
            if !billTotalField.text!.isEmpty {
                var totalLabelText = totalLabel.text
                totalLabelText = totalLabelText?.stringByReplacingOccurrencesOfString("\(currencyFormat.currencySymbol)", withString: "")
                totalLabelText = totalLabelText?.stringByReplacingOccurrencesOfString("\(currencyFormat.currencyGroupingSeparator)", withString: "")
                // Catch errors for non numeric input.
                if (totalLabelText?.rangeOfCharacterFromSet(goodCharacters) != nil) {
                    splitVC.tabTotal = Double(totalLabelText!)!
                }
            }
        }
    }
    
}

