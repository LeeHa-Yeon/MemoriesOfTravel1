//
//  MapCell.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/11.
//

import UIKit
import NMapsMap

class MapCell: UITableViewCell {

    @IBOutlet weak var toggleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var naverMapView: NMFNaverMapView!
    
    var mapView : NMFMapView {
            return naverMapView.mapView
        }
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
    func settingData(isClicked: ExpendingTableCellContent3) {
        if isClicked.expanded {
            self.toggleLabel.text = "▲"
            self.naverMapView.isHidden = false
        } else {
            self.toggleLabel.text = "▽"
            self.naverMapView.isHidden = true
        }
    }
    
}
