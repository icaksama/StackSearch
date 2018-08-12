//
//  APIParams.swift
//  StackSearch
//
//  Created by Saiful I. Wicaksana on 12/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import Foundation

internal class APIParams {
    
    fileprivate let defaults = UserDefaults.standard
    internal var pagesize: Int = 10
    internal var fromdate: Int = 0
    internal var todate: Int = 0
    internal var order: String = "desc"
    internal var sort: String = "activity"
    internal var tagged: String = ""
    internal var intitle: String = "ios"
    
    init() {
        self.pagesize = defaults.integer(forKey: "pagesize") == 0 ? 10 : defaults.integer(forKey: "pagesize")
        self.fromdate = defaults.integer(forKey: "fromdate")
        self.todate = defaults.integer(forKey: "todate")
        self.order = defaults.string(forKey: "order") == nil ? "desc" : defaults.string(forKey: "order")!
        self.sort = defaults.string(forKey: "sort") == nil ? "activity" : defaults.string(forKey: "sort")!
        self.tagged = defaults.string(forKey: "tagged") == nil ? "" : defaults.string(forKey: "tagged")!
        self.intitle = defaults.string(forKey: "intitle") == nil ? "ios" : defaults.string(forKey: "intitle")!
    }
    
    init(pagesize: Int, fromdate: Int, todate: Int, order: String, sort: String, tagged: String = "", intitle: String = "") {
        self.pagesize = pagesize
        defaults.set(pagesize, forKey: "pagesize")
        self.fromdate = fromdate
        defaults.set(fromdate, forKey: "fromdate")
        self.todate = todate
        defaults.set(todate, forKey: "todate")
        self.order = order
        defaults.set(order, forKey: "order")
        self.sort = sort
        defaults.set(sort, forKey: "sort")
        self.tagged = tagged
        defaults.set(tagged, forKey: "tagged")
        self.intitle = intitle
        defaults.set(intitle, forKey: "intitle")
    }
}
