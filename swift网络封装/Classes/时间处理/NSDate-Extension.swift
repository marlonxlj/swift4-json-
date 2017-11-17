//
//  NSDate-Extension.swift
//  swift网络封装
//
//  Created by m on 2017/11/17.
//  Copyright © 2017年 XLJ. All rights reserved.
//

import Foundation

extension NSDate {
    ///根据一个时间字符串返回一个时间
    class func createDateString(createdAtStr: String) -> String {
        //1.创建时间格式化对象
        let fmt = DateFormatter()
        fmt.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        fmt.locale = Locale(identifier: "en")
        
        //2.将字符串时间，转成date类型
        guard let createDate = fmt.date(from: createdAtStr) else {
            return ""
        }
        
        //3.创建当前时间
        let nowDate = Date()
        
        //4.计算创建时间和当前时间的时间差
        let interVal = Int(nowDate.timeIntervalSince(createDate))
        
        //5.时间间隔处理
        //5.1刚刚
        if interVal < 60{
        
            return "刚刚"
        }
        
        //5.2 59分钟前
        if interVal < 60 * 60 {
            
            return "\(interVal/60)分钟前"
        }
        
        //5.3 11小时前
        if interVal < 60 * 60 * 24{
            return "\(interVal / (60 * 60))小时前"
        }
        
        //5.4 创建日期对象
        let calender = NSCalendar.current
        
        //5.5 处理昨天数据: 昨天 13:44
        if calender.isDateInYesterday(createDate) {
            fmt.dateFormat = "昨天 HH:mm"
            let timeStr = fmt.string(from: createDate)

            return timeStr
        }
        
        //5.6 处理一年之内: 08-24 24:33
        let cmps = calender.dateComponents([.year], from: createDate, to: nowDate)
        
        if cmps.year! < 1 {
            fmt.dateFormat = "MM-dd HH:mm"
            let timeStr = fmt.string(from: createDate)

            return timeStr
        }
        
        //5.7 超过1年: 2016-09-22 13:33
        fmt.dateFormat = "yyyy-MM-dd HH:mm"
        let timeStr = fmt.string(from: createDate)
        return timeStr

    }
}
