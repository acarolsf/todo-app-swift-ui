//
//  KanbanColumn.swift
//  todo
//
//  Created by Ana Carolina on 02/09/25.
//

import SwiftUI

struct KanbanColumn: View {
    let title: String
    let status: Status
    let tasks: [TodoTask]
    let viewModel: TaskViewModel
    
    @Binding var draggedTask: TodoTask?
    
    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.headline)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            ForEach(tasks) { task in
                NavigationLink(destination: TaskDetailView(viewModel: viewModel, task: task)) {
                    TaskCardView(task: task)
                }
//                .onDrag {
//                    draggedTask = task
//                    return NSItemProvider(object: TodoTaskCodable(from: task) as NSItemProviderWriting)
//                }
            }
//            .onDrop(of: [.text], isTargeted: nil) { providers in
//                guard let provider = providers.first else { return false }
//                
//                Task {
//                    if let loadedCodableTask = await provider.loadTransferable(type: TodoTaskCodable.self) {
//                        if let taskToUpdate = viewModel.modelContext.fetchTodoTask(for: loadedCodableTask.id) {
//                            await viewModel.updateStatus(for: taskToUpdate, to: status)
//                        } else {
//                            let newTodoTask = TodoTask(from: loadedCodableTask)
//                            await viewModel.saveTask(newTodoTask)
//                        }
//                    }
//                }
//                
//                return true
//            }
            
            Spacer()
        }
        .frame(width: 250)
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(12)
    }
}
