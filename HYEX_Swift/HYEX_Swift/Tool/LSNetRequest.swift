//
//  LSNetRequest.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/2/20.
//

import UIKit
import Alamofire

let token = "7e1aaaab9215992dfe385ea54e43f9ed"//写死

var header: HTTPHeaders = ["Accept-Language":Localize.currentLanguage()]

// MARK: 成功回调
typealias ResponseSuccess = (_ responseData: Any)->()

// MARK: 失败回调
typealias ResponseError = (_ error: Error)->()

// MARK: 进度
typealias ResponseProgress = (_ progress: CGFloat)->()

class LSNetRequest{
    class var sharedInstance: LSNetRequest {
        struct instance{
            static let _instance:LSNetRequest = LSNetRequest.init()
        }
        return instance._instance
    }
    var progressBlock: ResponseProgress?
    // MARK: GET
    func getRequest(_ url: String,
                    params: [String:Any]? = nil,
                    success: @escaping ResponseSuccess,
                    failure: ResponseError? = nil) {
        let urlString: String = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let encoding:URLEncoding = .queryString
        var dic: [String : Any] = [:]
        if let para = params {
            dic = para
        }
        if let value = UserDefaults.standard.value(forKey: "uniqueStr"){
            dic["uniqueStr"] = "\(value)"
        }
        //配置token信息
        if LSLoginModel.verifyLogin() {
            header["token"] = LSLoginModel.sharedInstace()?.token
        }
        print(KBaseUrl + urlString)
        AF.request(KBaseUrl + urlString, method: .get, parameters: dic, encoding: encoding, headers: header).responseJSON{ (response) in
            switch response.result{
            case .success(let value):
                print(value)
                success(value)
            case .failure(let error):
                failure!(error)
            }
        }
    }
    
    // MARK: POST
    func postRequest(_ url: String,
                     params: [String:Any]? = nil,
                     success: @escaping ResponseSuccess,
                     failure: @escaping ResponseError) {
        let urlString: String = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let encoding:URLEncoding = .queryString
        var dic: [String : Any] = [:]
        if let para = params {
            dic = para
        }
        if let value = UserDefaults.standard.value(forKey: "uniqueStr"){
            dic["uniqueStr"] = "\(value)"
        }
        //配置token信息
        if LSLoginModel.verifyLogin() {
            header["token"] = LSLoginModel.sharedInstace()?.token
        }
        print(KBaseUrl + urlString)
        print("*********")
        print(dic)
        AF.request(KBaseUrl + urlString, method: .post, parameters: dic, encoding: encoding, headers: header).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                print(value)
                let dic = value as! NSDictionary
                print(dic["errorMessage"])
                success(value)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func downloadGraphVerifyRequest(_ url: String,
                         params: [String:Any]? = nil,
                         progress: @escaping ResponseProgress,
                         success: @escaping ResponseSuccess,
                         failure: @escaping ResponseError) {
        let urlString: String = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let encoding:URLEncoding = .queryString
        
        var seedParams:[String:Any]?
        if let para = params{
            seedParams = para
        }
        let interval = Int32(Date().timeIntervalSince1970)
        seedParams!["seed"] = "\(interval)"
        if urlString == KGraphValidateCode {//如果是图形验证码
            UserDefaults.standard.setValue(String(format: "%d", interval), forKey: "uniqueStr")
            UserDefaults.standard.synchronize()
        }
        var destination: DownloadRequest.Destination!
        destination = {_ ,response in
            let documentURL = URL(fileURLWithPath: NSHomeDirectory() + "/Documents/Download/")
            // 在路径追加文件名称
            let fileUrl = documentURL.appendingPathComponent(response.suggestedFilename!)
            
            return (fileUrl , [.removePreviousFile, .createIntermediateDirectories])
        }
        
        let downloadRequest = AF.download(KBaseUrl + urlString, method: .get, parameters: seedParams, encoding: encoding, headers: nil, to: destination).responseData { (response) in
            if let data = response.value {
                   success(data)
               }
        }
        downloadRequest.downloadProgress(closure: downloadProgress1)
        progressBlock = progress
        
    }
    func downloadProgress1(progress: Progress){
        if progressBlock != nil {
            let p: CGFloat = CGFloat(progress.completedUnitCount/progress.totalUnitCount)
            progressBlock!(p)
        }
        print("\(Float(progress.fractionCompleted))------\(Float(progress.totalUnitCount))")
        // 进度条更新
    }
}
