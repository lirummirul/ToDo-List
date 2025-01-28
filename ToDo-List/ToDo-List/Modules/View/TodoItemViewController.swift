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
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func configureNavigationBar() {
            let backArrowImageView = UIImageView(image: UIImage(systemName: "chevron.left"))
            backArrowImageView.tintColor = .yellow
            backArrowImageView.translatesAutoresizingMaskIntoConstraints = false

            let backButton = UIButton(type: .system)
            backButton.setTitle("Назад", for: .normal)
            backButton.setTitleColor(.yellow, for: .normal)
            backButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            backButton.translatesAutoresizingMaskIntoConstraints = false
            backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
            let stackView = UIStackView(arrangedSubviews: [backArrowImageView, backButton])
            stackView.axis = .horizontal
            stackView.spacing = 8
            stackView.alignment = .center
            stackView.translatesAutoresizingMaskIntoConstraints = false

            let barButtonItem = UIBarButtonItem(customView: stackView)

            self.navigationItem.leftBarButtonItem = barButtonItem
        }

    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
