//
//  LSNetRequest.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/2/20.
//

import UIKit
import Alamofire
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
                    params: [String:Any]?,
                    success: @escaping ResponseSuccess,
                    failure: @escaping ResponseError) {
        let urlString: String = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let encoding:URLEncoding = .queryString
        
        Alamofire.request(urlString, method: .get, parameters: params, encoding: encoding, headers: nil).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                success(value)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    // MARK: POST
    func postRequest(_ url: String,
                     params: [String:Any]?,
                     success: @escaping ResponseSuccess,
                     failure: @escaping ResponseError) {
        let urlString: String = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let encoding:URLEncoding = .default
        print(params);
        Alamofire.request(urlString, method: .post, parameters: params, encoding: encoding, headers: nil).responseJSON { (response) in
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
                         params: [String:Any],
                         progress: @escaping ResponseProgress,
                         success: @escaping ResponseSuccess,
                         failure: @escaping ResponseError) {
        let urlString: String = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let encoding:URLEncoding = .queryString
        var seedParams:[String:Any] = params
//        let userDefult:UserDefaults = UserDefaults.standard
        let interval = Date.init(timeIntervalSince1970: 0)
        seedParams["seed"] = interval
            
        var destination: DownloadRequest.DownloadFileDestination!
        destination = {_ ,response in
            let documentURL = URL(fileURLWithPath: NSHomeDirectory() + "/Documents/Download/")
            // 在路径追加文件名称
            let fileUrl = documentURL.appendingPathComponent(response.suggestedFilename!)
            
            return (fileUrl , [.removePreviousFile, .createIntermediateDirectories])
        }
        
        let downloadRequest = Alamofire.download(urlString, method: .get, parameters: seedParams, encoding: encoding, headers: nil, to: destination).responseData { (response) in
            if let data = response.result.value {
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
