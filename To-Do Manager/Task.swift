//
//  Task.swift
//  To-Do Manager
//
//  Created by Owais Khan on 2025-04-06.
//
import Foundation

struct Task: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var dueDate: Date
    var category: String
    var priority: String
    var completionStatus: Bool
}

