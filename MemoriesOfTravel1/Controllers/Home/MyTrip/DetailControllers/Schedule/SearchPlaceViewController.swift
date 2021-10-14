//
//  PlaceSearchViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/14.
//

import UIKit

class SearchPlaceViewController: UIViewController, UISearchResultsUpdating{
    
    @IBOutlet weak var tableView: UITableView!
    let manager = SearchAPIManager.shared
    var clickIdx: Int = 0
    var sendUrl = String()
    
    var documents: [Document] = [Document]()
    var testParameter = PlaceRequestParameter(query: "서울")

    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        tableView.dataSource = self
        tableView.delegate  = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchWord = searchController.searchBar.text, searchWord.isEmpty == false else{
            return
        }
        self.testParameter.setQuery(query: searchWord)
        manager.requestSearchPlace2(parameter: testParameter) { response in
            DispatchQueue.main.async {
                self.documents = response.documents
                self.tableView.reloadData()
            }
        }
        
        print("검색어 ---- >\(searchWord)")

    }
    
}

extension SearchPlaceViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as? PlaceCell else{
            return UITableViewCell()
        }
        let a = documents[indexPath.row].place_name
        cell.resultPlaceLabel.text = a
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        clickIdx = indexPath.row
        print("-----------> \(indexPath.row)")
    }
    
    
}



class PlaceCell: UITableViewCell {
    @IBOutlet weak var resultPlaceLabel: UILabel!
}
