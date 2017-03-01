//
//  ViewController.swift
//  TipCalculatorIphone
//
//  Created by Yan, Tristan on 2/27/17.
//  Copyright © 2017 Yan, Tristan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var amountField: UITextField!
    
    @IBOutlet weak var percentSegment: UISegmentedControl!
    
    let defaults = UserDefaults.standard
    var currencyFormatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadDefault()
        
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = .current
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func amountChanged(_ sender: AnyObject) {
        let percentages = defaults.array(forKey: "percentages")
        
        let amount = Double(amountField.text!) ?? 0.0
        let tip = amount * (percentages?[percentSegment.selectedSegmentIndex] as? Double)! / 100.0
        let total = amount + tip
        tipLabel.text = currencyFormatter.string(from: tip as NSNumber)
        totalLabel.text = currencyFormatter.string(from: total as NSNumber)
    }

    @IBAction func tapOnPanel(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadDefault()
        amountChanged(self)
    }
    
    func loadDefault() {
        var defaultPercentages = defaults.array(forKey: "percentages")
        if defaultPercentages == nil {
            defaultPercentages = [15, 18, 20]
            defaults.set(defaultPercentages, forKey: "percentages")
        }
        
        percentSegment.removeAllSegments()
        for (i, element) in (defaultPercentages?.enumerated())! {
            percentSegment.insertSegment(withTitle: String(format: "%d%%", element as! Int), at: i, animated: false)
        }
        
        let selectedPercentageIndex = defaults.integer(forKey: "defaultPercentageIndex")
        if percentSegment.selectedSegmentIndex != selectedPercentageIndex {
            percentSegment.selectedSegmentIndex = selectedPercentageIndex
        }
    }
}

