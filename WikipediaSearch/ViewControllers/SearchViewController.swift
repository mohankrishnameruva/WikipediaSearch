//
//  ViewController.swift
//  WikipediaSearch
//
//  Created by Mohan on 20/07/18.
//  Copyright © 2018 Mohan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchBar.delegate = self
        ResultsTable.delegate = self
        ResultsTable.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var ResultsTable: UITableView!
    var selectedPage :page?
    
    var ResultsArray: [page]  = [page]()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailWiki"{
            let dest = segue.destination as! WebViewController
            dest.selectedPageId = self.selectedPage?.pageid?.stringValue
            dest.pagetitle = self.selectedPage?.title
        }
    }
}
extension SearchViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.CallWikiAPI(searchText: searchBar.text!)
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.CallWikiAPI(searchText: searchBar.text!)
    }
    
    
}
extension SearchViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ResultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.ResultsTable.dequeueReusableCell(withIdentifier: "ResultsCell") as! ResultTableViewCell
        let currentPage : page = ResultsArray[indexPath.row]
        cell.Label1.text = currentPage.title!
        if let desc = currentPage.description{
        cell.Label2.text = desc
        }else{
            cell.Label2.text = ""
        }
        if let _ = currentPage.thumbnailImage{
            cell.ThumbnailView.image = currentPage.thumbnailImage
        }else{
            GetImageforpage(page: currentPage)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPage = ResultsArray[indexPath.row] as page
        self.performSegue(withIdentifier: "DetailWiki", sender: self)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        SearchBar.resignFirstResponder()
    }
}
extension SearchViewController{

    func GetImageforpage(page: page) {
        if let imageUrl = page.thumbnail?.value(forKey: "source"){
            Alamofire.request(imageUrl as! String).responseImage { response in
                
                if let image = response.result.value {
                    page.thumbnailImage = image
                    DispatchQueue.main.async {
                        self.ResultsTable.reloadData()
                    }
                }
            }
        }
    }


    func CallWikiAPI(searchText : String) {
        let urlString : String = "https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch=\(searchText.replacingOccurrences(of: " ", with: "+"))&gpslimit=10"
        
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseJSON{ response in
                
                switch response.result {
                case .success(let JSON):
                    
                    if let jsonDict = JSON as? Dictionary<String, Any>{
                        self.ResultsArray.removeAll()
                        if let query = jsonDict["query"] as? NSObject{
                            if let pages = query.value(forKey: "pages") as? Array<Any>{
                                for each in pages{
                                    let pageObj = page(obj: each as! NSObject)
                                    self.ResultsArray.append(pageObj)
                                }
                            }
                        }
                        self.ResultsTable.reloadData()
                    }
                    
                    
                case .failure(let error):
                    let message = error.localizedDescription
                    
                    let alertController = UIAlertController.init(title: "", message:message , preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                }
        }
        
    }
}
