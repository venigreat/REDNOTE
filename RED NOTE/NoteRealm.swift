//
//  NoteRealm.swift
//  RED NOTE
//
//  Created by andrey.belyaev on 15/11/2018.
//  Copyright © 2018 Julika Orekhova Corp. All rights reserved.
//

import Foundation
import RealmSwift

class NoteRealm: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var text = ""
    @objc dynamic var photos = "attack_on_titan"
    @objc dynamic var weather = ""
    @objc dynamic var date = ""
    @objc dynamic var coords = ""
    override static func primaryKey() -> String? {
        return "id"
    }
    convenience init(id: Int, title:String, text:String, weather: String, coords: String){
        self.init()
        self.id = id
        self.title = title
        self.text = text
        self.weather = weather
        self.date = NSDate().description
        self.coords = coords
    }
    
}
