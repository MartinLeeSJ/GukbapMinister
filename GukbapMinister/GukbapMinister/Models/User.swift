//
//  User.swift
//  GukbapMinister
//
//  Created by Martin on 2023/01/16.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Hashable, Codable {
    @DocumentID var id: String?
    var userNickname: String = ""
    var userEmail: String =  ""
//    var preferenceArea: String = ""
//    var gender: String = ""
//    var ageRange: Int = 0
//    var gukbaps: [String] = []
//    var filterdGukbaps: [String] = []
    var userGrade : String = ""
    var reviewCount: Int = 0
    var storeReportCount: Int = 0
    var favoriteStoreId: [String] = []
  //  var favoriteStoreId : [String] // 찜하기 누른 store id
}
