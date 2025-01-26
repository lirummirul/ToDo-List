//
//  AddTodoViewController.swift
//  ToDo-List
//
//  Created by Лада on 23.01.2025.
//

import UIKit

class AddTodoViewController: UIViewController {
    var todos: [Todo]
    var onTodoAdded: ((Todo) -> Void)?
    
    init(todos: [Todo], onTodoAdded: @escaping (Todo) -> Void) {
        self.todos = todos
        self.onTodoAdded = onTodoAdded
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Добавить заметку"
        return label
    }()
    
    private let titleLabelTextView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .white
        label.text = "Название заметки"
        return label
    }()
    
    private let descriptionLabelTextView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .white
        label.text = "Описание заметки"
        return label
    }()

    private let titleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = .white
        textView.backgroundColor = .darkGray
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return textView
    }()

    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = .white
        textView.backgroundColor = .darkGray
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return textView
    }()

    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupViews()
        configureNavigationBar()
    }

    private func setupViews() {
        [titleLabel, titleLabelTextView, titleTextView, descriptionLabelTextView, descriptionTextView, addButton].forEach {
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            titleLabelTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            titleLabelTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabelTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            titleTextView.topAnchor.constraint(equalTo: titleLabelTextView.bottomAnchor, constant: 8),
            titleTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleTextView.heightAnchor.constraint(equalToConstant: 50),
            
            descriptionLabelTextView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 16),
            descriptionLabelTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabelTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabelTextView.bottomAnchor, constant: 8),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 120),

            addButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 16),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func configureNavigationBar() {
        // Создание UIImageView для стрелочки
        let backArrowImageView = UIImageView(image: UIImage(systemName: "chevron.left"))
        backArrowImageView.tintColor = .yellow
        backArrowImageView.translatesAutoresizingMaskIntoConstraints = false

        // Создание UIButton для текста
        let backButton = UIButton(type: .system)
        backButton.setTitle("Назад", for: .normal)
        backButton.setTitleColor(.yellow, for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 20) // Увеличьте размер шрифта
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        // Создание UIStackView для объединения стрелочки и текста
        let stackView = UIStackView(arrangedSubviews: [backArrowImageView, backButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // Создание UIBarButtonItem с кастомным представлением
        let barButtonItem = UIBarButtonItem(customView: stackView)

        // Установка кастомной кнопки в качестве левой кнопки навигационного бара
        self.navigationItem.leftBarButtonItem = barButtonItem
    }

    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc private func addButtonTapped() {
        guard let title = titleTextView.text, !title.isEmpty,
              let description = descriptionTextView.text, !description.isEmpty else {
            let alert = UIAlertController(title: "Ошибка", message: "Пожалуйста, заполните все поля", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        let maxId = todos.map { $0.id }.max() ?? 0
        let maxUserId = todos.map { $0.userId }.max() ?? 0

        let newTodo = Todo(id: maxId + 1, todo: title, completed: false, userId: maxUserId + 1, desc: description, date: Date.now)
        onTodoAdded?(newTodo)
        self.navigationController?.popViewController(animated: true)
//        router.navigateToMainViewController()
    }
}
