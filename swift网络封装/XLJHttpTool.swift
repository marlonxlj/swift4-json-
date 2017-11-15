//
//  XLJHttpTool.swift
//  swift网络封装
//
//  Created by m on 2017/11/14.
//  Copyright © 2017年 XLJ. All rights reserved.
//

import UIKit

class XLJHttpTool: NSObject {

    //闭包类型: (参数列表) -> (返回值类型)
    func loadData(callBack: @escaping (_ jsonData : String) -> ()){
        
        let queue = DispatchQueue(label: "com.app.ques")
        queue.async {
            print("12222,:\(Thread.current)")
        }
        
        DispatchQueue.main.async(execute: {
            print("33333:\(Thread.current)")
            callBack("json数据")
        })
        
    }
}
