//
//  ApiRouter.swift
//  GimmikStore
//
//  Created by Mayantha Jayawardena on 10/4/18.
//  Copyright © 2018 Viyana. All rights reserved.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    case search(String, String, Int)
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let baseUrl = Config.BaseUrl
        let url = URL(string: baseUrl.appending(location).removingPercentEncoding!)
        var request = URLRequest(url: url!)
        
        print(request)
    }

}
