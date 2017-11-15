//
//  XLJModel.swift
//  swift网络封装
//
//  Created by m on 2017/11/14.
//  Copyright © 2017年 XLJ. All rights reserved.
//

//address = "8\U53f7";
//conseventid = 59;
//headphoto = "http://onh8hmni9.bkt.clouddn.com/1.jpg";
//ordertime = "1970-1-1 9:00:01";
//ordertimestatu = 0;
//releasetime = "2017-4-7 13:32:57";
//roomphoto =     (
//{
//img1 = "http://onh8hmni9.bkt.clouddn.com/img1.png";
//},
//{
//img2 = "http://onh8hmni9.bkt.clouddn.com/img2.png";
//},
//{
//img3 = "http://onh8hmni9.bkt.clouddn.com/img3.png";
//}
//);
//username = "\U6211\U662f\U5361\U7c73\U4e9a1";
//userneed = "\U5f00\U59cb\U4e86";

import UIKit
import SwiftyJSON
import ObjectMapper

class XLJModel: NSObject,Mappable{

    var address : String!
    var conseventid : String!
    var headphoto : String!
    var ordertime : String!
    var ordertimestatu : String!
    var releasetime : String!
    var roomphoto : [DetailRoomphotoModel]!
    var username : String!
    var userneed : String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        address <- map["address"]
        conseventid <- map["conseventid"]
        headphoto <- map["headphoto"]
        ordertime <- map["ordertime"]
        releasetime <- map["ordertime"]
        username <- map["username"]
        userneed <- map["userneed"]
        roomphoto <- map["roomphoto"]
    }
    

}

class DetailRoomphotoModel : Mappable{
    
    var img1 : String!
    var img2 : String!
    var img3 : String!

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        img1 <- map["img1"]
        img2 <- map["img2"]
        img3 <- map["img3"]
    }

    
}

