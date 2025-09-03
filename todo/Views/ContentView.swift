//
//  ContentView.swift
//  todo
//
//  Created by Ana Carolina on 02/09/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var tasks: [TodoTask]
    
    @State private var viewModel: TaskViewModel?
    
    @State private var showingAddView = false
    @State private var draggedTask: TodoTask?
    
    init() {
        _viewModel = State(initialValue: TaskViewModel(modelContext: ModelContext(try! ModelContainer(for: TodoTask.self))))
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView(.horizontal) {
                    HStack(spacing: 16) {
                        KanbanColumn(title: "To Do", status: .todo, tasks: filteredTasks(status: .todo), viewModel: viewModel!, draggedTask: $draggedTask)
                        KanbanColumn(title: "Doing", status: .doing, tasks: filteredTasks(status: .doing), viewModel: viewModel!, draggedTask: $draggedTask)
                        KanbanColumn(title: "Done", status: .done, tasks: filteredTasks(status: .done), viewModel: viewModel!, draggedTask: $draggedTask)
                    }
                    .padding()
                }
                Button(action: {showingAddView = true}) {
                    Image(systemName: "plus")
                        .font(.title.weight(.semibold))
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 8)
                }
                .padding()
            }
        }
        .navigationTitle("Minhas tarefas")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingAddView) {
            AddTaskView(viewModel: viewModel!)
        }
    }
    
    private func filteredTasks(status: Status) -> [TodoTask] {
        tasks.filter { $0.status == status }
    }

}

#Preview {
    ContentView()
        .modelContainer(for: TodoTask.self, inMemory: true)
}
