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
        
        Alamofire.request(urlString, method: .post, parameters: params, encoding: encoding, headers: nil).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                success(value)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
