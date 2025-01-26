//
//  Todo.swift
//  ToDo-List
//
//  Created by Лада on 21.01.2025.
//

import Foundation

struct Todo: Codable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
    var desc: String?
    var date: Date?
    
//    mutating func isComplited(completed: Bool) {
//        self.completed = completed
//    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case todo
        case completed
        case userId
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        todo = try container.decode(String.self, forKey: .todo)
        completed = try container.decode(Bool.self, forKey: .completed)
        userId = try container.decode(Int.self, forKey: .userId)
        desc = nil
        date = nil
    }
    
    // Дока 
    init(id: Int,
         todo: String,
         completed: Bool,
         userId: Int,
         desc: String? = nil,
         date: Date? = nil
    ) {
        self.id = id
        self.todo = todo
        self.completed = completed
        self.userId = userId
        self.desc = desc
        self.date = date
    }
}

struct TodosResponse: Codable {
    let todos: [Todo]
}
