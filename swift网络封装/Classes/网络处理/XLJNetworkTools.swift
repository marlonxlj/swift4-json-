//
//  XLJNetworkTools.swift
//  swift网络封装
//
//  Created by m on 2017/11/14.
//  Copyright © 2017年 XLJ. All rights reserved.
//

import UIKit
import Alamofire

//MARK:我们自己写一个枚举类型，用来区分
enum HTTPTYPE {
    case GET
    case POST
}

class XLJNetworkTools: NSObject {
    
    // 计算属性生成YBRequest对象
    static var request:XLJNetworkTools {
        return XLJNetworkTools()
    }
    
    typealias SuccessClosure = ((AnyObject?) -> ())
    typealias FailureClosure = ((Error?) -> ())
    typealias ProgressClosure = ((Int64,Int64) -> ())
    
    /// 成功回调
    var successCallback:SuccessClosure?
    /// 失败回调
    var failureCallback:FailureClosure?
    /// 上传进度
    var uploadProgress:ProgressClosure?
    /// 下载进度
    var downloadProgress:ProgressClosure?
    
}

extension XLJNetworkTools{
    
    /// 生成请求头信息
    ///
    /// - Returns: 返回请求头字典
    func httpHeaders() -> HTTPHeaders {
        
        var headers =  [String:String]()
        headers["Content-Type"] = "application/json"
        headers["Accept-Encoding"] = "gizp"
        // TODO:在这里添加自定义的请求header信息
        
        return headers
    }
    
    @discardableResult
    func request(methodType:HTTPMethod,url:URLConvertible,parameters:Parameters?,encoding:ParameterEncoding,headers:HTTPHeaders) -> XLJNetworkTools{
        
        Alamofire
            .request(url, method:methodType, parameters:parameters, encoding:encoding, headers:headers)
            .responseJSON { (response) in
                if response.result.isSuccess
                {
                    self.successCallback?(response.result.value as AnyObject?)
                }
                else
                {
                    debugPrint()
                    self.failureCallback?(response.result.error)
                }
            }
            .downloadProgress { (progress) in
                self.downloadProgress?(progress.totalUnitCount,progress.completedUnitCount)
        }
        
        return self;
    }
    
    /// GET请求
    ///
    /// - Parameters:
    ///   - url: url
    ///   - parameters: GET请求URL参数
    /// - Returns: 返回请求对象本身
    @discardableResult
    func forGet(url:URLConvertible,parameters:Parameters? = nil) -> XLJNetworkTools {
        return request(methodType: .get, url: url,parameters:parameters,encoding: URLEncoding.default,headers: httpHeaders())
    }
    
    /// GET请求，可在使用的地方，增添header信息
    ///
    /// - Parameters:
    ///   - url: url
    ///   - headers: header信息
    /// - Returns: 返回YBRequest对象
    @discardableResult
    func forGet(url:URLConvertible,headers:HTTPHeaders) -> XLJNetworkTools {
        return request(methodType: .get, url: url,parameters:nil,encoding: URLEncoding.default,headers: httpHeaders())
    }
    
    /// POST请求
    ///
    /// - Parameters:
    ///   - url: url
    ///   - parameters: 请求体参数
    /// - Returns: 返回YBRequest对象
    @discardableResult
    func forPost(url:URLConvertible,parameters:Parameters?) -> XLJNetworkTools {
        return request(methodType: .post, url: url, parameters: parameters,encoding:JSONEncoding.default,headers: httpHeaders())
    }
    
    @discardableResult
    func forPut(url:URLConvertible,parameters:Parameters?) -> XLJNetworkTools {
        return request(methodType: .post, url: url, parameters: parameters,encoding: URLEncoding.default,headers: httpHeaders())
    }
    
    @discardableResult
    func forDelete(url:URLConvertible,parameters:Parameters?) -> XLJNetworkTools {
        return request(methodType: .delete, url: url, parameters: parameters,encoding: URLEncoding.default,headers: httpHeaders())
    }
    
    /// 数据上传的请求
    ///
    /// - Parameters:
    ///   - url: url
    ///   - multipartFormData: 多部分表单的形式拼接数据的Closure
    /// - Returns: 返回YBRequest对象
    @discardableResult
    func forUpload(url:URLConvertible,multipartFormData: @escaping (MultipartFormData) -> Void) ->XLJNetworkTools
    {
        Alamofire.upload(multipartFormData: { (mFormData) in
            // 回调拼接数据
            multipartFormData(mFormData)
        }, to: url) { multipartFormDataEncodingResult in
            
            switch multipartFormDataEncodingResult {
            case .success(let upload,_,_):
                
                upload.uploadProgress(closure: { (progress) in
                    debugPrint(progress.totalUnitCount,progress.completedUnitCount);
                    self.uploadProgress?(progress.totalUnitCount,progress.completedUnitCount)
                })
                
                upload.responseJSON(completionHandler: { response in
                    if response.result.isSuccess {
                        self.successCallback?(response.result.value as AnyObject?)
                    }
                    else {
                        debugPrint()
                        self.failureCallback?(response.result.error)
                    }
                })
            case .failure(let error):
                debugPrint(error)
                self.failureCallback?(error)
            }
        }
        return self
    }
    
    
}

extension XLJNetworkTools {
    /// 网络请求成功的回调方法
    ///
    /// - Parameter successCallback: 回调closure
    /// - Returns: 返回YBRequest对象
    @discardableResult
    func success(_ successCallback:@escaping (_ responseObject:AnyObject?) -> ()) -> XLJNetworkTools {
        self.successCallback = successCallback
        return self;
    }
    
    /// 网络请求失败的回调方法
    ///
    /// - Parameter failureCallback: 回调回调closure
    /// - Returns: 返回YBRequest对象
    @discardableResult
    func failure(_ failureCallback:@escaping (_ error:Error?) -> ()) -> XLJNetworkTools {
        self.failureCallback = failureCallback
        return self;
    }
    
    /// 上传进度回调方法
    ///
    /// - Parameter uploadCallback: 回调closure
    /// - Returns: 返回YBRequest对象
    @discardableResult
    func uploadProgress(_ uploadCallback:@escaping (_ totalCount:Int64,_ completeCount:Int64) -> ()) -> XLJNetworkTools{
        self.uploadProgress = uploadCallback
        return self
    }
    
    /// 下载进度回调方法
    ///
    /// - Parameter downloadCallback: 回调closure
    /// - Returns: 返回YBRequest对象
    @discardableResult
    func downloadProgress(_ downloadCallback:@escaping (_ totalCount:Int64,_ completeCount:Int64) -> ()) -> XLJNetworkTools
    {
        self.downloadProgress = downloadCallback
        return self
    }
    
   
}
