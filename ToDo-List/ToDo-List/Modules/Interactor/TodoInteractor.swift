//
//  TodoParser.swift
//  ToDo-List
//
//  Created by Лада on 22.01.2025.
//

import Foundation

protocol TodoInteractorInput {
    func fetchTodos()
}

protocol TodoInteractorOutput: AnyObject {
    func didFetchTodos(result: Result<[Todo], Error>)
}

class TodoInteractor: TodoInteractorInput {
    weak var output: TodoInteractorOutput?
    private let parser = Parser()

    func fetchTodos() {
        guard let url = URL(string: "https://run.mocky.io/v3/3e770bdf-b83d-4429-82e7-9c7deaf14d30") else {
            output?.didFetchTodos(result: .failure(JSONParsingError.invalidData))
            return
        }

        parser.fetchAndParse(from: url) { result in
            self.output?.didFetchTodos(result: result)
        }
    }
}
