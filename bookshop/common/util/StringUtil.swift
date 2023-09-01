//
//  StringUtil.swift
//  bookshop
//
//  Created by macos.li on 2022/5/15.
//
import Foundation

class StringUtil {
    
    class func isEmpty(str: String?) -> Bool {
        return str == nil || str!.count <= 0
    }
}
