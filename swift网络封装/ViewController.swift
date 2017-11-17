//
//  ViewController.swift
//  swift网络封装
//
//  Created by m on 2017/11/12.
//  Copyright © 2017年 XLJ. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON
import ObjectMapper

class ViewController: UIViewController {
    
    //https://apple.com/item?id=1000
    override func viewDidLoad() {
        super.viewDidLoad()
//        Alamofire.request("https://apple.com", method: .get, parameters: ["id":1000], encoding: .URL, headers: nil)
        
        
    }
    
    enum TestType {
        case networkType
        case timeType
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        do {
            
            let test = TestType.timeType
            
            switch test {
            case .networkType:
                network_test()
            case .timeType:
                date_test()
            default:
                print("2222")
            }
        }
    }

}

//MARK: - 测试的相关函数
extension ViewController {
    
    ///网络测试
    private func network_test (){
        
        XLJNetworkTools.request.forGet(url: "http://onh8hmni9.bkt.clouddn.com/testGrap.json").success({ (respone) in
            
            let model = Mapper<XLJModel>().map(JSON: respone as! [String : Any])
            
            let json = JSON(respone!)["roomphoto"]
            for item in json.arrayValue {
                guard let detmail = Mapper<DetailRoomphotoModel>().map(JSONObject: item.rawValue) else {return}
                
                print("detail:\(detmail)")
                
            }
        }).failure({ (error) in
            print("error:\(String(describing: error))")
        })

    }

    ///日期测试
    private func date_test(){
         let createdAtStr = "Fri Sep 16 13:10:20 +0800 2017"
        
        let creaTest = NSDate.createDateString(createdAtStr: createdAtStr)
        
        print(creaTest)
    }
}


