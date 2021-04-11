//
//  todosApp.swift
//  todos
//
//  Created by Mykyta Brazhynskyy on 07/04/2021.
//

import SwiftUI
import SwiftyJSON

@main 
struct todosApp: App {


    @StateObject var todos = Todos(authKey: "da")
    @StateObject var user = User()
    func initialize(){
        let group = DispatchGroup()
        var auth=user.fetchAuthKey()
        todos.setAuthKey(key: auth)
        if auth != ""{
            todos.fetchInitialTodos()
        }
    }

    @ViewBuilder func CompleteView(geometry:GeometryProxy)-> some View{
        if todos.authKey != ""{
            ViewController(todos:todos,edgesTop:geometry.safeAreaInsets.top)
        }
        else{
            LoginScreen()
        }
    }
    var body: some Scene {
        WindowGroup {

            GeometryReader { geometry in
                CompleteView(geometry:geometry)
                    .onAppear(perform: {
                      initialize()
                    })
                }
            }
    }
}
