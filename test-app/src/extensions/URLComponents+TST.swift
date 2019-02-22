//
//  URLComponents+ESC.swift
//  Salus
//
//  Created by Leighton.Kuchel on 9/19/18.
//  Copyright © 2018 Smile Machine. All rights reserved.
//

import Foundation

// https://stackoverflow.com/questions/24551816/swift-encode-url
extension URLComponents {
    
    fileprivate func isHttps(_ string: String) -> Bool {
        return string.contains("https://")
    }
    
    fileprivate func isMailTo(_ string: String) -> Bool {
        return string.contains("mailto://")
    }
    
    fileprivate func getSchemeFromUrl(_ string: String) -> String {
        if self.isHttps(string) {
            return "https"
        } else if self.isMailTo(string) {
            return "mailto"
        } else {
            return "http"
        }
    }
    
    fileprivate func getHostFromUrl(_ string: String) -> String {
        if self.isHttps(string) {
            return string.replacingOccurrences(of: "https://", with: "")
        } else if self.isMailTo(string) {
            return string.replacingOccurrences(of: "mailto://", with: "")
        } else {
            return string.replacingOccurrences(of: "http://", with: "")
        }
    }
    
    init(baseUrl url: String, path: String) {
        self.init(baseUrl: url, path: path, queryItems: nil)
    }
    
    init(baseUrl url: String, path: String, queryItems items: [URLQueryItem]?) {
        var queryItems: [URLQueryItem] = [URLQueryItem]()
        
        if let i = items {
            queryItems = i
        }
        
        self.init()
        self.scheme = self.getSchemeFromUrl(url)
        self.host = self.getHostFromUrl(url)
        self.path = path
        self.queryItems = queryItems
        
        // Replace occurances of + as .queryItems doesn't do it automatically
        // https://stackoverflow.com/questions/43052657/encode-using-urlcomponents-in-swift
        self.percentEncodedQuery = self.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
    }
}
