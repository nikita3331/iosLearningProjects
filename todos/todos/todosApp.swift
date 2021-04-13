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


    @StateObject var todos = Todos(authKey: "")
    @StateObject var user = User()
    @State private var selection: String? = "Login"

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
            NavigationView {
               VStack {
                    NavigationLink(destination: LoginScreen(selection:$selection)
                                    .environmentObject(user)
                                    .environmentObject(todos)
                                    .navigationBarBackButtonHidden(true), tag: "Login", selection: $selection) {
                        
//                       Text("dd")
                    }
                    NavigationLink(destination:
                                    SignupScreen(selection:$selection)
                                        .environmentObject(user)
                                        .navigationBarBackButtonHidden(true)
                                    , tag: "SignUp", selection: $selection) { EmptyView() }
                }
            }

//            LoginScreen(selection:$selection).environmentObject(user)
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
