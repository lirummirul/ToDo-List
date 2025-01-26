//
//  TableViewCell.swift
//  ToDo-List
//
//  Created by Лада on 21.01.2025.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var onButtonTapped: (() -> Void)?
    static let lableFont: CGFloat = 22
    static let descFont: CGFloat = 16
    static let spacing: CGFloat = 16
    
    let button: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private let checkmarkImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.contentMode = .scaleAspectFit
         return imageView
     }()

    private let todoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: lableFont)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let desc: UILabel = {
        let desc = UILabel()
        desc.translatesAutoresizingMaskIntoConstraints = false
        desc.font = UIFont.systemFont(ofSize: descFont)
        desc.textColor = .white
        desc.numberOfLines = 0
        desc.lineBreakMode = .byWordWrapping
        return desc
    }()
    
//    private let data: Date = {
//        let date = Date()
////        date.translatesAutoresizingMaskIntoConstraints = false
////        date
//        date.font = UIFont.systemFont(ofSize: 16)
//        date.textColor = .white
//        return date
//    }()
    
//    private lazy var dateLabel: UILabel = {
//        let date = Date()
//        let dateString = formatDate(date)
//
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.systemFont(ofSize: 16)
//        label.textColor = .white
//        label.text = dateString
//        return label
//    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = spacing
        return stack
    }()
    
    private let stackVertical: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = spacing
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
//    private func formatDate(_ date: Date) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd/MM/yyyy"
//        return dateFormatter.string(from: date)
//    }
    
    private func setupView() {
        contentView.backgroundColor = .black
        button.addSubview(checkmarkImageView)
        [todoLabel].forEach {
            stackVertical.addArrangedSubview($0)
        }
        [button, stackVertical].forEach {
            stack.addArrangedSubview($0)
        }
        contentView.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            button.widthAnchor.constraint(equalToConstant: 35),
            button.heightAnchor.constraint(equalToConstant: 35),
            
            checkmarkImageView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            checkmarkImageView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 35), // Увеличьте ширину изображения
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 35) // Увеличьте высоту изображения
                  
        ])
    }

    func configure(with todo: Todo) {
        todoLabel.text = todo.todo
        button.isSelected = todo.completed
        updateButtonImage()
        updateButtonColor()
        updateLabelStrikeThrough()
//        desc.text = todo.desc
//        dateLabel.text = formatDate(todo.date)
    }
    
    @objc private func buttonTapped() {
        button.isSelected.toggle()
        updateButtonImage()
        updateButtonColor()
        onButtonTapped?()
        updateLabelStrikeThrough()
    }
    
    private func updateButtonImage() {
        let imageName = button.isSelected ? "checkmark.circle.fill" : "circle"
        checkmarkImageView.image = UIImage(systemName: imageName)
    }
    
    private func updateButtonColor() {
        button.tintColor = button.isSelected ? .yellow : .white
    }
    
    private func updateLabelStrikeThrough() {
        let attributedString = NSMutableAttributedString(string: todoLabel.text ?? "")
        if button.isSelected {
            attributedString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        } else {
            attributedString.removeAttribute(.strikethroughStyle, range: NSRange(location: 0, length: attributedString.length))
        }
        todoLabel.attributedText = attributedString
    }
}
