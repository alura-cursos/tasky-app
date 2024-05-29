//
//  Task.swift
//  Tasky
//
//  Created by Giovanna Moeller on 28/05/24.
//

import Foundation

struct Task {
    var title: String
    var description: String?
    var isCompleted: Bool = false
}

var tasks: [Task] = [
    Task(title: "Fazer café"),
    Task(title: "Estudar Swift", description: "MVC"),
    Task(title: "Fazer trabalho da faculdade")
]
