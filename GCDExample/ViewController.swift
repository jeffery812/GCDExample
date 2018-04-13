//
//  ViewController.swift
//  GCDExample

//
//  Created by Zhihui Tang on 2018-04-12.
//  Copyright © 2018 Zhihui Tang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let dispatchQueue = DispatchQueue(label: "com.crafttang.concurrency", attributes: .concurrent)
    let dispatchGroup = DispatchGroup()
    let workHistory = [(1998, "Hisun"),(2004, "Huawei"),(2008, "Baidu"),(2010, "Google"), (2015, "eBuilder")]

    // Concurrent test1
    @IBAction func button1Tapped(_ sender: UIButton) {
        let user = User(name: "Magnus", year: 1990, company: "Not working")
        beginWorking(user: user, workHistory: workHistory)
    }
    
    // Concurrent test2
    @IBAction func button2Tapped(_ sender: UIButton) {
        let user = ThreadSafeUser(name: "Magnus", year: 1990, company: "Not working")
        beginWorking(user: user, workHistory: workHistory)
    }
    
    private func beginWorking(user: User, workHistory: [(Int, String)]) {
        for (year, company) in workHistory {
            dispatchQueue.async(group: dispatchGroup) {
                user.setProperty(year: year, company: company)
                print("Current user: \(user)")
            }
        }
        dispatchGroup.notify(queue: DispatchQueue.global()) {
            print("==> Final user: \(user)")
        }
    }
}

