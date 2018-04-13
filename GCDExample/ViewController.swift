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
    let contacts = [("Leijun", "leijun@mi.com"), ("Luoyonghao", "luoyonghao@smartisan.com"), ("Yuchengdong", "yuchengdong@huawei.com"), ("Goodguy", "crafttang@gmail.com")]

    // Concurrent test1
    @IBAction func button1Tapped(_ sender: UIButton) {
        let person = Person(name: "unknown", email: "unknown")
        updateContact(person: person, contacts: contacts)
    }
    
    // Concurrent test2
    @IBAction func button2Tapped(_ sender: UIButton) {
        let person = ThreadSafePerson(name: "unknown", email: "unknown")
        updateContact(person: person, contacts: contacts)
    }
    
    private func updateContact(person: Person, contacts: [(String, String)]) {
        for (name, email) in contacts {
            dispatchQueue.async(group: dispatchGroup) {
                person.setProperty(name: name, email: email)
                print("Current person: \(person)")
            }
        }
        dispatchGroup.notify(queue: DispatchQueue.global()) {
            print("==> Final person: \(person)")
        }
    }
}

