//
//  SettingsViewController.swift
//  TipCalculatorIphone
//
//  Created by Yan, Tristan on 2/27/17.
//  Copyright © 2017 Yan, Tristan. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var percentages = UserDefaults.standard.array(forKey: "percentages")
    
    var defaultPercentIndex = UserDefaults.standard.integer(forKey: "defaultPercentageIndex")
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addPercentage(sender:)))
        tableView.allowsMultipleSelectionDuringEditing = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (percentages?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cellId = "Tip Percent:"
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) {
            return cell
        } else {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
            cell.textLabel?.text = String(format: "%d%%", percentages?[row] as! Int)
            
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
        
        if (row != defaultPercentIndex) {
            let oldRow = IndexPath(row: defaultPercentIndex, section: 0)
            defaultPercentIndex = row
            UserDefaults.standard.set(row, forKey: "defaultPercentageIndex")
            tableView.cellForRow(at: oldRow)?.accessoryType = .none
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            tableView.reloadData()
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
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            if ((percentages?.count)! > 3) {
                percentages?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                UserDefaults.standard.set(percentages, forKey: "percentages")
                if (defaultPercentIndex == indexPath.row) {
                    UserDefaults.standard.set(0, forKey: "defaultPercentageIndex")
                }
            }
        }
    }
    
    func addPercentage(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Percentage", message: "New percentage", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Please input a new percentage"
        }

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            if let newPercent = Int((textField?.text)!) {
                if let contains = self.percentages?.contains(where: {e in return (e as? Int) == newPercent}) {
                    if (!contains && (self.percentages?.count)! < 5) {
                        for (index, element) in (self.percentages?.enumerated())! {
                            if (element as! Int > newPercent) {
                                self.percentages?.insert(newPercent, at: index)
                                let atIndex = IndexPath(row: index, section: 0)
                                self.tableView.insertRows(at: [atIndex], with: UITableViewRowAnimation.automatic)
                                if (index < self.defaultPercentIndex) {
                                    UserDefaults.standard.set(self.defaultPercentIndex + 1, forKey: "defaultPercentageIndex")
                                }
                                UserDefaults.standard.set(self.percentages, forKey: "percentages")
                                break
                            }
                        }
                    }
                }
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
