//
//  MHistoryModel.swift
//  SwiftM
//
//  Created by mazb on 2022/11/1.
//

import Foundation

struct MHistoryModel {
    var createDate : Date?
    var title : String?
    
    static var formatter : DateFormatter{
        let f = DateFormatter()
        f.dateFormat = "yyyy.MM.dd HH:mm"
        return f
    }
    
    init() {
        createDate = Date()
        title = MHistoryModel.formatter.string(from: createDate!)
    }
}
