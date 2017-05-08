//
//  API.swift
//  SnowSensei
//
//

import Foundation

open class API
{
    internal static var manager: AFHTTPRequestOperationManager?
    
    open static func setup()
    {
        manager = AFHTTPRequestOperationManager(baseURL: URL(string: "http://ekepling.cs.loyola.edu/"))
            
//        manager?.securityPolicy.allowInvalidCertificates = true
//        manager?.securityPolicy.validatesDomainName = false
        //manager.reading
        manager?.requestSerializer = AFJSONRequestSerializer()
        manager?.responseSerializer = AFJSONResponseSerializer()
        manager?.responseSerializer = AFJSONResponseSerializer.init(readingOptions: .allowFragments)
//        manager?.responseSerializer = AFHTTPResponseSerializer()
        
    }
}
