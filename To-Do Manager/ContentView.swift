//
//  ContentView.swift
//  To-Do Manager
//
//  Created by Owais Khan on 2025-04-06.
//

import SwiftUI

struct ContentView: View {
    @State private var tasks = TaskStorage.shared.loadTasks()

    var body: some View {
        NavigationView {
            List {
                ForEach($tasks) { $task in  // Pass Binding to each task
                    NavigationLink(destination: TaskDetailView(task: $task)) {
                        Text(task.title)
                            .foregroundColor(task.dueDate < Date() ? .red : .primary)
                    }
                }
                .onDelete(perform: deleteTask)
            }
            .navigationTitle("Tasks")
            .navigationBarItems(trailing: NavigationLink("Add Task", destination: AddTaskView(onSave: { newTask in
                tasks.append(newTask)
                TaskStorage.shared.saveTasks(tasks)
            })))
        }
    }

    // Delete task from list
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        TaskStorage.shared.saveTasks(tasks) // Save updated task list after deletion
    }
}
