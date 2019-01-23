//
//  InternetCheck.swift
//  MarnPOS-P2P
//
//  Created by Admin on 10/06/2018.
//  Copyright © 2018 M. Arqam Owais. All rights reserved.
//

import Foundation

class InternetCheck {

    /// Checks if device is connected to gateway to the internet, not domain is actually available
    /// - Would be helpful in P2P
     /// - Returns: Bool
    class func isConnected() -> Bool {
        let reachability = Reachability()
        let networkStatus: Reachability.Connection = reachability!.connection
        return networkStatus != Reachability.Connection.none
    }

    /// Checks if device can actually reach a domain
    /// - Returns: Bool
    class func checkInternet(completionHandler:@escaping (_ internet:Bool) -> Void)
    {
       // UIApplication.shared.isNetworkActivityIndicatorVisible = true

        let url = URL(string: "http://www.google.com/")
        var req = URLRequest.init(url: url!)
        req.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        req.timeoutInterval = 10.0

        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in

            if error != nil  {
                completionHandler(false)
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        completionHandler(true)
                    } else {
                        completionHandler(false)
                    }
                } else {
                    completionHandler(false)
                }

            }
        }
        task.resume()
}
}
