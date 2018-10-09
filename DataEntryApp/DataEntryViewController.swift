//
//  DataEntryViewController.swift
//  DataEntryApp
//
//  Created by Ravikumar Bukka on 29/09/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import UIKit

class DataEntryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
    @IBOutlet weak var iPadNavigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    var indexPathOfSelectedRowPaidBy: NSIndexPath?
    
    var reasonData:Array< [String] > = Array < [String] >()
    var dayData :Array< [String] > = Array < [String] >()
    var selectedSection:Int = 0
    
    var selectedDay:[String] = ["Selected Days:"]
    var selectedReason:String = "Selected Reason: "

    var viewModel: FormViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = FormViewModel()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        
        switch (self.deviceIdiom) {
            case .pad:
                self.iPadNavigationBar.isHidden = false
            case .phone:
                self.iPadNavigationBar.isHidden = true
            default:
            print("Unspecified UI idiom")
        }
        
       // self.navigationController?.isNavigationBarHidden=true
    }
    
    @IBAction func dismiss(_ sender: Any) {

        showInputDialog(alertArr: selectedDay, subMessage: selectedReason)

    }
    
    override func viewWillAppear(_ animated: Bool) {
//        let rightSideOptionButton = UIBarButtonItem()
//        rightSideOptionButton.title = "Show"
//
//        self.navigationItem.rightBarButtonItem = rightSideOptionButton
        
        let logoutBarButtonItem = UIBarButtonItem(title: "Show", style: .done, target: self, action: #selector(showPopup))
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem

        
     //   setupBindings()
    }
    
    
    //We can bind our UI elements to FormViewModel attributes, since we are not having any input UI elements So, just mapping cell selected values to FormViewModel attributes
//    func setupBindings() {
//        nameField.bind(with: viewModel.name)
//        companyField.bind(with: viewModel.companyName)

//    }
    
    @objc func showPopup() {
        
        showInputDialog(alertArr: selectedDay, subMessage: selectedReason)
    }
 

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "SingleSelect"
        default:
            return "MultiSelect"
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return reasonData[selectedSection].count
        default:
            return dayData[selectedSection].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = self.reasonData[selectedSection][indexPath.row]
        default:
            cell.textLabel?.text = self.dayData[selectedSection][indexPath.row]
            
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.section {
        case 0:
            if let previousIndexPath = indexPathOfSelectedRowPaidBy {
                tableView.deselectRow(at: previousIndexPath as IndexPath, animated: false)
              //  tableView.cellForRow(at: previousIndexPath as IndexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            }
            indexPathOfSelectedRowPaidBy = indexPath as NSIndexPath
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            if selectedReason.isEmpty == false {
                selectedReason = "Selected Reason: "
                selectedReason.append(tableView.cellForRow(at: indexPath)?.textLabel?.text ?? "")
            }
            
        case 1:
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            selectedDay.append(tableView.cellForRow(at: indexPath)?.textLabel?.text ?? "")

            
        default:
            break
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            if let previousIndexPath = indexPathOfSelectedRowPaidBy {
                tableView.deselectRow(at: previousIndexPath as IndexPath, animated: false)
                tableView.cellForRow(at: previousIndexPath as IndexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            }
            indexPathOfSelectedRowPaidBy = nil
            
        case 1:
            print("Good")
            //  tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            
        default:
            break
        }
    }
}


//Mark: Alert extension
extension UIViewController {
    func showInputDialog(alertArr:[String], subMessage:String) {
        let messageString = alertArr.joined(separator: ", ")

        let alert = UIAlertController(title: messageString, message:subMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                
                self.dismiss(animated: true, completion: nil)
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
}
