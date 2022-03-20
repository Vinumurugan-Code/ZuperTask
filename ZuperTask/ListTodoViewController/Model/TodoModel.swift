//
//  TodoModel.swift
//  ZuperTask
//
//  Created by vinumurugan E on 17/03/22.
//

import Foundation

struct Todo:Codable {
    let data : [Info]
}

struct Info:Codable {
    var title:String?
    var author:String?
    var tag:String?
    var is_completed:Bool?
    var priority:String?
    var id:Int?

}
