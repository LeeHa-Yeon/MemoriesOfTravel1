//
//  SelectViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/16.
//

import UIKit

class SelectViewController: UIViewController {
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    @IBAction func moveToSearchPlace(_ sender: UIButton){
        guard let SearchPlaceVC = self.storyboard?.instantiateViewController(identifier: "SearchPlaceSB") as? SearchPlaceViewController else {
            return
        }
        navigationController?.pushViewController(SearchPlaceVC, animated: true)
    }
    
    @IBAction func moveToMapPlace(_ sender: UIButton){
        guard let MapPlaceVC = self.storyboard?.instantiateViewController(identifier: "MapPlaceSB") as? MapPlaceViewController else {
            return
        }
        navigationController?.pushViewController(MapPlaceVC, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        firstButton.layer.cornerRadius = 20
        secondButton.layer.cornerRadius = 20

    }

}
