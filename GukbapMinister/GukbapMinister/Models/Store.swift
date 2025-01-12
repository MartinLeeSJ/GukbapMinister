//
//  Store.swift
//  GukbapMinister
//
//  Created by Martin on 2023/01/16.
//

import Foundation
import SwiftUI
import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Store: Codable, Hashable, Identifiable {
    
    @DocumentID var id: String?
    var storeName: String
    var storeAddress: String
    var coordinate: GeoPoint
    var storeImages: [String] //스토리지의 이미지 url
    var menu: [String : String]
    var description: String
    var countingStar: Double
    var foodType: [String] //국밥 타입: ex:순대,돼지국밥
    var likes : Int //가게를 찜한 유저 수
    var hits : Int // 가게 detailView 조회수
    
    static func == (lhs : Store, rhs: Store) -> Bool{
        lhs.id == rhs.id
    }
}

extension Store {
    static var test: Store = .init(storeName: "name", storeAddress: "addressaddressaddressaddressaddressaddress", coordinate: GeoPoint(latitude: 37, longitude: 125), storeImages: [], menu: [:], description: "description", countingStar: 0.5, foodType: ["순대국밥"], likes: 0, hits: 17)
    
    static var test2: Store = .init(storeName: "name2", storeAddress: "2", coordinate: GeoPoint(latitude: 37.5, longitude: 127), storeImages: [], menu: [:], description: "description2", countingStar: 0.5, foodType: ["돼지국밥"], likes: 0, hits: 23)
}





