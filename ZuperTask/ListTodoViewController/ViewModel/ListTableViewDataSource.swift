//
//  ListTableViewDataSource.swift
//  ZuperTask
//
//  Created by vinumurugan E on 19/03/22.
//

import Foundation
import UIKit

enum Types {
    case Todo
    case Tag
}

class ListTableViewDataSource<T>: NSObject, UITableViewDataSource {
    
    var mode:Types = .Todo
    
    var data: DynamicValue<[T]> = DynamicValue([])
    
    var local: DynamicValue<[T]> = DynamicValue([])
    
    var dictObjects = [String:[Info]]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if mode == .Todo {
            return 1
        } else {
            return self.dictObjects.keys.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mode == .Todo {
            return local.value.count
        } else {
            let sortedV = self.dictObjects.keys.sorted()
            return self.dictObjects[sortedV[section]]?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if mode == .Todo {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableVCell", for: indexPath) as! TodoTableVCell
            cell.info = local.value[indexPath.row] as? Info
            return cell
        } else {
            let sortedV = self.dictObjects.keys.sorted()
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTagTableViewCell", for: indexPath) as! TodoTagTableViewCell
            cell.info = self.dictObjects[sortedV[indexPath.section]]?[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if mode == .Tag {
        let sortedV = self.dictObjects.keys.sorted()
        return sortedV[section]
        }
        return ""
    }
    
}
