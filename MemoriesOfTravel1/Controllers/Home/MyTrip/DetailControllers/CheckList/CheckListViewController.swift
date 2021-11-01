//
//  CheckListViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/11/01.
//


import UIKit

var itemsImageFile = [String]()
var unCheckItems = [String]()
var checkItemes = [String]()

class CheckListViewController: UIViewController {
    
    let tripInfo: TripInformation = TripInformation.shared
    let firebaseManager = FirebaseManager.shared
    let myInfo = UserInfomation.shared
    let checkManager = CheckListManager.shared
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var editDoneButton: UIBarButtonItem!
    
    @IBAction func confirm(_ sender: UIButton){
//        print("check No --->\(unCheckItems)")
//        print("check  --->\(checkItemes)")
        firebaseManager.saveUnCheckList(uid: myInfo.getUid(), tripName: (tripInfo.getTripInfo()?.getTripName())!, content: unCheckItems)
        firebaseManager.saveCheckList(uid: myInfo.getUid(), tripName: (tripInfo.getTripInfo()?.getTripName())!, content: checkItemes)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func editTable(_ sender: Any) {
        if self.tableView.isEditing {
            self.tableView.setEditing(false, animated: true)
        } else {
            self.tableView.setEditing(true, animated: true)
        }
    }
    
    @IBAction func addItem(_ sender: Any) {
        let alert = UIAlertController(title: "추가", message: "준비물을 입력해주세요.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Name"
        }
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            guard let text = alert.textFields?[0].text else { return }
            if text != "" {
                unCheckItems.append(text)
                self.tableView.reloadData()
                self.scrollToBottom()
            }
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        unCheckItems = checkManager.getUnCheckList()
        checkItemes = checkManager.getCheckList()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func scrollToBottom(){
        let lastRowOfIndexPath = self.tableView.numberOfRows(inSection: 0) - 1
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: lastRowOfIndexPath, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    
}

extension CheckListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return unCheckItems.count
        case 1 :
            return checkItemes.count
        default :
            return 0
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0 :
            return "준비 안함"
        case 1 :
            return "준비함"
        default :
            return ""
        }
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "checkCell", for: indexPath) as? CheckListCell else {
                return UITableViewCell()
            }
            let cellImageName = UIImage(named: "blank")
            cell.checkImage.setImage(cellImageName, for: .normal)
            cell.itemLabel.text = unCheckItems[(indexPath as NSIndexPath).row]
            cell.checkImage.tag = 0
            return cell
        case 1 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "checkCell", for: indexPath) as? CheckListCell else {
                return UITableViewCell()
            }
            let cellImageName = UIImage(named: "check")
            cell.checkImage.setImage(cellImageName, for: .normal)
            cell.itemLabel.text = checkItemes[(indexPath as NSIndexPath).row]
            cell.checkImage.tag = 1
            
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0 :
            //unCheckItems
            let popItmes = unCheckItems.remove(at: indexPath.row)
            checkItemes.append(popItmes)
            self.tableView.reloadData()
        case 1 :
            //checkItemes
            let popItmes = checkItemes.remove(at: indexPath.row)
            unCheckItems.append(popItmes)
            self.tableView.reloadData()
        default :
            print("문제있음 moveRowAt 확인바람")
        }
    }
    
    
    
    
    // 목록 삭제 함수
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            switch indexPath.section {
            case 0 :
                unCheckItems.remove(at: (indexPath as NSIndexPath).row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            case 1 :
                checkItemes.remove(at: (indexPath as NSIndexPath).row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            default :
                print("문제있음 editingStyle 확인바람")
            }
            
        } else if editingStyle == .insert {
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "제거"
        
    }
    
    // 목록 순서 바꾸기
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        switch fromIndexPath.section {
        case 0 :
            let itemToMove = unCheckItems[(fromIndexPath as NSIndexPath).row]
            //        let itemImageToMove = itemsImageFile[(fromIndexPath as NSIndexPath).row]
            unCheckItems.remove(at: (fromIndexPath as NSIndexPath).row)
            //        itemsImageFile.remove(at: (fromIndexPath as NSIndexPath).row)
            unCheckItems.insert(itemToMove, at: (to as NSIndexPath).row)
            //        itemsImageFile.insert(itemImageToMove, at: (to as NSIndexPath).row)
            
        case 1 :
            let itemToMove = checkItemes[(fromIndexPath as NSIndexPath).row]
            //        let itemImageToMove = itemsImageFile[(fromIndexPath as NSIndexPath).row]
            checkItemes.remove(at: (fromIndexPath as NSIndexPath).row)
            //        itemsImageFile.remove(at: (fromIndexPath as NSIndexPath).row)
            checkItemes.insert(itemToMove, at: (to as NSIndexPath).row)
            //        itemsImageFile.insert(itemImageToMove, at: (to as NSIndexPath).row)
            
        default :
            print("문제있음 moveRowAt 확인바람")
        }
        
        
        
        
        
    }
}

class CheckListCell: UITableViewCell{
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet var checkImage: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
