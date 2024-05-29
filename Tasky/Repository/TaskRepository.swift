//
//  TaskRepository.swift
//  Tasky
//
//  Created by Giovanna Moeller on 29/05/24.
//

import Foundation

class TaskRepository {
    init() {} 
    
    var tasks: [Task] = []
    
    func addTask(newTask: Task) {
        tasks.append(newTask)
    }
    
    func completeTask(at index: Int) {
        guard index >= 0, index < tasks.count else { return }
        tasks[index].isCompleted.toggle()
    }
    
    func removeTask(at index: Int) {
        guard index >= 0, index < tasks.count else { return }
        tasks.remove(at: index)
    }
}
