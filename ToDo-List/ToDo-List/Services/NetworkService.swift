//
//  NetworkService.swift
//  ToDo-List
//
//  Created by Лада on 22.01.2025.
//

import Foundation

enum JSONParsingError: Error {
    case invalidData
    case decodingFailed
    case networkError(Error)
}

class Parser {
    func fetchAndParse(from url: URL, completion: @escaping (Result<[Todo], Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(JSONParsingError.networkError(error)))
                return
            }

            guard let data = data else {
                completion(.failure(JSONParsingError.invalidData))
                return
            }

            do {
                let todos = try JSONDecoder().decode(TodosResponse.self, from: data)
                completion(.success(todos.todos))
            } catch {
                completion(.failure(JSONParsingError.decodingFailed))
            }
        }
        task.resume()
    }
}
