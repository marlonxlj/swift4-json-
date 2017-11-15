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
    
    var tool : XLJHttpTool = XLJHttpTool()
    //https://apple.com/item?id=1000
    override func viewDidLoad() {
        super.viewDidLoad()
//        Alamofire.request("https://apple.com", method: .get, parameters: ["id":1000], encoding: .URL, headers: nil)
        
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        do {
            tool.loadData(callBack: { (respone) in
                print("获取到的数据:\(respone)")
            })
            
            XLJNetworkTools.request.forGet(url: "http://onh8hmni9.bkt.clouddn.com/testGrap.json").success({ (respone) in

                let model = Mapper<XLJModel>().map(JSON: respone as! [String : Any])
                for item in (model?.roomphoto)!{
//                    print("imte1:\(item.img1)")
//                    print("imte2:\(item.img2)")
//                    print("item3:\(item.img3)")
                    
                    let smod = Mapper<DetailRoomphotoModel>().map(JSONObject: item)
                }
            }).failure({ (error) in
                print("error:\(String(describing: error))")
            })
            
        }
    }

}


