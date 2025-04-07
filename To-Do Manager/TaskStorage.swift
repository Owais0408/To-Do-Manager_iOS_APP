//
//  TaskStorage.swift
//  To-Do Manager
//
//  Created by Owais Khan on 2025-04-06.
//

import Foundation

class TaskStorage {
    static let shared = TaskStorage()
    private let tasksKey = "tasks"
    
    func loadTasks() -> [Task] {
        if let data = UserDefaults.standard.data(forKey: tasksKey),
           let tasks = try? JSONDecoder().decode([Task].self, from: data) {
            return tasks
        }
        return []
    }
    
    func saveTasks(_ tasks: [Task]) {
        if let data = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(data, forKey: tasksKey)
        }
    }
}

