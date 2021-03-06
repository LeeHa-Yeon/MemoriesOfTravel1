//
//  SearchTripViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/09.
//

import UIKit

class SearchTripViewController: UIViewController {
    
    let newTrip: TripInformation = TripInformation.shared
    var registerTripName: String = ""
    
    @IBOutlet weak var tableView: UITableView!
    var Korean_cities = ["국내","서울","경기","인천","가평","강원","경주","부산","여수","전주","제주","춘천","테안","통영,거제,남해","대구","포항"]
    var filteredArr: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchController()
        self.setupTableView()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "나눔손글씨 반짝반짝 별", size: 40)!]
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.placeholder = "여행지를 검색해주세요"
        searchController.searchBar.searchBarStyle = .minimal
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "여행지 검색"
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
    @IBAction func cancle(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectTrip(_ sender: UIButton){
        newTrip.registerTripName(registerTripName)
    }

}

extension SearchTripViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isFiltering ? self.filteredArr.count : self.Korean_cities.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "대한민국 지역"
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if self.isFiltering {
            cell.textLabel?.text = self.filteredArr[indexPath.row]
        } else {
            cell.textLabel?.text = self.Korean_cities[indexPath.row]
        }
        cell.textLabel?.font = UIFont(name: "나눔손글씨 반짝반짝 별", size: 20)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("-----------> \(Korean_cities[indexPath.row])")
        registerTripName = Korean_cities[indexPath.row]
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = #colorLiteral(red: 0.2984945774, green: 0.4874641299, blue: 0.9440074563, alpha: 1)
            let sectionLabel = UILabel(frame: CGRect(x: 10 , y: 10, width:
                tableView.bounds.size.width, height: 30))
            sectionLabel.font = UIFont(name: "나눔손글씨 반짝반짝 별", size: 25)
            sectionLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        sectionLabel.text = "대한민국 지역"
            sectionLabel.sizeToFit()
            headerView.addSubview(sectionLabel)
            return headerView
        }
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50
        }
    
    
}

extension SearchTripViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        self.filteredArr = self.Korean_cities.filter { $0.localizedCaseInsensitiveContains(text) }
        self.tableView.reloadData()
    }
}
