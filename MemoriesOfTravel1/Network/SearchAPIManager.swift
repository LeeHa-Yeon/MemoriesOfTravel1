//
//  SearchAPIManager.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/14.
//

import UIKit
import Alamofire

protocol KakaoAPIDataSource{
    var REQUEST_URL: String { get }
    var HTTP_HEADERS: HTTPHeaders { get }
}

class SearchAPIManager: KakaoAPIDataSource {
    
    static let shared = SearchAPIManager()
    
    var REQUEST_URL: String = "https://dapi.kakao.com/v2/local/search/keyword.json"
    var HTTP_HEADERS: HTTPHeaders = ["Authorization":"KakaoAK 8f6339fba445508cd2ab233cb64e9533"]
    
    func requestSearchPlace2(parameter: PlaceRequestParameter, completion: @escaping (PlaceResponseData)->(Void)){
        AF.request(REQUEST_URL, method: .get, parameters: parameter.toDict, headers: HTTP_HEADERS).validate().validate(statusCode: 200..<300).responseJSON { response in switch response.result{
        case .success :
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                let json = try JSONDecoder().decode(PlaceResponseData.self, from: jsonData)
                completion(json)
            }catch{
                print("parsing error --> \(error.localizedDescription)")
            }
        case .failure:
            print("fail, statusCode --> \(response.result)")
        }
        }
    }
    
}
