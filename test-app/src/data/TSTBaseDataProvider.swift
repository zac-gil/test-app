//
//  TSTBaseDataProvider.swift
//  test-app
//
//  Created by Zac on 16/02/2019.
//  Copyright © 2019 zac-gil. All rights reserved.
//

import Foundation
import Alamofire

class TSTBaseDataProvider {
    var sessionManager: SessionManager?
    
    var networkClient: SessionManager {
        return self.sessionManager ?? Alamofire.SessionManager.default
    }
    
    var jsonHeaders: HTTPHeaders {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Cache-Control": "no-cache, no-store, must-revalidate"
        ]
        
//        if let accessToken = self.authentication?.accessToken {
//            headers["Authorization"] = "Bearer \(accessToken)"
//        }
        
        return headers
    }
    
    func getError(from response: DataResponse<Any>) -> TSTNetworkClientError {
        guard let data = response.data else {
            return .unknown
        }
        
        do {
            guard let statusCode = response.response?.statusCode, let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return .unknown
            }
            
            // Default status codes
            switch statusCode {
            case 401:
                return .unauthenticated
            case 403:
                return .unauthorized
            case 404:
                return .notFound
            case 500:
                return .unknown
            default:
                break
            }
            
            // We may have some specific error messages
            var message: String = ""
            var errorMessages: [String] = []
            
            if let value = json["message"] as? String, value != "" {
                message = value
            }
            
            if let errors = json["errors"] as? [String: [String]], errors.count > 0 {
                for (_, fieldErrors) in errors {
                    errorMessages.append(contentsOf: fieldErrors)
                }
                
                
            }
            
            if !message.isEmpty {
                return .error(message: message, errors: errorMessages)
            }
        } catch {
            //
        }
        
        return .unknown
    }
}
