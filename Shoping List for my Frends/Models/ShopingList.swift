//
//  ShopingList.swift
//  Shoping List for my Frends
//
//  Created by Brubrusha on 12/7/20.
//

import Foundation
import Firebase

struct ShopingList {
    let title: String
    let uid: String
    let ref: DatabaseReference?
    var completed: Bool = false
    
    init(title: String, uid: String) {
        self.title = title
        self.uid = uid
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        title = snapshotValue["title"] as! String
        uid = snapshotValue["uid"] as! String
        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
        
    }
    
    func convertedDictionary() -> Any {
        return ["title" : title, "uid": uid, "completed": completed]
    }
}

struct Shop {
    let title: String
    let note: String
    let uid: String
    let ref: DatabaseReference!
    var completed: Bool = false
    
    init(title: String, uid: String, note: String) {
        self.title = title
        self.uid = uid
        self.ref = nil
        self.note = note
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        title = snapshotValue["title"] as! String
        uid = snapshotValue["uid"] as! String
        completed = snapshotValue["uid"] as! Bool
        note = snapshotValue["note"] as! String
        ref = snapshot.ref
    }
    
    func convertedDictionary() -> Any {
        return ["title" : title, "uid": uid, "completed": completed, "note": note]
    }
}
