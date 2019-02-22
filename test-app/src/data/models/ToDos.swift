//
//  ToDos.swift
//  test-app
//
//  Created by Zac on 16/02/2019.
//  Copyright © 2019 zac-gil. All rights reserved.
//

import Foundation

class ToDos: TSTBaseModel {
    var id: String?
    var title: String?
    var description: String?
    
    convenience init?(dict: [String: Any]) {
        self.init()
        
        self.id = dict["id"] as? String
        self.title = dict["title"] as? String
        self.description = dict["description"] as? String
    }
}
