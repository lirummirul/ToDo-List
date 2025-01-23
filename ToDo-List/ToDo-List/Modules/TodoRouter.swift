//
//  Router.swift
//  ToDo-List
//
//  Created by Лада on 22.01.2025.
//

import UIKit

class TodoRouter {
    weak var viewController: UIViewController?
    
    func createTodoModule() -> UIViewController {
        
        let view = TableViewController()
        let interactor = TodoInteractor()
        let presenter = TodoPresenter()

        view.interactor = interactor
        view.presenter = presenter

        interactor.output = presenter

        presenter.view = view

        return view
    }
//    
//    func navigateToDetail(with mainText: String) {
//        let detailViewController = TodoItemViewController()
//        detailViewController.mainText = mainText
//        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
//    }
}
