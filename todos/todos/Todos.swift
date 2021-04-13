//
//  Todos.swift
//  todos
//
//  Created by Mykyta Brazhynskyy on 07/04/2021.
//

import Foundation
import SwiftyJSON

struct Todo{
    var title:String
    var id:String
    var picked:Bool
    var description:String
    var category:String
}
struct LoginResponse:Decodable{
    var reason:Int
    var success:Int
    var authKey:String?
}
class Todos :ObservableObject{
    @Published var todos:[Todo]=[]
    @Published var authKey:String = ""
    var baseUrl:String="https://madsprtest.herokuapp.com/"
    var api=API()
    @Published var isLoading:Bool=false
    private func findIndex(id:String)->Int{
        let index = self.todos.firstIndex(where: { (item) -> Bool in
          item.id == id // test if this is the item you're looking for
        })
        if let newIndex = index{
            return newIndex
        }
        else{
            return 0
        }
    }
    public func setPickedTodo(id:String){
        let index=findIndex(id: id)
        todos[index].picked = !todos[index].picked
        
        for (idx,todo) in todos.enumerated() {
            if (idx != index && todos[idx].picked){
                todos[idx].picked = !todos[idx].picked
            }
        }
    }
    public func setAuthKey(key:String){
        DispatchQueue.main.async {
            self.authKey=key
            self.api.setAuthKey(auth: key)
        }

    }
    public func removeTodo(id:String){
        self.isLoading=true
        let group = DispatchGroup()
        group.enter()
        api.removeTodo(id:id){
            (suc) in
            group.leave()
        }
        group.wait()
        group.enter()
        fetchTodos(){
            group.leave()
        }
        group.wait()
        self.isLoading=false

 

    }
    public func addTodo(title:String,desc:String,cat:String){
        DispatchQueue.main.async {
            self.isLoading=true
        }
       let group = DispatchGroup()
        group.enter()
        api.addTodo(title: title, desc: desc){
            (suc) in
            group.leave()
        }
        group.wait()
        group.enter()

        fetchTodos(){
            group.leave()
        }
        group.wait()
        DispatchQueue.main.async {
            self.isLoading=false
        }

    }



    private func parseTodos(jsonTodos:JSON){
        var dummy:[Todo]=[]

        for (index,todo) in jsonTodos.arrayValue.enumerated() {
            let tit = todo["title"].string!
            let desc = todo["description"].string!
            let category = todo["category"].string!
            let id = todo["_id"].string!
            let newTodo=Todo(title: tit, id: id, picked: false, description: desc,category: category)
            dummy.append(newTodo)
        }
        DispatchQueue.main.async {
            self.todos=dummy
        }
    }
    private func fetchTodos(completionBlock: @escaping () -> Void) {

       let group = DispatchGroup()
        group.enter()
        self.api.fetchTodos(authKey:self.authKey){
            (todoss) in
            self.parseTodos(jsonTodos: todoss)
            completionBlock();
            group.leave()
        }
        group.wait()

       //anything after this point won't execute until we get a result from someAsyncFunction()
    }
    public func fetchInitialTodos(){
        DispatchQueue.main.async {
            self.isLoading=true
        }
        fetchTodos(){
            DispatchQueue.main.async {
                self.isLoading=false
            }
        }
    }
    init(authKey: String){
        if !authKey.isEmpty{
            self.authKey=authKey
            fetchInitialTodos()
        }

    }
}
