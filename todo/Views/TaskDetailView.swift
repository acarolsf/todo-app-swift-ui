//
//  TaskDetailView.swift
//  todo
//
//  Created by Ana Carolina on 02/09/25.
//

import SwiftUI

struct TaskDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: TaskViewModel
    
    let task: TodoTask
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Detalhes da Tarefa")
                .font(.largeTitle)
                .bold()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Título")
                    .font(.headline)
                Text(task.title)
                    .font(.subheadline)
                    .padding(.horizontal, 10)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Descrição")
                    .font(.headline)
                Text(task.taskDescription)
                    .font(.subheadline)
                    .padding(.horizontal, 10)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Prioridade")
                    .font(.headline)
                Text(task.priority.rawValue)
                    .font(.subheadline)
                    .foregroundStyle(priorityColor(task.priority))
                    .padding(.horizontal, 10)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Status atual")
                    .font(.headline)
                Text(task.status.rawValue)
                    .font(.subheadline)
                    .padding(.horizontal, 10)
            }
            
            Spacer()
            
            if let nextStatus = getNextStatus(for: task.status) {
                Button("Mover para '\(nextStatus.rawValue)'") {
                    viewModel.updateStatus(for: task, to: nextStatus)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .navigationTitle(task.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func getNextStatus(for status: Status) -> Status? {
        switch status {
        case .todo: return .doing
        case .doing: return .done
        case .done: return nil
        }
    }
    
    private func priorityColor(_ priority: Priority) -> Color {
        switch priority {
        case .high:
            return .red
        case .medium:
            return .orange
        case .low:
            return .green
        }
    }
}
