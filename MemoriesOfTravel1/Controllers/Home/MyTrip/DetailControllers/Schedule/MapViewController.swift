//
//  MapViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/09.
//

import UIKit

class MapViewController: UIViewController {

    @IBOutlet weak var customTableView2: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTableView2.delegate = self
        customTableView2.dataSource = self

    }

}

extension MapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell1 = customTableView2.dequeueReusableCell(withIdentifier: "CustomCell2", for: indexPath) as? CustomTableViewCell2 else {
            return UITableViewCell()
        }
        return cell1
    }
}

class CustomTableViewCell2: UITableViewCell{
    
}
