//
//  StackSearchUtil.swift
//  StackSearch
//
//  Created by Saiful I. Wicaksana on 11/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import UIKit

internal class StackSearchUtil {
    fileprivate let TAG = "StackSearchUtil"
    
    internal func getAPI(apiParams: APIParams, page: Int = 1) -> String {
        return "\(Config.baseDomain)\(Config.search)?page=\(page)" +
            "&pagesize=\(apiParams.pagesize)" +
            "\(apiParams.fromdate != 0 ? "&fromdate=\(apiParams.fromdate)" : "")" +
            "\(apiParams.todate != 0 ? "&todate=\(apiParams.todate)" : "")" +
            "&order=\(apiParams.order)" +
            "&sort=\(apiParams.sort)" +
            "\(apiParams.tagged != "" ? "&tagged=\(apiParams.tagged)" : "")" +
            "\(apiParams.intitle != "" ? "&intitle=\(apiParams.intitle)" : "")" +
            "&site=stackoverflow"
    }
    
    internal func getDate(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US") as Locale!
        return dateFormatter.date(from: string)!
    }
    
    internal func getDate(miliseconds: Int) -> String {
        let dateVar = Date(timeIntervalSince1970: TimeInterval(miliseconds))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US") as Locale!
        return dateFormatter.string(from: dateVar)
    }
    
    internal func getWidthScreenPercent(percent: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.width * (percent / 100)
    }
    
    internal func requestData(url: String, completion: @escaping(_ data: Data) -> ()) {
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.sync {
                    completion(data)
                }
            } else if let error = error {
                print("\(self.TAG) - requestData: \(error.localizedDescription)")
            }
            }.resume()
    }
}
