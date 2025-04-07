//
//  AddTaskView.swift
//  To-Do Manager
//
//  Created by Owais Khan on 2025-04-06.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @State private var category = ""
    @State private var priority = "Medium"
    
    var onSave: (Task) -> Void

    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Description", text: $description)
            DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            TextField("Category", text: $category)
            Picker("Priority", selection: $priority) {
                Text("Low").tag("Low")
                Text("Medium").tag("Medium")
                Text("High").tag("High")
            }
            Button("Save Task") {
                let newTask = Task(title: title, description: description, dueDate: dueDate, category: category, priority: priority, completionStatus: false)
                onSave(newTask)
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationTitle("Add Task")
    }
}
