//
//  SettingsViewController.swift
//  TipCalculatorIphone
//
//  Created by Yan, Tristan on 2/27/17.
//  Copyright © 2017 Yan, Tristan. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var defaults = UserDefaults.standard
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaults = UserDefaults.standard
        let percentages = [15, 18, 20]
        let defaultPercentIndex = defaults.integer(forKey: "defaultPercentageIndex") 
        let row = indexPath.row
        let cellId = "Tip Percent:"
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) {
            return cell
        } else {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
            cell.textLabel?.text = String(format: "%d%%", percentages[row])
            
            if (defaultPercentIndex == row) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            cell.textLabel?.textAlignment = .right
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Default Tip Percentage"
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let defaultPercentIndex = defaults.integer(forKey: "defaultPercentageIndex")
        
        if (row != defaultPercentIndex) {
            defaults.set(row, forKey: "defaultPercentageIndex")
            let oldRow = IndexPath(row: defaultPercentIndex, section: 0)
            tableView.cellForRow(at: oldRow)?.accessoryType = .none
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
