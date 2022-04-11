//
//  Model.swift
//  ThesisTracker
//
//  Created by Irfan Izudin on 11/04/22.
//

import Foundation

struct Task: Codable {
    var id: Int
    var title: String
    var status: String
    var category: String
}

let defaults = UserDefaults.standard

var allTask: [Task] = []

let newTask = [
    Task(id: 1, title: "Bab 1", status: "notStarted", category: "book"),
    Task(id: 2, title: "Bab 2", status: "inProgress", category: "book"),
    Task(id: 3, title: "Bab 3", status: "done", category: "book"),
    Task(id: 4, title: "Bab 4", status: "done", category: "book"),
    Task(id: 5, title: "Bab 5", status: "inProgress", category: "book"),
    Task(id: 6, title: "Developing Website", status: "done", category: "implementation"),
    Task(id: 7, title: "Build frontend page", status: "done", category: "implementation"),
    Task(id: 8, title: "Connecting to backed", status: "done", category: "implementation"),
    Task(id: 9, title: "Create restfull api", status: "done", category: "implementation"),
    Task(id: 11, title: "Designing hardware", status: "notStarted", category: "implementation"),
    Task(id: 12, title: "Designing system", status: "done", category: "book"),
    Task(id: 13, title: "Desk Research", status: "notStarted", category: "implementation"),
    Task(id: 14, title: "Form Survey", status: "notStarted", category: "implementation"),
]

func getData (){
    if let savedUserData = defaults.object(forKey: "task") as? Data {
        let decoder = JSONDecoder()
        if let savedUser = try? decoder.decode([Task].self, from: savedUserData) {
            allTask = savedUser
            print(allTask)
        }
    }
}

