//
//  Task.swift
//  todo
//
//  Created by Ana Carolina on 02/09/25.
//

import SwiftUI
import SwiftData
import Combine

enum Status: String, Codable, CaseIterable {
    case todo = "To Do"
    case doing = "Doing"
    case done = "Done"
}

enum Priority: String, Codable, CaseIterable {
    case high = "High"
    case medium = "Medium"
    case low = "Low"
}

@Model
final class TodoTask: Identifiable {
    var id: UUID
    var title: String
    var taskDescription: String
    var priority: Priority
    var status: Status

    init(id: UUID = UUID(), title: String, description: String, priority: Priority, status: Status) {
        self.id = id
        self.title = title
        self.taskDescription = description
        self.priority = priority
        self.status = status
    }
    
    convenience init(from codableTask: TodoTaskCodable) {
        self.init(title: codableTask.title, description: codableTask.taskDescription, priority: codableTask.priority, status: codableTask.status)
    }
}

struct TodoTaskCodable: Codable, Transferable, Identifiable {
    let id: UUID
    let title: String
    let taskDescription: String
    let priority: Priority
    let status: Status
    
    init(from task: TodoTask) {
        self.id = task.id
        self.title = task.title
        self.taskDescription = task.taskDescription
        self.priority = task.priority
        self.status = task.status
    }
    
    init(id: UUID = UUID(), title: String, description: String, priority: Priority, status: Status) {
        self.id = id
        self.title = title
        self.taskDescription = description
        self.priority = priority
        self.status = status
    }
    
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(exportedContentType: .text) { codableText in
            try JSONEncoder().encode(codableText)
        }
    }
}
