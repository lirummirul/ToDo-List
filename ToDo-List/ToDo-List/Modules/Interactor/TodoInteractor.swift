////
////  TodoParser.swift
////  ToDo-List
////
////  Created by Лада on 22.01.2025.
////
//
//import UIKit
//import CoreData
//
//protocol TodoInteractorInput {
//    func fetchTodos()
//    func fetchTodosFromCoreData()
//}
//
//protocol TodoInteractorOutput: AnyObject {
//    func didFetchTodos(result: Result<[Todo], Error>)
////    func presentTodos(todos: [Todo])
////    func showError(error: String)
//}
//
//class TodoInteractor: TodoInteractorInput {
//    weak var output: TodoInteractorOutput?
//    private let parser = Parser()
//    private var coreDataTodos: [Todo] = []
//
//    func fetchTodos() {
//        fetchTodosFromCoreData()
//        guard let url = URL(string: "https://dummyjson.com/todos") else {
//            output?.didFetchTodos(result: .failure(JSONParsingError.invalidData))
//            return
//        }
//
////        parser.fetchAndParse(from: url) { result in
////            self.output?.didFetchTodos(result: result)
////        }
//        parser.fetchAndParse(from: url) { result in
//            switch result {
//            case .success(let todos):
//                self.saveToCoreData(todos: todos)
//                self.combineAndPresentTodos()
//            case .failure(let error):
//                self.output?.didFetchTodos(result: .failure(error))
//            }
//        }
//    }
//    
////    func fetchTodosCoreData() {
////        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
////        let fetchRequest: NSFetchRequest<ToDoListItem> = ToDoListItem.fetchRequest()
////
////        do {
////            let todos = try context.fetch(fetchRequest)
////            let todoModels = todos.map { Todo(id: Int($0.id), todo: $0.todo, completed: $0.completed, userId: Int($0.userId), desc: $0.desc, date: $0.date) }
////            output?.presentTodos(todos: todoModels)
////        } catch {
////            output?.showError(error: error.localizedDescription)
////        }
////    }
//    
//    func fetchTodosFromCoreData() {
//        DispatchQueue.main.async {
//            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//            let fetchRequest: NSFetchRequest<ToDoListItem> = ToDoListItem.fetchRequest()
//            
//            do {
//                let todos = try context.fetch(fetchRequest)
//                let todoModels = todos.map { Todo(id: Int($0.id), todo: $0.todo, completed: $0.completed, userId: Int($0.userId), desc: $0.desc, date: $0.date) }
//                self.output?.didFetchTodos(result: .success(todoModels))
//            } catch {
//                self.output?.didFetchTodos(result: .failure(error))
//            }
//        }
//    }
//    
//    private func combineAndPresentTodos() {
//        DispatchQueue.main.async {
//            let combinedTodos = self.coreDataTodos + self.coreDataTodos
//            self.output?.didFetchTodos(result: .success(combinedTodos))
//        }
//    }
//
//    private func saveToCoreData(todos: [Todo]) {
//        DispatchQueue.main.async {
//            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//            for todo in todos {
//                let todoItem = ToDoListItem(context: context)
//                todoItem.id = Int32(todo.id)
//                todoItem.todo = todo.todo
//                todoItem.completed = todo.completed
//                todoItem.userId = Int32(todo.userId)
//                todoItem.desc = todo.desc
//                todoItem.date = todo.date
//            }
//            do {
//                try context.save()
//            } catch {
//                self.output?.didFetchTodos(result: .failure(error))
//            }
//        }
//    }
//}

import UIKit
import CoreData

protocol TodoInteractorInput {
    func fetchTodos()
    func fetchTodosFromCoreData()
}

protocol TodoInteractorOutput: AnyObject {
    func didFetchTodos(result: Result<[Todo], Error>)
}

class TodoInteractor: TodoInteractorInput {
    weak var output: TodoInteractorOutput?
    private let parser = Parser()
    private var coreDataTodos: [Todo] = []

    func fetchTodos() {
        fetchTodosFromCoreData()
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            output?.didFetchTodos(result: .failure(JSONParsingError.invalidData))
            return
        }

        parser.fetchAndParse(from: url) { result in
            switch result {
            case .success(let todos):
                self.saveToCoreData(todos: todos)
                self.combineAndPresentTodos()
            case .failure(let error):
                self.output?.didFetchTodos(result: .failure(error))
            }
        }
    }

    func fetchTodosFromCoreData() {
        DispatchQueue.main.async {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<ToDoListItem> = ToDoListItem.fetchRequest()

            do {
                let todos = try context.fetch(fetchRequest)
                self.coreDataTodos = todos.map { Todo(id: Int($0.id), todo: $0.todo, completed: $0.completed, userId: Int($0.userId), desc: $0.desc, date: $0.date) }
                self.output?.didFetchTodos(result: .success(self.coreDataTodos))
            } catch {
                self.output?.didFetchTodos(result: .failure(error))
            }
        }
    }

    private func combineAndPresentTodos() {
        DispatchQueue.main.async {
            let combinedTodos = self.coreDataTodos + self.coreDataTodos
            self.output?.didFetchTodos(result: .success(combinedTodos))
        }
    }

    private func saveToCoreData(todos: [Todo]) {
        DispatchQueue.main.async {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            for todo in todos {
                let todoItem = ToDoListItem(context: context)
                todoItem.id = Int32(todo.id)
                todoItem.todo = todo.todo
                todoItem.completed = todo.completed
                todoItem.userId = Int32(todo.userId)
                todoItem.desc = todo.desc
                todoItem.date = todo.date
            }
            do {
                try context.save()
            } catch {
                self.output?.didFetchTodos(result: .failure(error))
            }
        }
    }
}
