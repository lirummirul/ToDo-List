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
    
    private let addButton: UIButton = {
         let button = UIButton(type: .system)
         button.translatesAutoresizingMaskIntoConstraints = false
         button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
         return button
     }()
    
    private let plusImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.image = UIImage(systemName: "plus")
         imageView.tintColor = .white
         imageView.contentMode = .scaleAspectFit
         return imageView
     }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .black
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .systemGray2
        return tableView
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    private let stackHorizontal: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
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
        addButton.addSubview(plusImageView)
        [lable, addButton].forEach {
            stackHorizontal.addArrangedSubview($0)
        }

        [stackHorizontal, tableView].forEach {
            stack.addArrangedSubview($0)
        }
        
        self.view.addSubview(stack)
//        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            lable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            lable.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -16),
            lable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            lable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            stack.topAnchor.constraint(equalTo: view.topAnchor),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            addButton.widthAnchor.constraint(equalToConstant: 35),
            addButton.heightAnchor.constraint(equalToConstant: 35),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            plusImageView.centerXAnchor.constraint(equalTo: addButton.centerXAnchor),
            plusImageView.centerYAnchor.constraint(equalTo: addButton.centerYAnchor),
            plusImageView.widthAnchor.constraint(equalToConstant: 30),
            plusImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc private func addButtonTapped() {
        // Вызываем метод роутера для перехода на экран добавления новой заметки
        TodoRouter.shared.navigateToAddTodo(with: todos) { [weak self] newTodo in
            guard let self = self else { return }
            self.todos.insert(newTodo, at: 0)
            self.tableView.reloadData()
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TodoRouter.shared.navigateToDetail(with: todos[indexPath.row])
    }
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
