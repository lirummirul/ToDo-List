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
}

struct TodosResponse: Codable {
    let todos: [Todo]
}
