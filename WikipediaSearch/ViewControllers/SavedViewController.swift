//
//  SavedViewController.swift
//  WikipediaSearch
//
//  Created by Mohan on 21/07/18.
//  Copyright © 2018 Mohan. All rights reserved.
//

import UIKit

class SavedViewController: UIViewController {

    @IBOutlet weak var SavedSearchesTable: UITableView!
    var savedArray : [NSDictionary] = [NSDictionary]()
    var selectedpageid : String? = nil
    var selectedpagetitle : String? = nil
    @IBOutlet weak var savedTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
savedTable.delegate = self
        savedTable.dataSource = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension SavedViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let _ = UserDefaults.standard.value(forKey: "savedPages"){
            savedArray =  UserDefaults.standard.value(forKey: "savedPages") as! [NSDictionary]}
        else{
            UserDefaults.standard.setValue([[String:NSNumber]](), forKey: "savedPages")}
        

        
        return savedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = savedTable.dequeueReusableCell(withIdentifier:"SavedCell") as! SavedTableViewCell
        self.selectedpagetitle = ((savedArray[indexPath.row])).value(forKey: "title") as! String
        cell.Label1.text = selectedpagetitle!
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       selectedpageid = (savedArray[indexPath.row].value(forKey: "pageid") as! NSNumber).stringValue
        performSegue(withIdentifier: "ShowSavedPage", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var dest = segue.destination as! WebViewController
        dest.pagetitle = selectedpagetitle!
        dest.selectedPageId = selectedpageid
    }
    
}
