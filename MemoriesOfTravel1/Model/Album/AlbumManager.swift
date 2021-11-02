//
//  AlbumCnt.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/11/03.
//

import Foundation
import UIKit

class AlbumManager{
    
    static let shared: AlbumManager = AlbumManager()
    
    private init(){}
    
    var albumCnt = Int()
    
    func getAlbumCnt() -> Int {
        return albumCnt
    }
    
    func setAlbumCnt(_ albumCnt: Int){
        self.albumCnt = albumCnt
    }
    
}
