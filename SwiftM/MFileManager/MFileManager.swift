//
//  MFileManager.swift
//  SwiftM
//  文件管理单例
//  Created by mazb on 2022/10/21.
//

import Foundation


class MFileManager: NSObject {
    static let shared = MFileManager()
    private init(){}
    
    func checkDictionaryPath:(path : String){
        let domainsArray = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)
        let domainsPath = domainsArray[0] as URL
        print(domainsPath)

    }
}

extension MFileManager{
    func checkDictionaryPathsssss(path : String){
        
    }
    
//    open func urls(for directory: FileManager.SearchPathDirectory, in domainMask: FileManager.SearchPathDomainMask) -> [URL]

}


