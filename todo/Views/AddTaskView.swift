//
//  AddTaskView.swift
//  todo
//
//  Created by Ana Carolina on 02/09/25.
//

import SwiftUI
import Combine

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: TaskViewModel
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var priority: Priority = .medium
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("Detalhes da Tarefa")) {
                        TextField("Título", text: $title)
                        TextEditor(text: $description)
                            .frame(height: 100)
                            .border(Color.gray.opacity(0.2), width: 1)
                        
                        Picker("Prioridade", selection: $priority) {
                            ForEach(Priority.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                    }
                }
                
                if viewModel.isLoading {
                    ProgressView("Salvando...")
                        .padding()
                } else {
                    Button("Salvar tarefa") {
                        let newTask = TodoTask(title: title, description: description, priority: priority, status: .todo)
                        Task {
                            await viewModel.saveTask(newTask)
                            dismiss()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    .disabled(title.isEmpty)
                }
            }
            .navigationTitle("Nova tarefa")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
        }
    }
    
}
