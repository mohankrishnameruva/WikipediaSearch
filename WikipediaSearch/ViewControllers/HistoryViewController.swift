//
//  HistoryViewController.swift
//  WikipediaSearch
//
//  Created by Mohan on 21/07/18.
//  Copyright © 2018 Mohan. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBAction func ClearHistory(_ sender: Any) {
        self.HistoryArray = []
        UserDefaults.standard.set([], forKey: "HistoryArray")
        self.HistoryTable.reloadData()
    }
    @IBOutlet weak var HistoryTable: UITableView!
    var selectedItem: String? = nil
    var HistoryArray : [String] = []
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        
        HistoryTable.addSubview(self.refreshControl)
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
  
    }

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.HistoryArray = UserDefaults.standard.value(forKey: "HistoryArray") as! [String]
        self.HistoryTable.reloadData()

        self.HistoryTable.reloadData()
        refreshControl.endRefreshing()
    }
    
}

extension HistoryViewController : UITableViewDelegate,UITableViewDataSource{
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
   
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         HistoryArray = UserDefaults.standard.value(forKey: "HistoryArray") as! [String]
        return HistoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HistoryTable.dequeueReusableCell(withIdentifier: "HistoryTableCell") as! HistoryTableViewCell
        cell.Label1.text = self.HistoryArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tabBarController?.selectedIndex = 0
        let searchCont:SearchViewController = self.tabBarController?.viewControllers![0] as! SearchViewController
        selectedItem = HistoryArray[indexPath.row] as! String
        searchCont.CallWikiAPI(searchText: selectedItem!)
        searchCont.SearchBar.text = selectedItem
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let dest = segue.destination as! SearchViewController
//        dest.CallWikiAPI(searchText: (selectedItem)!)
//        dest.resignFirstResponder()
//        dest.SearchBar.text = sele
    }
    
}
