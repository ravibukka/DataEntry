//
//  ViewController.swift
//  DataEntryApp
//
//  Created by Ravikumar Bukka on 29/09/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cellData:Array< [String] > = Array < [String] >()
    var sectionData:Array< String > = Array < String >()
    var reasonData:Array< [String] > = Array < [String] >()
    var dayData :Array< [String] > = Array < [String] >()
    
    // request an UITraitCollection instance
    let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Change your input source file here, based on input json file values will be shown at UI
        loadJson(filename: "inputData")
       // loadJson(filename: "testInputData")
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

  
    // MARK: TableView Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return self.sectionData.count

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return self.sectionData[section]
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        return self.cellData[section].count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        
        cell.textLabel?.text = self.cellData[indexPath.section][indexPath.row]
        
        return cell
    }
    
    
    // MARK: TableView Data Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (self.deviceIdiom) {
            
        case .pad:
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FormDetailsVCID") as? DataEntryViewController
            {

                vc.reasonData =  self.reasonData
                vc.dayData = self.dayData
                vc.selectedSection = indexPath.section
                present(vc, animated: true, completion: nil)
            }
            print("iPad style UI")
            
            
        case .phone:
            print("iPhone and iPod touch style UI")
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FormDetailsVCID") as? DataEntryViewController {
//                viewController.reasonData =  [self.reasonData[indexPath.section]]
                viewController.reasonData =  self.reasonData
                viewController.dayData = self.dayData
                viewController.selectedSection = indexPath.section
              
                if let navigator = navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        case .tv:
            print("tvOS style UI")
        default:
            print("Unspecified UI idiom")
        }
    }

    
    // MARK: loadJson method
    /* will take local json file name and process it to get data and which will pass to another function extract_json */
    func loadJson(filename fileName: String)  {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                self.extract_json(data)

            } catch {
                print("Error!! Unable to parse  \(fileName).json")
            }
        }
       
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }

    // Mark: extract_json method
     /* will take data as input and process it to get required values */
    func extract_json(_ data: Data)
    {

        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode([DataEntryElement].self, from: data)
            for DataEntryElement in response {
                
                sectionData.append(DataEntryElement.questions)
                cellData.append(DataEntryElement.answers)
                reasonData.append(DataEntryElement.reasonSelect)
                dayData.append(DataEntryElement.daySelect)
            }
        } catch {
            print(error)
        }
        
        DispatchQueue.main.async(execute: {self.do_table_refresh()})
        
    }
    
    func do_table_refresh()
    {
        self.tableView.reloadData()
        
    }


}

