//
//  ViewController.swift
//  TipCalculator
//
//  Created by Main Account on 7/7/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var totalTextField : UITextField!
  @IBOutlet var taxPctSlider : UISlider!
  @IBOutlet var taxPctLabel : UILabel!
  @IBOutlet var resultsTextView : UITextView!
  
  let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
  
  func refreshUI() {
    totalTextField.text = String(format: "%0.2f", tipCalc.total)
    // 2
    taxPctSlider.value = Float(tipCalc.taxPct) * 100.0
    // 3
    taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
    // 4
    resultsTextView.text = ""
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    refreshUI()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func calculateTapped(sender: AnyObject) {
    updateTipResults()
  }
  
  func updateTipResults() {
    tipCalc.total = Double((totalTextField.text as NSString).doubleValue)
    let possibleTips = tipCalc.returnPossibleTips()
    var results = ""
    var keys = Array(possibleTips.keys)
    sort(&keys)
    for tipPct in keys {
      let tipValue = possibleTips[tipPct]!
      let formattedTipValue = String(format: "%.2f", tipValue)
      results += "\(tipPct)%: \(formattedTipValue)\n"
    }
    resultsTextView.text = results
  }
  
  @IBAction func taxPercentageChanged(sender: AnyObject) {
    tipCalc.taxPct = Double(taxPctSlider.value) / 100
    refreshUI()
    updateTipResults()
  }
  
  @IBAction func viewTapped(sender : AnyObject) {
    totalTextField.resignFirstResponder()
  }
}

