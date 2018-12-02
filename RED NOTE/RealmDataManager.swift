//
//  RealmDataManager.swift
//  RED NOTE
//
//  Created by andrey.belyaev on 15/11/2018.
//  Copyright © 2018 Julika Orekhova Corp. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDataManager {
    
    let realm = try! Realm()
    
    func saveOrUpdate(note: NoteRealm) {
            try! realm.write {
                realm.add(note, update: true)
            }
    }
    
    func getNote(id: Int) -> NoteRealm? {
        // object(ofType: NoteRealm.self, forPrimaryKey: id)
        guard let note = realm.objects(NoteRealm.self).filter("id == %@", id).first else {
            return nil
        }
        
        return note
    }
    
    func removeNote(id: Int) {
        realm.delete(self.getNote(id: id)!)
    }
    
}
