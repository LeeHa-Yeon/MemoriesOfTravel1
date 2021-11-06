//
//  AlbumViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/11/02.
//

// 이 부분만 파이어베이스 안빼고 작성함

import UIKit
import FirebaseStorage

class AlbumViewController: UIViewController {
    let selectTripInformation: TripInformation = TripInformation.shared
    let albumManager: AlbumManager = AlbumManager.shared
    let myInfo: UserInfomation = UserInfomation.shared
    let firebaseManager: FirebaseManager = FirebaseManager.shared
    var albumCnt = Int()
    
    // 인스턴스 생성
    let storage = Storage.storage()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumCnt = albumManager.getAlbumCnt()
        //        print("처음받아온값",albumCnt)
        setUpCollectionView()
        setUpNavigation()
    }
    
    
    func setUpCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setUpNavigation(){
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "나눔손글씨 반짝반짝 별", size: 35)!]
    }
    
    
    //MARK: - 다운로드 보여주기
    @IBAction func reloadTapped(_ sender: Any){
        collectionView.reloadData()
    }
    
    // MARK: - 파이어베이스에 업로드하기
    @IBAction func upLoadTapped(_ sender: UIButton){
        // 원하는 이미지 업로드
        let imageName: String = "산"
        let image = UIImage(named: imageName)
        upLoadImage(img: image!, fileStr: imageName)
    }
    
    @IBAction func saveButton(_ sender: UIButton){
        // 파이어베이스에 개수 업데이트하기.
        firebaseManager.saveAlbum(uid: myInfo.getUid(), tripName: selectTripInformation.getTripInfo()!.getTripName(), albumCnt: albumCnt)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    //MARK: - 파이어베이스에 저장
    func upLoadImage(img: UIImage, fileStr: String) {
        var data = Data()
        data = img.jpegData(compressionQuality: 0.8)!
        let filePath = myInfo.getUid()
        let filePath2 = selectTripInformation.getTripInfo()?.getTripName()
        let fileName = "\(albumCnt)"
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storage.reference().child(filePath).child(filePath2!).child(fileName).putData(data, metadata: metaData){
            (metaData,error) in if let error = error {
                print("upLoadImage--->\(error)")
                return
            }else{
                print("성공")
                self.albumCnt+=1
            }
        }
    }
    
    //MARK: - 파이어베이스의 파일 다운받기
    func downloadimage(imgview: UIImageView,index: Int){
        let filePath = "gs://memoriesoftravel1.appspot.com/\(myInfo.getUid())/\( selectTripInformation.getTripInfo()?.getTripName() ?? "")/\(index)"
        storage.reference(forURL: filePath).downloadURL ( completion: { (url, error) in if let error = error {
            print("downloadimage--->\(error)")
            return
        }else{
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            imgview.image = image
        }
        })
    }
    
    
}

extension AlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumCnt
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictureCell", for: indexPath) as? PictureCell else {
            return UICollectionViewCell()
        }
        downloadimage(imgview: cell.fireImg,index: indexPath.row)
        cell.fireImg.layer.cornerRadius = 30
        return cell
    }
    
    
}

extension AlbumViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let margin: CGFloat = 35
        let width: CGFloat = (self.view.bounds.width-(2*margin))/2
        let height: CGFloat = width
        
        return CGSize(width: width, height: height)
    }
}


class PictureCell: UICollectionViewCell{
    @IBOutlet weak var fireImg: UIImageView!
    
}
