//
//  SessionManager+ESC.swift
//  EasyScorecards
//
//  Created by Leighton.Kuchel on 1/18/19.
//  Copyright © 2019 Smile Machine. All rights reserved.
//

import Foundation
import Alamofire

extension Alamofire.SessionManager {
    
    // https://stackoverflow.com/questions/32199494/how-to-disable-caching-in-alamofire/42529641
    @discardableResult
    open func requestWithoutCache(_ url: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil) -> DataRequest {
        do {
            var originalRequest = try URLRequest(url: url, method: method, headers: headers)
            originalRequest.cachePolicy = .reloadIgnoringCacheData // Disable cache
            
            let encodedURLRequest = try encoding.encode(originalRequest, with: parameters)
            return self.request(encodedURLRequest)
        } catch {
            return self.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
        }
    }
    
}
