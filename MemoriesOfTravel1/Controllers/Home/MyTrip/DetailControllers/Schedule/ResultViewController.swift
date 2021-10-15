//
//  ResultViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/15.
//

import UIKit

class ResultViewController: UIViewController {
    
    let a = PlaceInformation.shared
    
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var cateLable: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        placeLabel.text = a.getPlaceName()
        xLabel.text = a.getX()
        yLabel.text = a.getY()
        cateLable.text = a.getCategory()
    }

}
