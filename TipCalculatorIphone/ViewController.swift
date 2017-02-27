//
//  ViewController.swift
//  TipCalculatorIphone
//
//  Created by Yan, Tristan on 2/27/17.
//  Copyright © 2017 Yan, Tristan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var selectedPercentage = 0

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var amountField: UITextField!
    
    @IBOutlet weak var percentSegment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadDefault()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func amountChanged(_ sender: AnyObject) {
        let percentages = [0.15, 0.18, 0.20]
        let amount = Double(amountField.text!) ?? 0.0
        let tip = amount * percentages[percentSegment.selectedSegmentIndex]
        let total = amount + tip
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }

    @IBAction func tapOnPanel(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadDefault()
        amountChanged(self)
    }
    
    func loadDefault() {
        let defaults = UserDefaults.standard
        selectedPercentage = defaults.integer(forKey: "defaultPercentageIndex")
        if percentSegment.selectedSegmentIndex != selectedPercentage {
            percentSegment.selectedSegmentIndex = selectedPercentage
        }
    }
}

