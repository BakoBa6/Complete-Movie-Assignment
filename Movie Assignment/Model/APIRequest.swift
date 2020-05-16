//
//  APIRequest.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/6/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class APIRequest{
    static let sharedAPIRequest = APIRequest()
    private init(){}
    //    let alert = SingleActionAlert.sharedAlert.showNoInternetConnectionAlert( withTitle: "gdhs", withMessage: "gsjw")
    private let networkReachability = NetworkReachabilityManager()
    func requestData<T:UIViewController>(fromUrl url:URL,withParameters parameters:[String:String],
        forViewController viewController:T,noInternetConnectionHandler:@escaping ()->Void,compilition: @escaping(JSON?)->Void){
        if networkReachability!.isReachable{
            Alamofire.request(url, method: .get, parameters: parameters).responseJSON(queue: DispatchQueue.global(qos: .userInitiated)) { (response) in
                if response.result.isSuccess {
                    let json = JSON(response.result.value!)
                    compilition(json)
                }else{
                    compilition(nil)
                    return
                }
            }
        }
        else{
            let alert = SingleActionAlert.sharedAlert.showNoSingleActionConnectionAlert(withTitle: "Internet Error", withMessage: "Please Connect To Internet ") {
                noInternetConnectionHandler()
            }
            viewController.present(alert, animated:true, completion: nil)
            
        }
        
    }
}



