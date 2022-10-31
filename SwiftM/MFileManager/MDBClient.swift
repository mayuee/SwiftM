//
//  MDBClient.swift
//  SwiftM
//
//  Created by mazb on 2022/11/1.
//

import UIKit
import SQLite3

class MDBClient: NSObject {
    let tableName = "kTableName"
    
    //数据库句柄
    private var dbClient : OpaquePointer?
    
    static let shared = MDBClient()
    private override init(){
        super.init()
        openDB()
        if createTable() == false {
            print("数据表创建失败：\(tableName)")
        }
    }
    
}

extension MDBClient{
    
    func createTable() -> Bool{
        let createSQL = "CREATE TABLE IF NOT EXISTS '\(tableName)' ('id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 'createDate' TEXT, 'title' TEXT);"
        return execSQL(sql: createSQL)
    }
    
    func insertHistory(model : MHistoryModel){
    
        let insertSQL = "INSERT INTO \(tableName) (createDate, title) VALUES (\"\(String(describing: model.createDate))\", \"\(model.title!)\");"
        if execSQL(sql: insertSQL) {
            print("插入成功:\(String(describing: model.title))")
        }
    }
    
    func getHistoryList() -> Void{
    
        let getSQL = "SELECT * FROM \(tableName);"
        guard let array = query(sql: getSQL) else {
            return
        }
        print(array)
    }
    
    func deleteHistory(model : MHistoryModel){
        
        let deleteSQL = "DELETE FROM \(tableName) WHERE createDate = \(String(describing: model.createDate));"
        if execSQL(sql: deleteSQL) {
            print("删除成功:\(String(describing: model.title))")
        }
    }
    
    func updateHistory(model : MHistoryModel){
        
        let updateSQL = "UPDATE \(tableName) SET title = \(String(describing: model.title)) WHERE createDate = \(String(describing: model.createDate));"
        if execSQL(sql: updateSQL) {
            print("修改成功:\(String(describing: model.title))")
        }
    }

}


extension MDBClient{
    ///打开并创建数据库
    private func openDB() {
        let dbPath = NSHomeDirectory() + "/Documents" + "/mdb.sqlite"
        if sqlite3_open(dbPath, &dbClient) != SQLITE_OK {
            print("打开或创建数据库失败。。。")
        } else {
            print("成功创建数据库：\(dbPath)")
        }
    }
    
    ///查询
    private func query(sql : String) -> [[String : AnyObject]]? {
        
        var stmt : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(dbClient, sql, -1, &stmt, nil) != SQLITE_OK {
            print("查询失败。。。")
            return nil
        }
        
        var dictArray = [[String : AnyObject]]()
        
        while sqlite3_step(stmt) == SQLITE_ROW {
            dictArray.append(getRecord(stmt: stmt!))
        }
        
        return dictArray
    }
    
    /// 根据‘游标’获取一条数据
    private func getRecord(stmt : OpaquePointer) -> [String : AnyObject] {
        let count = sqlite3_column_count(stmt)
        var dict = [String : AnyObject]()
        for i in 0..<count {
            // 2.取出字典对应的key
            let cKey = sqlite3_column_name(stmt, i)
            guard let key = String(cString: cKey!, encoding: String.Encoding.utf8) else {
                continue
            }
            
            let cValue =  UnsafePointer<UInt8>(sqlite3_column_text(stmt, i))
            let value = String.init(cString: cValue!)
            
            dict[key] = value as AnyObject?
        }
        
        return dict
    }
    
    private func execSQL(sql : String) -> Bool {
        let cSQL = sql.cString(using: String.Encoding.utf8)
        if sqlite3_exec(dbClient, cSQL!, nil, nil, nil) == SQLITE_OK {
            return true
        }
        else{
            print("Failed to execSQL: \(sql)")
            return false
        }
    }
}
