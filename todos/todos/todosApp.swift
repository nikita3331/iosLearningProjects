//
//  todosApp.swift
//  todos
//
//  Created by Mykyta Brazhynskyy on 07/04/2021.
//

import SwiftUI

@main
struct todosApp: App {
    @StateObject var todos = Todos()
    @StateObject var user = User()

    var body: some Scene {
        WindowGroup {
            TabView{
                AllTodos()
                    .tabItem {
                        Image(systemName:"airplane.circle.fill")
                        Text("All")
                    }
                AddTodos()
                    .tabItem {
                        Image(systemName:"airplane.circle.fill")
                        Text("Add")
                    }
                
            }
            .environmentObject(todos)
        }
    }
}
