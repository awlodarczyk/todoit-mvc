//
//  TodoItem.swift
//  todo
//
//  Created by Adam Wlodarczyk on 27/03/2019.
//  Copyright © 2019 Adam Wlodarczyk. All rights reserved.
//

import Foundation

enum Priority: Int, Codable{
    case normal
    case important
    case urgent
}

struct TodoItem: Codable {
    let id: Int
    let name: String
    var done: Bool
    var priority : Priority
    let createdAt: Date
}
