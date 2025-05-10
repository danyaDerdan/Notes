//
//  ToDo+CoreDataProperties.swift
//  Notes
//
//  Created by Данил Толстиков on 16.04.2025.
//
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var date: String?
    @NSManaged public var isDone: Bool

}
