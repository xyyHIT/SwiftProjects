//
//  XYDBManager.swift
//  SQLDemo
//
//  Created by xuyang on 2017/8/8.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit
import FMDB

class XYDBManager: NSObject {
    private static var dbDirPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first?.appending("/DB")
    static var defaultName = "FMDB"
    
    static func createOrFindDB(fileName: String = defaultName) -> FMDatabase? {
        var isDir: ObjCBool = false
        let isExist = FileManager.default.fileExists(atPath: dbDirPath!, isDirectory: &isDir)
        if !isExist || !isDir.boolValue {
            do {
                try FileManager.default.createDirectory(atPath: dbDirPath!, withIntermediateDirectories: true, attributes: nil)
            } catch let err as NSError {
                print("创建\(String(describing: dbDirPath))失败：\(String(describing: err.localizedFailureReason))")
            }

        }
        let dbPath = (dbDirPath?.appending("/\(fileName).db"))!
        print("数据库路径：\(dbPath)")
        return FMDatabase(path: dbPath)
    }
    
    static func deleteDB(fileName: String = defaultName) {
        let dbPath = (dbDirPath?.appending("/\(fileName).db"))!
        if FileManager.default.fileExists(atPath: dbPath) {
            do {
                try FileManager.default.removeItem(atPath: dbPath)
                print("移除\(fileName)成功!")
            } catch let err as NSError {
                print("移除\(fileName)失败：\(String(describing: err.localizedFailureReason))")
            }
        } else {
            print("文件:\(fileName) 不存在")
        }
    }
    
    static func getDBTables(fileName: String = defaultName) -> [String]? {
        var tableNames = [String]()
        let db = createOrFindDB(fileName: fileName)
        if (db?.open())! {
            do {
                let set = try db?.executeQuery("select name from sqlite_master where type = 'table' order by name", values: nil)
                while (set?.next())! {
                    tableNames.append((set?.string(forColumn: "name"))!)
                }
            } catch let err as NSError {
                print("读取列表失败:\(String(describing: err.localizedFailureReason))")
            }
        } else {
            print("打开数据看失败！")
        }
        db?.close()
        print("数据库中表：\(tableNames)")
        return tableNames
    }
}
