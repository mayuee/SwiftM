//
//  MHistoryModel.swift
//  SwiftM
//
//  Created by mazb on 2022/11/1.
//

import Foundation
import UIKit

struct MHistoryModel {
    /*var createDate : String? {
        get {    只读
            let date = Date()
            return MHistoryModel.formatter.string(from: date)
        }
    }*/
    private var storeImage : UIImage?
    var createDate : String?
    var title : String?
    var image : UIImage? {
        mutating get{
            if storeImage == nil {
                storeImage = MFileManager.shared.getImage(named: createDate)
            }
            return storeImage
        }
        set {
            storeImage = newValue
        }
    }
    
    static var formatter : DateFormatter{
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        return f
    }
    
    init() {
        let date = MHistoryModel.formatter.string(from: Date())
        createDate = date
        title = date
    }
    
    init(createDate : String?, title : String?){
        self.createDate = createDate
        self.title = title
        self.storeImage = MFileManager.shared.getImage(named: createDate)
    }

}
