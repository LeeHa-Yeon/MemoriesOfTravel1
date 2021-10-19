import Foundation
import UIKit

struct PlaceResponseData: Codable {
    let meta: MetaData
    let documents : [Document]
}

struct MetaData: Codable{
    let total_count: Int  // 검색된 문서 수
    let pageable_count: Int  // total_count 중 노출 가능 문서 수
    let is_end: Bool  // 마지막 페이지 여부
}

struct Document: Codable{
    let place_name: String
    let x: String
    let y: String
}
