//
//  PlaceSearchViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/14.
//

import UIKit

class SearchPlaceViewController: UIViewController, UISearchResultsUpdating{
    
    let kakaoAPI = SearchAPIManager.shared
    let placeInfo = PlaceInformation.shared
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func moveToCategory(_ sender: UIButton){
        guard let CategoryVC = self.storyboard?.instantiateViewController(identifier: "CategorySB") as? CategoryViewController else {
            return
        }
        navigationController?.pushViewController(CategoryVC, animated: true)

    }

    var documents: [Document] = [Document]()
    var placeQuery = PlaceRequestParameter(query: "")

    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearch()
        setupTableView()
    }
    
    
    private func setupTableView(){
        tableView.dataSource = self
        tableView.delegate  = self
        nextButton.layer.cornerRadius = 20
    }
    
    private func setupSearch(){
        title = "장소 검색"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "나눔손글씨 반짝반짝 별", size: 40)!]
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchWord = searchController.searchBar.text, searchWord.isEmpty == false else{
            return
        }
        self.placeQuery.setQuery(query: searchWord)
        kakaoAPI.requestSearchPlace(parameter: placeQuery) { response in
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
        let placeName = documents[indexPath.row].place_name
        cell.resultPlaceLabel.text = placeName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? PlaceCell else {return}
        guard let index = tableView.indexPath(for: cell) else { return }
        placeInfo.setPlaceName(placeName: documents[index.row].place_name)
        placeInfo.setX(x: documents[index.row].x)
        placeInfo.setY(y:documents[index.row].y)
        
        print("-----------> \(index.row)")
    }
    
    
}



class PlaceCell: UITableViewCell {
    @IBOutlet weak var resultPlaceLabel: UILabel!
}
