//
//  User.swift
//  GCDExample
//
//  Created by Zhihui Tang on 2018-04-12.
//  Copyright © 2018 Zhihui Tang. All rights reserved.
//

import Foundation

class User: NSObject {
    var name: String
    var year: Int
    var company: String
    
    init(name: String, year: Int, company: String) {
        self.name = name
        self.year = year
        self.company = company
    }
    
    func setProperty(year: Int, company: String) {
        self.year = year
        randomDelay(maxDuration:  0.4)
        
        randomDelay(maxDuration:  0.6)
        self.company = company
    }
    
    override var description: String {
        return "[\(year)] \(company)"
    }
}


class ThreadSafeUser: User {
    let isolationQueue = DispatchQueue(label: "com.crafttang.isolationQueue", attributes: .concurrent)
    override func setProperty(year: Int, company: String) {
        isolationQueue.async(flags: .barrier) {
            super.setProperty(year: year, company: company)
        }
    }
    
    override var description: String {
        return isolationQueue.sync { super.description }
    }
}

/*
class ThreadSafeUser: NSObject {
    let isolationQueue = DispatchQueue(label: "com.crafttang.isolationQueue", attributes: .concurrent)
    var name: String
    var year: Int
    var company: String
    
    init(name: String, year: Int, company: String) {
        self.name = name
        self.year = year
        self.company = company
    }
    
    func setProperty(year: Int, company: String) {
        isolationQueue.async(flags: .barrier) {
            self.year = year
            randomDelay(maxDuration:  0.4)
            
            randomDelay(maxDuration:  0.6)
            self.company = company
        }
    }
    
    override var description: String {
        return isolationQueue.sync { "[\(year)] \(company)" }
    }
}
*/

func randomDelay(maxDuration: Double) {
    let randomWait = arc4random_uniform(UInt32(maxDuration * Double(USEC_PER_SEC)))
    usleep(randomWait)
}

