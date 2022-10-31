//
//  MFileManager.swift
//  SwiftM
//  文件管理单例
//  Created by mazb on 2022/10/21.
//

import Foundation
import UIKit

class MFileManager: NSObject {
    
    /*static let sharedd : MFileManager  = {
        //一些初始化
        let fm = MFileManager()
        return fm
    }()*/
    //以下两行是单例实现
    static let shared = MFileManager()
    private override init(){}
    
    lazy var storeDirPath : URL =  {
        var doc = documentDirectory()
        let dirPath: URL = doc.appendingPathComponent("storage")
        checkDictionaryPath(path: dirPath)
        return dirPath
    }()
}

// MARK: -- 公共方法
extension MFileManager{
    func documentDirectory() -> URL {
        
        let domainsArray = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)
        let domainsPath = domainsArray[0] as URL
         
        //let domainsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

        return domainsPath
    }
    
    private func checkDictionaryPath(path : URL?){
        
        guard let url = path else {
            return
        }
        
        var isDir : ObjCBool = ObjCBool(true)
        let fm = FileManager.default
        if fm.fileExists(atPath: url.absoluteString, isDirectory: &isDir){
            if isDir.boolValue == false {
                try? fm.removeItem(atPath: url.absoluteString)
                try? fm.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            }
        }else{
            try? fm.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    private func removeFileAtPath(path : String?){
        guard let sp = path else {
            return
        }
        try? FileManager.default.removeItem(atPath: sp)
    }
    
    private func storageFile(_ fileData : Data?, atPath path : URL?){
        guard let sp = path else {
            return
        }
        guard fileData != nil else {
            return
        }
//        if let data = fileData where data.count > 0 {
//            try? fileData?.write(to: sp, options: .withoutOverwriting)
//        }
        try? fileData?.write(to: sp, options: .withoutOverwriting)
    }
    
    private func getFile(atPath path : URL?) -> Data? {
        guard let urlPath = path  else {
            return nil
        }
        let data = try? Data.init(contentsOf: urlPath)
        return data
    }


//    open func urls(for directory: FileManager.SearchPathDirectory, in domainMask: FileManager.SearchPathDomainMask) -> [URL]
}


// MARK: -- 项目相关
extension MFileManager{
    
    func storageImage(_ image : UIImage?, withName name : String?){
        guard let img = image, let pt = name else {
            return
        }
        let path = storeDirPath.appendingPathComponent(pt)
        if let imgData = img.pngData() {
            storageFile(imgData, atPath: path)
        }
    }
    
    func getImage(named name : String?) -> UIImage?{
        guard let pt = name else {
            return nil
        }
        let path = storeDirPath.appendingPathComponent(pt)
        if let data = getFile(atPath: path){
            if let image = UIImage(data: data) {
                return image
            }
        }
        return nil
    }

    
}


