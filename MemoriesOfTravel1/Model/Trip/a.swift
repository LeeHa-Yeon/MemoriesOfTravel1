
import Foundation
import UIKit

struct a {
    // 여행지, 날짜 ,여행기간, 디데이,여행사진, 여행첫날
    private var tripPK: String
    private var tripName: String
    private var tripDate: String
    private var tripRange: String
    private var tripDday: Int
    private var tripImage: String
    private var tripFirstDay: String
    
    init(){
        self.tripPK = ""
        self.tripName = ""
        self.tripDate  = ""
        self.tripRange  = ""
        self.tripDday  = 0
        self.tripImage  = ""
        self.tripFirstDay  = ""
        
    }
    
    func getTripName() -> String {
        return self.tripName
    }
    
    mutating func setTripName(_ tripName: String){
        self.tripName = tripName
    }
    
}


class aManager: NSObject {
    static let shared: aManager = aManager()
    
    var myTripList : [a] = []
    
    func createAddTripInfo() -> a {
        return a()
    }
    
    func addTripInfo(_ sheetInfo: a){
        myTripList.append(sheetInfo)
    }
    
    func getTripName(_ index: Int) -> String {
        return myTripList[index].getTripName()
    }
    
    func setTripName(tripName: String, index: Int){
        myTripList[index].setTripName(tripName)
    }

}

