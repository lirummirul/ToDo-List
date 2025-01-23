//
//  TableViewController.swift
//  ToDo-List
//
//  Created by Лада on 21.01.2025.
//

import UIKit

protocol TableViewInput: AnyObject {
    // отображить список
    func presentTodos(todos: [Todo])
    // отобразить ошибку (алёрт)
    func showError(error: String)
}

protocol TableViewOutput: AnyObject {
    // view готова к отображению
}

class TableViewController: UIViewController {
    var todos: [Todo] = []
    var router: TodoRouter!
    var interactor: TodoInteractorInput!
    var presenter: TodoPresenterInput!

    private let lable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        lable.text = "Задачи"
        lable.textColor = .white
        return lable
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .black
        return tableView
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        interactor.fetchTodos()
        setup()
    }
    
    func setup() {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")

        [lable, tableView].forEach {
            stack.addArrangedSubview($0)
        }
        
        self.view.addSubview(stack)
//        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            lable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            lable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            lable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            lable.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -16),
            
            stack.topAnchor.constraint(equalTo: view.topAnchor),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.configure(with: todos[indexPath.row])
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        router.navigateToDetail(with: lable.text ?? "")
//    }
}


extension TableViewController: TableViewInput {
    func presentTodos(todos: [Todo]) {
        self.todos = todos
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
