//
//  ViewController.swift
//  RED NOTE
//
//  Created by orekhova on 06/11/2018.
//  Copyright © 2018 Julika Orekhova Corp. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var titleNote: UILabel!
    @IBOutlet weak var dateNote: UILabel!
    fileprivate var dataManager: RealmDataManager?
    fileprivate var dataSource: RealmDataSource?
    override func viewDidLoad() {
        dataManager = RealmDataManager()
        dataSource = RealmDataSource()
//        dataManager?.saveOrUpdate(note: NoteRealm(id: 0, title:"First Note",text:"Description",weather:"Warm",coords:"0:0"))
//        dataManager?.saveOrUpdate(note: NoteRealm(id: 1, title:"Second Note",text:"Description",weather:"Warm",coords:"0:0"))
        dataSource?.setup(with: mainTableView)
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            dataManager?.removeNote(id: indexPath.row)
        }
    }


}

