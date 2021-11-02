//
//  FirebaseManager.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/17.
//

import UIKit
import Firebase
import FirebaseAuth

class FirebaseManager {
    static let shared = FirebaseManager()
    
    private init() {}
    
    let db = Database.database().reference()
    
    //MARK: - UserInfo
    func emailLogin(id: String,
                    password: String,
                    completion: @escaping (UserInfo?) -> (Void)){
        Auth.auth().signIn(withEmail: id, password: password) { (user,error) in
            // 로그인 성공 : "Login Success"
            if user != nil {
                guard let uid = user?.user.uid else {
                    print("uid is nil 로그인 보자")
                    return
                }
                
                self.db.child("user").child(uid).child("userInfo").observeSingleEvent(of: .value) { snapshot in
                    if !snapshot.hasChildren() {
                        print("don't have user uid data")
                        return
                    }
                    
                    do{
                        let jsonData = try JSONSerialization.data(withJSONObject: snapshot.value!, options: [])
                        // let dataStr = String(data: jsonData, encoding: .utf8) json to string check
                        let userInfo = try JSONDecoder().decode(UserInfo.self, from: jsonData)
                        
                        completion(userInfo)
                    }catch let error {
                        print("error --> \(error.localizedDescription)")
                    }
                }
            // 로그인 실패
            }else{
                completion(nil)
            }
        } // Auth end
    } // emailLogin
    
    func updateTripCnt(uid: String,tripCnt: String){
        
        let plusCnt = ["/user/\(uid)/userInfo/tripCnt":"\(tripCnt)"]
        db.updateChildValues(plusCnt)
    }
    
    
    //MARK: - TripInfo
    func saveTripInfo(uid: String, tripName: String, tripPK: Int, tripFD: String, tripPeriod: String, tripDate: String){
        var newTripDict = [String:Any]()
        newTripDict["tripPK"] = tripPK
        newTripDict["tripName"] = tripName
        newTripDict["tripFirstDay"] = tripFD
        newTripDict["tripPeriod"] = tripPeriod
        newTripDict["tripDate"] = tripDate
        let newTrip =  db.child("user").child(uid).child("TripList").child(tripName).child("TripInfo")
        newTrip.setValue(newTripDict)
    }
    
    func loadTripList(uid:String,completion: @escaping ([String]?) -> (Void)){
        self.db.child("user").child(uid).child("TripList").observeSingleEvent(of: .value) { snapshot in
            if !snapshot.hasChildren() {
                print("don't have tripList")
                return
            }
            let dic = snapshot.value as! [String: [String:Any]]
            var tripList = [String]()
            for key in dic.keys {
                tripList.append(key)
            }
            completion(tripList)

        }
    }
    
    func loadTripInfo(uid: String,tripName: String, completion: @escaping (TripInfo?)-> (Void)){
        self.db.child("user").child(uid).child("TripList").child(tripName).child("TripInfo").observeSingleEvent(of: .value) { (snapshot) in
            if !snapshot.hasChildren() {
                print("don't have tripInfo data")
                return
            }
            
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: snapshot.value!, options: [])
                let tripInfo = try JSONDecoder().decode(TripInfo.self, from: jsonData)
                completion(tripInfo)
            }catch let error {
                print("error --> \(error.localizedDescription)")
            }
            
        }
    }
    
    //MARK: - Memo
    func saveMemo(uid: String, tripName: String, tripDate: String ,content: [String]){
            let childUpdates = ["/user/\(uid)/TripList/\(tripName)/\(tripDate)/MemoList":content]
            db.updateChildValues(childUpdates)
    }
    func loadMemo(uid: String, tripName: String, tripDate: String,completion: @escaping ([String]?) -> (Void)){
        self.db.child("user").child(uid).child("TripList").child(tripName).child(tripDate).child("MemoList").observeSingleEvent(of: .value) { snapshot in
            if !snapshot.hasChildren() {
                print("don't have MemoList")
                completion([String]())
                return
            }
            let dic = snapshot.value as! [String]
            completion(dic)
        }
    }
    
    
    //MARK: - PlaceInfo
    func savePlaceInfo(uid: String, order: Int, tripName: String, placeName: String,x: String, y: String, category: String){
        var newPlaceDict = [String:Any]()
        newPlaceDict["placeName"] = placeName
        newPlaceDict["order"] = order
        newPlaceDict["x"] = x
        newPlaceDict["y"] = y
        newPlaceDict["category"] = category
        newPlaceDict["distance"] = 0
        newPlaceDict["memo"] = ""
        newPlaceDict["cost"] = 0
        newPlaceDict["time"] = ""
        let newTrip =  db.child("user").child(uid).child("TripList").child(tripName).child("PlaceInfo").child(placeName)
        newTrip.setValue(newPlaceDict)
    }
    func savePlace(uid: String, tripName: String, tripDate: String ,schedule: [String]){
            let childUpdates = ["/user/\(uid)/TripList/\(tripName)/\(tripDate)/Schedules":schedule]
            db.updateChildValues(childUpdates)
    }
    // 모든 schedules 불러오기
    func loadSchedule(uid: String, tripName: String, tripDate: String,completion: @escaping ([String]?) -> (Void)){
        self.db.child("user").child(uid).child("TripList").child(tripName).child(tripDate).child("Schedules").observeSingleEvent(of: .value) { snapshot in
            if !snapshot.hasChildren() {
                print("don't have Schedules")
                completion(["일정을 추가해주세요"])
                return
            }
            let dic = snapshot.value as! [String]
            completion(dic)
        }
    }
    
    // placeInfo 모두 불러오기
    func loadPlaceInfo(uid: String, tripName: String,completion: @escaping ([String:[String:Any]]) -> (Void)){
        self.db.child("user").child(uid).child("TripList").child(tripName).child("PlaceInfo").observeSingleEvent(of: .value) { snapshot in
            if !snapshot.hasChildren() {
                print("don't have PlaceInfoes")
                return
            }
            let dic = snapshot.value as! [String:[String:Any]]
            var scheduleInfo = [String:[String:Any]]()
            for (key,value) in dic {
                scheduleInfo[key] = value
            }
            
            completion(scheduleInfo)
        }
    }
    //MARK: - CheckList
    func saveUnCheckList(uid: String, tripName: String, content: [String]){
            let childUpdates = ["/user/\(uid)/TripList/\(tripName)/CheckList/False":content]
            db.updateChildValues(childUpdates)
    }
    func saveCheckList(uid: String, tripName: String, content: [String]){
            let childUpdates = ["/user/\(uid)/TripList/\(tripName)/CheckList/True":content]
            db.updateChildValues(childUpdates)
    }
    // 모든 UnCheckList 불러오기
    func loadUnCheckList(uid: String, tripName: String, completion: @escaping ([String]?) -> (Void)){
        self.db.child("user").child(uid).child("TripList").child(tripName).child("CheckList").child("False").observeSingleEvent(of: .value) { snapshot in
            if !snapshot.hasChildren() {
                let itemName = ["신용카드", "핸드폰충전기", "보조배터리", "카메라", "우산", "휴지", "물티슈", "휴대용선풍기", "마스크", "소독제", "의류", "잠옷", "속옷", "수영복", "양말", "슬리퍼", "선글라스", "모자", "여분신발", "세면도구", "치약", "칫솔", "샴푸", "린스", "바디워시", "클렌징폼", "스킨로션", "화장품", "선크림", "향수", "면도기", "렌즈", "드라이기", "고데기", "헤어에센스", "여성용품", "가방", "비상약", "지갑", "신분증", "여권", "에어팟"]
                
                print("don't have UnCheckList")
                completion(itemName)
                return
            }
            let dic = snapshot.value as! [String]
            completion(dic)
        }
    }
    // 모든 CheckList 불러오기
    func loadCheckList(uid: String, tripName: String, completion: @escaping ([String]?) -> (Void)){
        self.db.child("user").child(uid).child("TripList").child(tripName).child("CheckList").child("True").observeSingleEvent(of: .value) { snapshot in
            if !snapshot.hasChildren() {
                let itemName = [""]
                
                print("don't have CheckList")
                completion(itemName)
                return
            }
            let dic = snapshot.value as! [String]
            completion(dic)
        }
    }
    
    //MARK: - Calculate
    
    func saveExpectedCost(uid: String, tripName: String, content: String){
            let childUpdates = ["/user/\(uid)/TripList/\(tripName)/Calculate/ExpectedCost":content]
            db.updateChildValues(childUpdates)
    }
    
    func saveCalculate(uid: String, tripName: String, content: [[String:Any]]){
            let childUpdates = ["/user/\(uid)/TripList/\(tripName)/Calculate/CostList":content]
            db.updateChildValues(childUpdates)
    }
    
    func loadExpectedCost(uid: String, tripName: String, completion: @escaping (String?) -> (Void)){
        self.db.child("user").child(uid).child("TripList").child(tripName).child("Calculate").observeSingleEvent(of: .value) { snapshot in
            if !snapshot.hasChildren() {
                completion("0")
                print("don't have ExpectedCost")
                return
            }
            let dic = snapshot.value as! [String:Any]
            for (key,value) in dic {
                if key == "ExpectedCost" {
                    completion(value as? String)
                }
            }
        }
    }
    
    func loadCalculate(uid: String, tripName: String, completion: @escaping ([[String:Any]]?) -> (Void)){
        self.db.child("user").child(uid).child("TripList").child(tripName).child("Calculate").child("CostList").observeSingleEvent(of: .value) { snapshot in
            if !snapshot.hasChildren() {
                print("don't have loadCalculate")
                return
            }
            let dic = snapshot.value as! [[String:Any]]
            completion(dic)
        }
    }
    
    //MARK: - Album
    func saveAlbum(uid: String, tripName: String, albumCnt: Int){
            let childUpdates = ["/user/\(uid)/TripList/\(tripName)/Album/Cnt":albumCnt]
            db.updateChildValues(childUpdates)
    }
    func loadAlbum(uid: String, tripName: String, completion: @escaping (Int?) -> (Void)){
        self.db.child("user").child(uid).child("TripList").child(tripName).child("Album").observeSingleEvent(of: .value) { snapshot in
            if !snapshot.hasChildren() {
                print("don't have loadlbum")
                completion(0)
                return
            }
            let dic = snapshot.value as! [String:Int]
            completion(dic["Cnt"])
        }
    }
    
    

    
    //MARK: - Test
    // 회원가입할 때 생성
    func arrTest(){
        let dict : [String:Any] = {
            let dict : [String:Any] = ["jeju":["dummy":"g"]]
            return dict
        }()
        print("dicg  -->  \(dict)")
        let newUser = db.child("arrTest")
        newUser.setValue(dict)
        print("일단 잘 되긴 함")
    }
    
    // 이후 추가할때 할 거
    func updateArrTest(){

        let testUpdates = ["/arrTest/jeju/dummy":"gg"]
        db.updateChildValues(testUpdates)
    }
    
}
