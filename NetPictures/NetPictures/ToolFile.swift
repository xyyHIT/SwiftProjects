//
//  ToolFile.swift
//  NetPictures
//
//  Created by xuyang on 2017/8/8.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD





class NetManager: NSObject {
    static func postPage(page: Int, finished: @escaping ((_ result: Any?, _ error: Error?) ->())) {
        // 成功回调
        let successCallBack = {
            (task: URLSessionDataTask, result: Any?) -> Void in
            finished(result, nil)
        }
        
        let errorCallBack = {
            (task: URLSessionDataTask?, error: Error) -> Void in
            finished(nil, error)
        }
        
        AFHTTPSessionManager.post(<#T##AFHTTPSessionManager#>)
    }
}


class HUD
