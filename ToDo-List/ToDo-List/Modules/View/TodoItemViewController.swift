//
//  TodoItemViewController.swift
//  ToDo-List
//
//  Created by Лада on 22.01.2025.
//

import UIKit

class TodoItemViewController: UIViewController {
    var todo: Todo
    
    init(todo: Todo) {
        self.todo = todo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupViews()
        configureNavigationBar()
    }

    private func setupViews() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = todo.todo

        view.addSubview(label)

        NSLayoutConstraint.activate([
            
            /*
             lable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
             lable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
             lable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
             lable.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -16),
             */
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
//            label.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
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
}
