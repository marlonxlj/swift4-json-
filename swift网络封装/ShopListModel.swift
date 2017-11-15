//
//  ShopListModel.swift
//  B2B
//
//  Created by cjs on 2017/7/11.
//  Copyright © 2017年 lcnicky. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper

class ShopListModel: Mappable {
    
    var sysNo: Int64 = -1
    var shopName: String = ""
    var logofull: String = ""
    var logo: String = ""
    var productNum: Int64 = -1
    var salesCount:Int64 = -1
    var products:[ProductModel] = [ProductModel]()
    var streetAddress: String = ""
//    状态(0:保存未提交审核  1:已提交待审核 2:审核通过 3:审核失败 4:注销)
    var status:Int = -1
    var shopGrade: String = ""
    
    required  init?(map: Map) {
        
    }
    init() {
        
    }
    
    func mapping(map: Map) {
        
        sysNo <- map["sysNo"]
        shopName <- map["shopName"]
        logofull <- map["logofull"]
        logo <- map["logo"]
        productNum <- map["productNum"]
        salesCount <- map["salesCount"]
        products <- map["products"]
        streetAddress <- map["streetAddress"]
        status <- map["status"]
        shopGrade <- map["shopGrade"]
    
    }
}

class ProductModel: Mappable {
    
    var productname: String = ""
    var shopid: Int64 = -1
    var mainPictureUrl: String = ""
    var sysno: Int64 = -1
    var price:Float = -1
    
    required  init?(map: Map) {
        
    }
    init() {
        
    }
    
    func mapping(map: Map) {
        
        productname <- map["productname"]
        shopid <- map["shopid"]
        mainPictureUrl <- map["mainPictureUrl"]
        sysno <- map["sysno"]
        price <- map["price"]
    }

}

//MARK: 网络请求

//NetworkManager.request(url: kMethodShopList,
//method: .post,
//contentType: ["application/json"],
//params: params,
//success: { [weak self] (errorCode, responseJSON) in
//MyProgressHUD.hide()
//let json = JSON(responseJSON)
//for item in json.arrayValue{
//let model = Mapper<ShopListModel>().map(JSONObject: item.rawValue)
//self?.shopModels.append(model!)
//}
//
//self?.collectionView?.reloadData()
//
//
//},
//failure: { (errorCode, errorMessage) in
//MyProgressHUD.hide()
//MyProgressHUD.showMessage(errorMessage,  delayHide: 2)
//
//})

