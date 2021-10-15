//
//  SearchAPIManager.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/14.
//

import UIKit
import Alamofire

// 키워드로 장소 검색하기 API

protocol KakaoAPIDataSource{
    var REQUEST_URL: String { get }
    var HTTP_HEADERS: HTTPHeaders { get }
}

final class SearchAPIManager: KakaoAPIDataSource {
    
    static let shared = SearchAPIManager()
    
    var REQUEST_URL: String = "https://dapi.kakao.com/v2/local/search/keyword.json"
    var HTTP_HEADERS: HTTPHeaders = ["Authorization":"KakaoAK 8f6339fba445508cd2ab233cb64e9533"]
    
    func requestSearchPlace(parameter: PlaceRequestParameter, completion: @escaping (PlaceResponseData)->(Void)){
        AF.request(REQUEST_URL, method: .get, parameters: parameter.toDict, headers: HTTP_HEADERS).validate().validate(statusCode: 200..<300).responseJSON { (response) in
            switch response.result{
            case .success :
                do{
                    let jsonData = response.value!
                    let json = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
                    let result = try JSONDecoder().decode(PlaceResponseData.self, from: json)
                    completion(result)
                }catch{
                    print("parsing error --> \(error.localizedDescription)")
                }
            case .failure:
                print("fail, statusCode --> \(response.result)")
            }
        }
    } // func end
    
}
