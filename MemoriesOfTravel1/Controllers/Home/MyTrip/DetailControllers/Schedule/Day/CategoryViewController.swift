//
//  CategoryViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/10.
//

import UIKit

class CategoryViewController: UIViewController {
    
    let newPlace = PlaceInformation.shared
    
    let myInfo: UserInfomation = UserInfomation.shared
    let tripInfo : TripInformation = TripInformation.shared
    let firebaseManager = FirebaseManager.shared
    
    @IBOutlet weak var collectionView: UICollectionView!
    let categoryName: [String] = ["숙소","차량","먹거리","카페","놀거리","기타"]
    
    @IBAction func moveToResult(_ sender: UIButton){
        
        guard let ResultVC = self.storyboard?.instantiateViewController(identifier: "ResultSB") as? ResultViewController else {
            return
        }
        navigationController?.pushViewController(ResultVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        firebaseManager.loadSchedule(uid: myInfo.getUid(), tripName: (tripInfo.getTripInfo()?.getTripName())!, tripDate: newPlace.getTripDate()!){ response in
            guard let response = response else {
                print("Schedule 불러오기 실패")
                return
            }
            var newSchedule = [String]()
            newSchedule = response
            newSchedule.append(self.newPlace.loadPlaceName())
            self.newPlace.setScheduleList(newSchedule)
        }
    }
    
}

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        cell.categoryImage.image = UIImage(named: categoryName[indexPath.row]+"카테고리") ?? UIImage()
        cell.categoryLabel.text = categoryName[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        newPlace.registerCategory(categoryName[indexPath.row])
        print("-----------> \(categoryName[indexPath.row])")
        
    }
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell else {
            return true
        }
        if cell.isSelected {
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            collectionView.deselectItem(at: indexPath, animated: true)
            return false
        } else {
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            return true
        }
    }
    
    
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 20
        let width: CGFloat = (self.view.bounds.width-(margin))/2
        let height: CGFloat = width - 50
        
        
        return CGSize(width: width, height: height)
    }
    
}

class CategoryCell : UICollectionViewCell {
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
}
