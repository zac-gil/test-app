//
//  ESCNetworkClient.swift
//  EasyScorecards
//
//  Created by Nigel Flack on 12/09/2018.
//  Copyright © 2018 Smile Machine. All rights reserved.
//

import Foundation

enum TSTNetworkClientError {
    case accountTaken
    case error(message: String, errors: [String])
    case error(error: NSError)
    case notFound
    case unknown
    case unauthorized
    case unauthenticated
}

//class ESCNetworkClient {
//
//    var authentication: ESCNetworkClientAuthentication!
//    var configuration: ESCNetworkClientConfiguration
//
//    init(configuration: ESCNetworkClientConfiguration) {
//        self.configuration = configuration
//    }
//
//}
