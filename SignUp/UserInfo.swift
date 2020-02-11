//
//  UserInfo.swift
//  SignUp
//
//  Created by 안홍석 on 2020/01/30.
//  Copyright © 2020 안홍석. All rights reserved.
//

import Foundation

final class UserModel {
    
    
    struct User {
//        var image: NSObject
        var userid: String
        var userpw: String
//        var userpwCheck: String
//        var introduce: String
    }
    
    var model: [User] = [
        User(userid: "aaaa", userpw: "1111"),
        User(userid: "bbbb", userpw: "2222"),
        User(userid: "cccc", userpw: "3333"),
        User(userid: "dddd", userpw: "4444"),
    ]
    
    // 해당 유저 있는지 검사
    func isUser(id: String, pw: String) -> Bool {
        for user in model {
            if (user.userid == id && user.userpw == pw) {
                return true
            }
            else {  break  }
        }
        return false
    }
    
    // newUser 추가 메서드
    func addUser(id: String, pw: String) {
        let newUser = User(userid: id, userpw: pw)
        model.append(newUser)
    }
    
    
}



//class UserInfo {
//    static let shared: UserInfo = UserInfo()
//
//    var profile:
//    var id: String?
//    var passwd: String?
//    var indroduce: String?
//
//}
