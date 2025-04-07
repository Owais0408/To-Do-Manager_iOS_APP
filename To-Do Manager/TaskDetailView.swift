import SwiftUI

struct TaskDetailView: View {
    @Binding var task: Task  // Use Binding to allow modification
    @Environment(\.presentationMode) var presentationMode
    @State private var showDeleteAlert = false
    @State private var tasks = TaskStorage.shared.loadTasks()

    var body: some View {
        VStack {
            Text("Title: \(task.title)")
            Text("Description: \(task.description)")
            Text("Due Date: \(task.dueDate, formatter: dateFormatter)")
            Text("Category: \(task.category)")
            Text("Priority: \(task.priority)")
            Text("Completion Status: \(task.completionStatus ? "Completed" : "Incomplete")")
            
            // Mark as complete button
            Button("Mark as Complete") {
                task.completionStatus = true
                TaskStorage.shared.saveTasks(tasks) // Save after completion
                presentationMode.wrappedValue.dismiss() // Go back after completion
            }
            
            // Delete Task Button
            Button("Delete Task") {
                showDeleteAlert = true // Show confirmation alert
            }
        }
        .navigationTitle(task.title)
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("Are you sure?"),
                message: Text("This task will be permanently deleted."),
                primaryButton: .destructive(Text("Delete")) {
                    deleteTask()  // Call delete function if confirmed
                },
                secondaryButton: .cancel()
            )
        }
    }

    // Function to delete task
    func deleteTask() {
        var tasks = TaskStorage.shared.loadTasks()
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: index) // Remove the task from the list
            TaskStorage.shared.saveTasks(tasks) // Save updated tasks list
            presentationMode.wrappedValue.dismiss() // Dismiss the task detail view
        }
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()
