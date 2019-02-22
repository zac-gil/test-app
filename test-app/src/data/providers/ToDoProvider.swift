//
//  ToDoProvider.swift
//  test-app
//
//  Created by Zac on 16/02/2019.
//  Copyright © 2019 zac-gil. All rights reserved.
//

import Foundation
import Alamofire

class ToDoProvider: TSTBaseDataProvider {
    let baseUrl = "192.168.43.213:8080"
    
    
    func getToDos(_ completion: @escaping(_ todo: ToDos?, _ error: TSTNetworkClientError?) -> Void) {
        guard let url = URLComponents(baseUrl: self.baseUrl, path: "/api/v1/todos").url else {
            return
        }
        
        self.networkClient.requestWithoutCache(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: self.jsonHeaders)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    guard let todo = self.getToDos(from: response) else {
                        completion(nil, .unknown)
                        return
                    }
                    
                    completion(todo, nil)
                case .failure:
                    completion(nil, self.getError(from: response))
                }
        }
    }
}

extension ToDoProvider {
    fileprivate func getToDos(from response: DataResponse<Any>) -> ToDos? {
        guard let json = response.result.value as? [String: Any], let todos = json["todos"] as? [String: Any] else {
            return nil
        }
        
        return ToDos(dict: todos)
    }
}
