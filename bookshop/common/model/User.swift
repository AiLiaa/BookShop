//
//  User.swift
//  bookshop
//
//  Created by macos.li on 2022/5/15.
//

import Foundation
import UIKit

class User: NSObject, NSCoding{
    
    var nickname: String?   // 昵称
    var account: String?    // 账号
    var password: String?   // 密码
    var img: UIImage?       // 头像
    
    override init() {
        super.init()
    }
    
    init(account: String, password: String){
        self.nickname = account // 初始化的时候用账号作为昵称
        self.account = account
        self.password = password
    }
    
    func setNickname(nickname: String){
        self.nickname = nickname
    }
    
    func setImg(img: UIImage) {
        self.img = img
    }
    
    // 数据保存到文件夹
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let userSaveDir = DocumentsDirectory.appendingPathComponent("user")
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nickname,forKey: "nicknameKey" )
        aCoder.encode(account,forKey: "accountKey" )
        aCoder.encode(password, forKey: "passwordKey")
        aCoder.encode(img, forKey: "imgKey")
    }
    
    required init?(coder aDecoder: NSCoder) {
        nickname = aDecoder.decodeObject(forKey: "nicknameKey") as? String
        account = aDecoder.decodeObject(forKey: "accountKey") as? String
        password = aDecoder.decodeObject(forKey: "passwordKey") as? String
        img = aDecoder.decodeObject(forKey: "imgKey") as? UIImage
    }
    
    func toNSData() -> NSData{
        return NSKeyedArchiver.archivedData(withRootObject: self) as NSData
    }
}
