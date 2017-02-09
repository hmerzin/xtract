//
//  Persistance.swift
//  xtract
//
//  Created by Harry Merzin on 2/7/17.
//  Copyright © 2017 Harry Merzin. All rights reserved.
//

import Foundation
import RealmSwift

class Persistance {
    
    static func saveItem(item: Xtracted) {
        do {
            let realm = try Realm()
             try realm.write {
                realm.add(item)
            }
        } catch {
            print("issue with realm")
        }
    }
    
    static func getItems() -> [Xtracted] {
        var items = [Xtracted]()
        do {
            let realm = try Realm()
            items = Array(realm.objects(Xtracted.self))
        } catch let error as NSError {
            print(error)
        }
        
        return items
    }
    
    static func updateItem(xtracted: Xtracted, title: String, content: String) {
        do {
            let realm = try Realm()
            try realm.write {
                xtracted.title = title 
                xtracted.content = content
                print(title)
            }
        } catch {
            print("errors")
        }
    }
    
    static func deleteItems(item: Xtracted) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(item)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
}
