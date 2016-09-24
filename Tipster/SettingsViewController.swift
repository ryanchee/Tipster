//
//  SettingsViewController.swift
//  Tipster
//
//  Created by Ryan Chee on 9/21/16.
//  Copyright © 2016 ryanchee. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    var settingsTipSelected = [Double]()
    var tipWheelData = [Int]()
    var delegate:TipProtocol?
    
    @IBOutlet weak var tipWheel: UIPickerView!
    
    @IBOutlet weak var tipSelected: UISegmentedControl!
    
    func initDataWheel() {
        for (var i = 0; i <= 100; i++) {
            tipWheelData.insert(i, atIndex: i)
        }
    }
    
    @IBAction func updateTipWheelSelection(sender: AnyObject) {
        updateTipWheelControl(tipSelected.selectedSegmentIndex)
    }
    
    func updateTipSelectedControl(index:Int) {
        var percentageString = ""
        for (var i = 0; i < settingsTipSelected.count; i++) {
            tipSelected.selectedSegmentIndex = i
            percentageString = "\(Int(settingsTipSelected[i] * 100))%"
            tipSelected.setTitle(percentageString, forSegmentAtIndex: i)
        }
        tipSelected.selectedSegmentIndex = index
        updateTipWheelControl(index)
    }
    func updateTipWheelControl(index: Int) {
        tipWheel.selectRow(Int(settingsTipSelected[index] * 100), inComponent: 0, animated: true)
    }
    
    //Only 3 values to iterate through. Otherwise would have used a dictionary.
    func findIndexOfSortedPercentage(value:Double) -> Int {
        var i = 0
        for (i = 0; i < settingsTipSelected.count; i++) {
            if (settingsTipSelected[i] == value) {
                return i
            }
        }
        return i
    }
    
    override func willMoveToParentViewController(parent: UIViewController?) {
        delegate?.setSettingsTipValues(settingsTipSelected)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        delegate?.setSettingsTipValues(settingsTipSelected)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipWheel.delegate = self
        tipWheel.dataSource = self
        initDataWheel()
        updateTipSelectedControl(0)        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tipWheelData.count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(tipWheelData[row])%"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let percentageString = "\(Int(tipWheelData[row]))%"
        let decimalPercentage = Double(tipWheelData[row]) / 100
        tipSelected.setTitle(percentageString, forSegmentAtIndex: tipSelected.selectedSegmentIndex)
        settingsTipSelected.removeAtIndex(tipSelected.selectedSegmentIndex)
        settingsTipSelected.insert(decimalPercentage, atIndex: tipSelected.selectedSegmentIndex)
        settingsTipSelected = settingsTipSelected.sort()
        updateTipSelectedControl(findIndexOfSortedPercentage(decimalPercentage))
        return
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
