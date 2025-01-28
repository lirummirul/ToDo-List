//
//  ToDoListItem+CoreDataProperties.swift
//  ToDo-List
//
//  Created by Лада on 28.01.2025.
//
//

import Foundation
import CoreData


extension ToDoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListItem> {
        return NSFetchRequest<ToDoListItem>(entityName: "ToDoListItem")
    }

    @NSManaged public var id: Int32
    @NSManaged public var todo: String
    @NSManaged public var completed: Bool
    @NSManaged public var userId: Int32
    @NSManaged public var desc: String?
    @NSManaged public var date: Date?

}

extension ToDoListItem : Identifiable {

}
