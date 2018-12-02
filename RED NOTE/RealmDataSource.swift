//
//  RealmDataSource.swift
//  RED NOTE
//
//  Created by andrey.belyaev on 25/11/2018.
//  Copyright © 2018 Julika Orekhova Corp. All rights reserved.
//

import UIKit
import RealmSwift

class RealmDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    fileprivate let realm = try! Realm()
    
    fileprivate weak var tableView: UITableView?
    
    fileprivate var notificationToken: NotificationToken?
    fileprivate var results: Results<NoteRealm>?
    
    func setup(with tableView: UITableView?) {
        self.tableView = tableView
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.tableView?.register(UINib.init(nibName: "NoteCell", bundle: nil), forCellReuseIdentifier: "NoteCell")
        
        results = realm.objects(NoteRealm.self).sorted(byKeyPath: "id")
        
        // Observe Results Notifications
        notificationToken?.invalidate()
        notificationToken = results?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else {
                return
            }
            
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                tableView.reloadData()
                break
                
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
                break
                
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
                break
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        if let note = results?[indexPath.row] {
            if let castedCell = cell as? UICell {
                castedCell.fillCell(with: note)
                }
            }
        return cell
    }
    deinit {
        notificationToken?.invalidate()
    }
}
