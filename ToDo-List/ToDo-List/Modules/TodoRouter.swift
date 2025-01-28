//
//  Router.swift
//  ToDo-List
//
//  Created by Лада on 22.01.2025.
//

import UIKit

class TodoRouter {
    static let shared = TodoRouter()
    weak var viewController: UIViewController?
    
    func createTodoModule() -> UIViewController {
        
        let view = TableViewController()
        let interactor = TodoInteractor()
        let presenter = TodoPresenter(interactor: interactor)

        view.interactor = interactor
        view.presenter = presenter

        interactor.output = presenter

        presenter.view = view
        self.viewController = view

        return view
    }
    
    func navigateToDetail(with todo: Todo) {
        let detailViewController = TodoItemViewController(todo: todo)
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func navigateToAddTodo(with todos: [Todo], onTodoAdded: @escaping (Todo) -> Void) {
        let addTodoViewController = AddTodoViewController(todos: todos, onTodoAdded: onTodoAdded)
        viewController?.navigationController?.pushViewController(addTodoViewController, animated: true)
    }
    func navigateToMainViewController() {
        guard let navigationController = viewController?.navigationController else {
            print("NavigationController is nil")
            return
        }
        navigationController.popViewController(animated: true)
    }
}
