//
//  TodoPresenter.swift
//  ToDo-List
//
//  Created by Лада on 22.01.2025.
//

import Foundation

protocol TodoPresenterInput: AnyObject {
    func presentTodos(result: Result<[Todo], Error>)
    func fetchTodosFromCoreData()
}

//protocol TodoPresenterOutput: AnyObject {
//    func presentTodos(todos: [Todo])
//    func showError(error: String)
//}

class TodoPresenter: TodoPresenterInput, TodoInteractorOutput {
    weak var view: TableViewInput?
    var interactor: TodoInteractorInput
    
    init(interactor: TodoInteractorInput) {
        self.interactor = interactor
    }
    
    func didFetchTodos(result: Result<[Todo], Error>) {
        DispatchQueue.main.async {
            self.presentTodos(result: result)
        }
    }

    func presentTodos(result: Result<[Todo], Error>) {
        switch result {
        case .success(let todos):
            view?.presentTodos(todos: todos)
        case .failure(let error):
            view?.showError(error: error.localizedDescription)
        }
    }

    func fetchTodosFromCoreData() {
        interactor.fetchTodosFromCoreData()
    }
    
//    func didFetchTodos(result: Result<[Todo], any Error>) {
//        DispatchQueue.main.async {
//            switch result {
//            case .success(let todos):
//                self.view?.presentTodos(todos: todos)
//            case .failure(let error):
//                self.view?.showError(error: error.localizedDescription)
//            }
//        }
//    }

//    func presentTodos(result: Result<[Todo], Error>) {
//        switch result {
//        case .success(let todos):
//            view?.presentTodos(todos: todos)
//        case .failure(let error):
//            view?.showError(error: error.localizedDescription)
//        }
//    }
}
