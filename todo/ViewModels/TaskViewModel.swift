//
//  TaskViewModel.swift
//  todo
//
//  Created by Ana Carolina on 02/09/25.
//

import SwiftUI
import SwiftData
import Combine

class TaskViewModel: ObservableObject {
    
    var modelContext: ModelContext
    
    @MainActor var isLoading = false
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    @MainActor func saveTask(_ task: TodoTask) async {
        isLoading = true
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        modelContext.insert(task)
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving task: \(error)")
        }
        
        isLoading = false
    }
    
    func updateStatus(for task: TodoTask, to newStatus: Status) {
        task.status = newStatus
        
        do {
            try modelContext.save()
        } catch {
            print("Error updating task status: \(error)")
        }
    }
}

extension ModelContext {
    
    func fetchTodoTask(for id: UUID) -> TodoTask? {
        let predicate = #Predicate<TodoTask> { $0.id == id }
        
        var descriptor = FetchDescriptor(predicate: predicate)
        descriptor.fetchLimit = 1
        
        do {
            return try self.fetch(descriptor).first
        } catch {
            print("Error fetching todo task: \(error)")
            return nil
        }
    }
}
